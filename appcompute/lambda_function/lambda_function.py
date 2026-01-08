import json
import boto3
import datetime
import os

rds_client = boto3.client('rds')

def lambda_handler(event, context):
    db_instance_identifier_list = (os.environ["RDS_INSTANCE_ID"]).split(",")
    retention_period = int(os.environ["RETENTION_PERIOD"])
    try:
        for db_instance_identifier in db_instance_identifier_list:
            current_date = datetime.datetime.now()
            snapshot_identifier = f"{db_instance_identifier}-{current_date.strftime('%Y-%m-%d-%H-%M-%S')}"
            #Create snapshot
            try:
                print(f"Creating snapshot for RDS instance: {db_instance_identifier}...")
                snapshot_response = rds_client.create_db_snapshot(
                    DBSnapshotIdentifier=snapshot_identifier,
                    DBInstanceIdentifier=db_instance_identifier
                )
                print(f"Snapshot created successfully: {snapshot_response['DBSnapshot']['DBSnapshotIdentifier']}")
            except Exception as e:
                print(f"Error creating RDS snapshot: {e}")
                return {
                    'statusCode': 500,
                    'body': json.dumps(f"Error creating RDS snapshot: {str(e)}")
                }
            #Delete old snapshot based on the retention period
            try:
                snapshots = rds_client.describe_db_snapshots(DBInstanceIdentifier=db_instance_identifier)['DBSnapshots']
                for snapshot in snapshots:
                    snapshot_id = snapshot['DBSnapshotIdentifier']
                    if snapshot_id != snapshot_identifier:
                        snapshot_create_time = snapshot['SnapshotCreateTime']
                        snapshot_age_days = (current_date - snapshot_create_time.replace(tzinfo=None)).days
                        if snapshot_age_days > retention_period:
                            print(f"Deleting old snapshot: {snapshot_id} (Age: {snapshot_age_days} days)")
                            rds_client.delete_db_snapshot(DBSnapshotIdentifier=snapshot_id)
                            print(f"Snapshot {snapshot_id} deleted successfully.")
                        else:
                            print(f"Snapshot {snapshot_id} is within the retention period, no action needed.")
            except Exception as e:
                print(f"Error deleting old snapshots: {e}")
    except Exception as e:
        print(f"Error creating RDS snapshot: {e}")
    return {
        'statusCode': 200,
        'body': json.dumps(f"Snapshot Lambda Ran successfully.")
    }
