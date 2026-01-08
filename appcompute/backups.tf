# module "rds_backup_iam_policy" {
#   source                = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//iampolicy?archive=zip"
#   iam_policy_name       = "qs-${var.environment}-rds-backup-policy"
#   iam_policy_name_desc  = "Policy to allow RDS backup snapshots"
#   iam_policy_statements = [
#       {
#         Action   = [
#           "rds:DescribeDBSnapshots",
#           "rds:CreateDBSnapshot",
#           "rds:DeleteDBSnapshot",
#           "rds:AddTagsToResource",
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ]
#         Effect   = "Allow"
#         Resource = ["*"]
#       }
#     ]
# }

# resource "aws_iam_role" "rds_backup_iam_role" {
#   name               = "qs-${var.environment}-rds-backup-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       },
#     ]
#   })
#   tags          ={
#   "Project"     = "qs"
#   "Environment" = var.environment
#   "Terraformed" = true
#   "Owner"       = "Octonomy.devops@talentship.io"
#   }
# }

# resource "aws_iam_role_policy_attachment" "rds_backup_iam_policy_attach" {
#   role       = aws_iam_role.rds_backup_iam_role.name
#   policy_arn = module.rds_backup_iam_policy.arn
# }
# data "archive_file" "lambda_source" {
#   type        = "zip"
#   source_dir  = "./lambda_function"  
#   output_path = "rds_lambda_function.zip"
# }
# resource "aws_lambda_function" "rds_snapshot_function" {
#   filename         = "rds_lambda_function.zip"  
#   function_name    = "qs-${var.environment}-rds-snapshot-lambda"
#   role             = aws_iam_role.rds_backup_iam_role.arn
#   handler          = "lambda_function.lambda_handler"
#   runtime          = "python3.8"
#   timeout          = var.timeout
#   memory_size      = var.memory_size
#   source_code_hash = data.archive_file.lambda_source.output_base64sha256


#   environment {
#     variables = {
#       RDS_INSTANCE_ID = var.rds_instance_id
#       RETENTION_PERIOD = "${var.retention_period}"
#     }
#   }
#   tags          ={
#   "Project"     = "qs"
#   "Environment" = var.environment
#   "Terraformed" = true
#   "Owner"       = "Octonomy.devops@talentship.io"
#   }
# }

# module "cw_event_rule" {
#   source                = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cloudwatch_event_rule?archive=zip"
#   cw_event_rule_name    = "qs-${var.environment}-daily-rds-snapshot"
#   description           = "Trigger Lambda to create RDS snapshot every day"
#   schedule_expression   = "cron(0 15 ? * MON-FRI *)"
#   target_id             = "qs-${var.environment}-rds-snapshot-lambda-target"
#   cw_target_arn         = aws_lambda_function.rds_snapshot_function.arn
#   tags          ={
#   "Project"     = "qs"
#   "Environment" = var.environment
#   "Terraformed" = true
#   "Owner"       = "Octonomy.devops@talentship.io"
#   }
# }
# resource "aws_lambda_permission" "allow_eventbridge" {
#   statement_id  = "AllowExecutionFromEventBridge"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.rds_snapshot_function.function_name
#   principal     = "events.amazonaws.com"
# }
# ##################### EBS Backup###############################
# #  module "backup_vault" {
# #   source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/backup_vault/1.0.0"
# #   name        = "qs-${var.environment}-EBS-backup-vault"
# #   tags          ={
# #   "Project"     = "qs"
# #   "Environment" = var.environment
# #   "Terraformed" = true
# #   "Owner"       = "Octonomy.devops@talentship.io"
# #   }
# #  }
# # resource "aws_backup_plan" "ebs_backup_plan" {
# #   name = "qs-${var.environment}-EBS-snapshot-backup-plan"

# #   rule {
# #     rule_name         = "qs-${var.environment}-daily-EBS-snapshot"
# #     target_vault_name = module.backup_vault.backup_vault_name
# #     schedule          = "cron(0 15 ? * MON-FRI *)"  
# #     lifecycle {
# #       delete_after = var.retention_period
# #     }
# #   }
# # }
# # resource "aws_backup_selection" "ebs_backup_selection" {
# #   name          = "qs-${var.environment}-EBS-backup-selection"
# #   iam_role_arn  = module.aws_backup_role.arn
# #   plan_id = aws_backup_plan.ebs_backup_plan.id

# #   resources = var.ebs_volume_arns
# # }


# # module "aws_backup_role" {
# #   source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/iam/1.0.0"
# #   iam_role_name = "qs-${var.environment}-AWSBackupServiceRole"
# #   assume_role_policy = <<EOF
# # {
# #   "Version": "2012-10-17",
# #   "Statement": [
# #     {
# #       "Effect": "Allow",
# #       "Principal": {
# #         "Service": "backup.amazonaws.com"
# #       },
# #       "Action": "sts:AssumeRole"
# #     }
# #   ]
# # }
# # EOF
# #   tags          ={
# #   "Project"     = "qs"
# #   "Environment" = var.environment
# #   "Terraformed" = true
# #   "Owner"       = "Octonomy.devops@talentship.io"
# #   }
# # }
# # resource "aws_iam_policy_attachment" "aws_backup_policy_attachment" {
# #   name       = "qs-${var.environment}-aws-backup-policy"
# #   roles      = [module.aws_backup_role.name]
# #   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
# # }
