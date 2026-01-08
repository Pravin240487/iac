data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "this" {
  name        = "oc-${var.environment}-${var.region_suffix}-cwr-iam-cloudwatch-logs-export-limited-policy"
  description = "This policy is for oc-${var.environment}-${var.region_suffix}-cwr-iam-role-${var.project_version}"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "CloudWatchLogsExportLimited",
        "Effect" : "Allow",
        "Action" : [
          "logs:DescribeLogGroups",
          "logs:DescribeExportTasks",
          "logs:CreateExportTask",
          "logs:FilterLogEvents"
        ],
        "Resource" : "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:*"
      },
      {
        "Sid" : "S3AccessLimited",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource" : "${module.cwr_s3_bucket.arn}/*"
      },
      {
        "Sid" : "S3ListAccess",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::oc-${var.environment}-${var.region_suffix}-cloud-watch-logs-s3-${var.project_version}"
      },
      {
        "Sid" : "LambdaOwnLogging",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/oc-${var.environment}-${var.region_suffix}-cwr-lambda-${var.project_version}"
      }
    ]
  })
}

module "cwr_aws_iam_role" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name      = "oc-${var.environment}-${var.region_suffix}-cwr-iam-role-${var.project_version}"
  assume_role_policy = data.aws_iam_policy_document.this.json
  iam_role_policy_attachments = [
    resource.aws_iam_policy.this.arn
  ]
  tags = var.tags
}

module "cwr_s3_bucket" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/s3/1.0.0"

  bucket_name = "oc-${var.environment}-${var.region_suffix}-cloud-watch-logs-s3-${var.project_version}"
  bucket_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowCloudWatchLogsToWrite",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "logs.eu-central-1.amazonaws.com"
        },
        "Action" : [
          "s3:GetBucketAcl",
          "s3:PutObject"
        ],
        "Resource" : [
          "arn:aws:s3:::oc-${var.environment}-${var.region_suffix}-cloud-watch-logs-s3-${var.project_version}",
          "arn:aws:s3:::oc-${var.environment}-${var.region_suffix}-cloud-watch-logs-s3-${var.project_version}/*"
        ]
      }
    ]
  })
  tags = var.tags
}


resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = module.cwr_s3_bucket.id

  rule {
    id     = "transition_to_standard_IA_then_glacier_instant_retrieval"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 90
      storage_class = "GLACIER_IR"
    }
  }

  rule {
    id     = "delete_objects_after_150_days"
    status = "Enabled"

    expiration {
      days = 150
    }
  }
}

module "cwr_lambda" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/lambda/1.0.0"

  function_name  = "oc-${var.environment}-${var.region_suffix}-cwr-lambda-${var.project_version}"
  lambda_runtime = "python3.11"
  lambda_handler = "cloud_watch_retention.lambda_handler"
  role_arn       = module.cwr_aws_iam_role.arn

  # Deploy via ZIP package (set create_ecr_lambda = false)
  create_ecr_lambda = false
  create_iam_role   = false

  # Lambda configuration
  timeout      = 900
  memory_size  = 128
  package_type = "Zip"

  # Source code packaging
  source_dir        = "${path.module}/lambda_function/cloudwatch"
  output_path       = "${path.module}/lambda_function.zip"
  archive_file_type = "zip"

  environment_variables = {
    S3_BUCKET_NAME = "oc-${var.environment}-${var.region_suffix}-cloud-watch-logs-s3-${var.project_version}"
  }

  tags = var.tags
}

# CloudWatch Event rule for scheduling
resource "aws_cloudwatch_event_rule" "this" {
  name                = "oc-${var.region}-${var.region_suffix}-cwr_schedule_rule-${var.project_version}"
  description         = "Run Lambda at 00:30 and 23:30 every day"
  schedule_expression = "cron(30 0,23 * * ? *)"
}

# Add the Lambda as a target for the schedule
resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "lambda_target"
  arn       = module.cwr_lambda.lambda_arn[0]
}

# Allow EventBridge to invoke the Lambda
resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = "oc-${var.environment}-${var.region_suffix}-cwr-lambda-${var.project_version}"
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}