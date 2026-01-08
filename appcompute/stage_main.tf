
module "sftp_customer0007" {
  source                = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/sftp/1.0.0"
  sftp_logging_policy   = "qs-${var.environment}-ec1-sftp-logging-policy-v1"
  sftp_logging_iam_role = "qs-${var.environment}-ec1-sftp-logging-role-v1"
  sftp_log_group_name   = "qs-${var.environment}-ec1-sftp-log-group-v1"
  tags                  = var.tags

}
module "sftp_user_customer0007" {
  source           = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/sftp_user/1.0.0"
  sftp_user_policy = "qs-${var.environment}-ec1-sftp-user-policy-v1"
  sftp_user_role   = "qs-${var.environment}-ec1-sftp-user-role-v1"
  customer_prefix  = var.customer_prefix
  sftp_bucket_name = var.sftp_bucket_name
  users            = var.sftp_customer0007_users
  server_id        = module.sftp_customer0007.id
  tags             = var.tags
  depends_on       = [module.sftp_customer0007]
}