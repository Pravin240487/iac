import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # Step 1: Get S3 prefix from input
    s3_prefix = event.get('s3_prefix')
    
    if not s3_prefix:
        return {
            "exists": False,
            "message": "Missing 's3_prefix' in input"
        }

    # Step 2: Parse the bucket and prefix
    if not s3_prefix.startswith("s3://"):
        return {
            "exists": False,
            "message": "Invalid S3 URI format. Should start with 's3://'"
        }

    s3_uri = s3_prefix.replace("s3://", "")
    bucket, *prefix_parts = s3_uri.split("/", 1)
    prefix = prefix_parts[0] if prefix_parts else ""

    try:
        # Step 3: List objects under prefix
        response = s3.list_objects_v2(Bucket=bucket, Prefix=prefix)

        if "Contents" in response and len(response["Contents"]) > 0:
            return {
                "exists": True
            }
        else:
            return {
                "exists": False,
                "message": f"No files found in {s3_prefix}"
            }

    except Exception as e:
        return {
            "exists": False,
            "message": str(e)
        }
