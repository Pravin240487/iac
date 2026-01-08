import boto3
from datetime import datetime, timedelta, timezone
import time
import re
import json
import os
import botocore.exceptions
import threading
from queue import Queue

# --- CONFIGURATION (via environment variables) ---
S3_BUCKET_NAME = os.getenv("S3_BUCKET_NAME")
STATE_KEY = os.getenv("STATE_KEY", "last_export_state.json")
REGION = os.getenv("AWS_REGION", "eu-central-1")

WAIT_INTERVAL = int(os.getenv("WAIT_INTERVAL", "15"))
RETRY_DELAY = int(os.getenv("RETRY_DELAY", "5"))
MAX_RETRIES = int(os.getenv("MAX_RETRIES", "5"))
DATA_CHECK_WORKERS = int(os.getenv("DATA_CHECK_WORKERS", "5"))

# --- DATE RANGE: 84 DAYS AGO (00:00–23:59 UTC) ---
target_date = datetime.now(timezone.utc).date() - timedelta(days=84)
start_time_dt = datetime.combine(target_date, datetime.min.time(), tzinfo=timezone.utc)
end_time_dt = start_time_dt + timedelta(days=1)
start_time = int(start_time_dt.timestamp() * 1000)
end_time = int(end_time_dt.timestamp() * 1000)

print(f"\n🕓 Exporting logs for {target_date} (84 days ago)")
print(f"   Time range : {start_time_dt} → {end_time_dt}\n")

# --- SETUP CLIENTS ---
logs_client = boto3.client("logs", region_name=REGION)
s3_client = boto3.client("s3", region_name=REGION)

# --- STATE HANDLING ---
def load_state():
    """Load state from S3 or reset if new day (based on target_date)."""
    try:
        obj = s3_client.get_object(Bucket=S3_BUCKET_NAME, Key=STATE_KEY)
        state = json.loads(obj["Body"].read())
        if state.get("date") != str(target_date):
            print("🆕 New target date detected — resetting state.")
            return {"last_completed": None, "status": None, "date": str(target_date)}
        return state
    except s3_client.exceptions.NoSuchKey:
        return {"last_completed": None, "status": None, "date": str(target_date)}
    except botocore.exceptions.ClientError:
        return {"last_completed": None, "status": None, "date": str(target_date)}

def save_state(state):
    """Save state to S3."""
    s3_client.put_object(
        Bucket=S3_BUCKET_NAME,
        Key=STATE_KEY,
        Body=json.dumps(state, indent=2).encode("utf-8"),
    )

# --- CLOUDWATCH HELPERS ---
def list_log_groups():
    log_groups = []
    paginator = logs_client.get_paginator("describe_log_groups")
    for page in paginator.paginate():
        for lg in page.get("logGroups", []):
            log_groups.append(lg["logGroupName"])
    print(f"✅ Found {len(log_groups)} log groups.\n")
    return log_groups

def log_group_has_data(log_group_name):
    """Check if a log group has data in the given range."""
    try:
        resp = logs_client.filter_log_events(
            logGroupName=log_group_name, startTime=start_time, endTime=end_time, limit=1
        )
        return bool(resp.get("events"))
    except botocore.exceptions.ClientError:
        return False

def get_active_export_tasks():
    tasks = logs_client.describe_export_tasks()["exportTasks"]
    return [t for t in tasks if t["status"]["code"] in ["PENDING", "RUNNING"]]

def wait_for_available_slot():
    """Wait until no other export task is running."""
    while True:
        active = get_active_export_tasks()
        if not active:
            return
        task = active[0]
        print(f"⏳ Waiting for task: {task.get('taskName')} ({task['status']['code']})")
        time.sleep(WAIT_INTERVAL)

def safe_create_export_task(**kwargs):
    """Retry-safe export task creation."""
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            return logs_client.create_export_task(**kwargs)
        except logs_client.exceptions.LimitExceededException:
            print("⚠️ Export limit hit. Waiting before retry...")
            time.sleep(WAIT_INTERVAL)
        except botocore.exceptions.ClientError as e:
            if "Throttling" in str(e):
                print(f"⚠️ Throttled ({attempt}/{MAX_RETRIES}). Retrying...")
                time.sleep(RETRY_DELAY)
            else:
                raise
    raise RuntimeError("Failed to create export task after multiple retries.")

def export_log_group(log_group_name):
    """Export one log group to S3."""
    safe_name = re.sub(r"^/+", "", log_group_name.replace("/", "_"))
    s3_prefix = f"{target_date.year}/{target_date.month:02d}/{target_date.day:02d}/{safe_name}"
    task_name = f"ExportLogs-{safe_name}-{target_date.strftime('%Y%m%d')}"

    wait_for_available_slot()
    print(f"🚀 Exporting: {log_group_name} → s3://{S3_BUCKET_NAME}/{s3_prefix}")

    try:
        resp = safe_create_export_task(
            taskName=task_name,
            logGroupName=log_group_name,
            fromTime=start_time,
            to=end_time,
            destination=S3_BUCKET_NAME,
            destinationPrefix=s3_prefix,
        )
        task_id = resp["taskId"]

        while True:
            info = logs_client.describe_export_tasks(taskId=task_id)["exportTasks"][0]
            status = info["status"]["code"]
            print(f"   → {safe_name}: {status}")
            if status in ["COMPLETED", "FAILED", "CANCELLED"]:
                return status
            time.sleep(WAIT_INTERVAL)

    except botocore.exceptions.ClientError as e:
        print(f"❌ Export failed for {log_group_name}: {e}")
        return "FAILED"

# --- MULTITHREAD DATA CHECK ---
def check_data_worker(queue, results):
    """Thread worker to check for log data availability."""
    while True:
        log_group = queue.get()
        if log_group is None:
            break
        results[log_group] = log_group_has_data(log_group)
        queue.task_done()

# --- SELF-HEALING RESUME CHECK ---
def handle_in_progress_state(state):
    """Resume safely if previous run stopped mid-export."""
    last_group = state.get("last_completed")
    if not last_group or state.get("status") != "IN_PROGRESS":
        return state

    print(f"🔍 Checking last in-progress export for: {last_group}")
    tasks = logs_client.describe_export_tasks()["exportTasks"]

    for t in tasks:
        if last_group in t.get("taskName", ""):
            status = t["status"]["code"]
            print(f"   → Previous task status: {status}")

            if status == "COMPLETED":
                print("✅ Previous task completed successfully.")
                state["status"] = "COMPLETED"
                save_state(state)
            elif status in ["FAILED", "CANCELLED"]:
                print("⚠️ Previous task failed or cancelled — will re-export.")
                state["status"] = "FAILED"
                save_state(state)
            else:  # RUNNING or PENDING
                print("⏳ Previous task still running — waiting for completion.")
                while True:
                    info = logs_client.describe_export_tasks(taskId=t["taskId"])["exportTasks"][0]
                    st = info["status"]["code"]
                    print(f"   → {last_group}: {st}")
                    if st in ["COMPLETED", "FAILED", "CANCELLED"]:
                        print(f"✅ Task {st}. Continuing to next log group.")
                        state["status"] = st
                        save_state(state)
                        break
                    time.sleep(WAIT_INTERVAL)
            break
    return state

# --- MAIN EXECUTION ---
def run_export():
    state = load_state()
    state = handle_in_progress_state(state)
    last_completed = state.get("last_completed")
    print(f"Resuming from: {last_completed}")

    all_groups = list_log_groups()
    start_index = 0
    if last_completed and last_completed in all_groups:
        start_index = all_groups.index(last_completed) + 1
    remaining_groups = all_groups[start_index:]

    print(f"🧠 Checking which of the {len(remaining_groups)} groups have data...")

    queue = Queue()
    results = {}
    workers = []
    for _ in range(DATA_CHECK_WORKERS):
        t = threading.Thread(target=check_data_worker, args=(queue, results))
        t.start()
        workers.append(t)
    for g in remaining_groups:
        queue.put(g)
    queue.join()
    for _ in workers:
        queue.put(None)
    for t in workers:
        t.join()

    groups_with_data = [g for g, has in results.items() if has]
    groups_skipped = [g for g, has in results.items() if not has]

    print(f"✅ {len(groups_with_data)} groups have logs; ⏭️ {len(groups_skipped)} will be skipped.\n")

    exported = 0
    skipped = len(groups_skipped)
    failed = 0

    for i, log_group in enumerate(groups_with_data, start=1):
        print(f"\n===== [{i}/{len(groups_with_data)}] {log_group} =====")

        # Save state before starting export
        save_state({"last_completed": log_group, "status": "IN_PROGRESS", "date": str(target_date)})

        result = export_log_group(log_group)

        # Save completion state
        save_state({"last_completed": log_group, "status": result, "date": str(target_date)})

        if result == "COMPLETED":
            exported += 1
        elif result == "FAILED":
            failed += 1

    print("\n🎯 Export summary:")
    print(f"   ✅ Exported : {exported}")
    print(f"   ⏭️ Skipped  : {skipped}")
    print(f"   ❌ Failed   : {failed}")
    print(f"   📦 State saved to s3://{S3_BUCKET_NAME}/{STATE_KEY}\n")

# --- LAMBDA HANDLER ---
def lambda_handler(event, context):
    print("🏁 Lambda execution started...")
    run_export()
    print("✅ Lambda execution completed.")
    return {"statusCode": 200, "body": json.dumps("CloudWatch logs export completed successfully.")}