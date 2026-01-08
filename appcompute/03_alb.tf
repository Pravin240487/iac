module "alb_logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/s3/1.0.0"

  bucket_name             = "qs-${var.environment}-${var.region_suffix}-alb-logs-s3-${var.project_version}"
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  bucket_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AWSLogDeliveryWrite",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:PutObject",
        "Resource" : ["arn:aws:s3:::qs-${var.environment}-${var.region_suffix}-alb-logs-s3-${var.project_version}/*", ]
        "Condition" : {
          "StringEquals" : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        "Sid" : "AWSLogDeliveryAclCheck",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetBucketAcl",
        "Resource" : "arn:aws:s3:::qs-${var.environment}-${var.region_suffix}-alb-logs-s3-${var.project_version}"
      }
    ]
  })
  tags = var.tags
}

module "octonomy_acm" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/acm/1.0.0"

  domain_name      = var.environment == "prd" ? "*.octonomy.ai" : "*.${var.environment}.octonomy.ai"
  hosted_zone_name = var.environment == "prd" ? "octonomy.ai" : "${var.environment}.octonomy.ai"
  tags             = var.tags
}

module "octonomy_com_acm" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/acm/1.0.0"
  count  = var.environment == "prd" ? 1 : 0

  domain_name      = "*.octonomy.com"
  subject_alternative_names = ["octonomy.com"]  # Add additional domains here
  hosted_zone_name = "octonomy.com"
  tags             = var.tags
}

module "octonomy_de_acm" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/acm/1.0.0"
  count  = var.environment == "prd" ? 1 : 0

  domain_name      = "*.octonomy.de"
  subject_alternative_names = ["octonomy.de"]  # Add additional domains here
  hosted_zone_name = "octonomy.de"
  tags             = var.tags
}

module "internal_acm" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/acm/1.0.0"

  domain_name      = var.environment == "prd" ? "*.internal.octonomy.ai" : "*.internal.${var.environment}.octonomy.ai"
  hosted_zone_name = var.environment == "prd" ? "internal.octonomy.ai" : "internal.${var.environment}.octonomy.ai"
  tags             = var.tags
}

module "wss_acm" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/acm/1.0.0"

  domain_name      = var.environment == "prd" ? "*.wss.octonomy.ai" : "*.${var.environment}.wss.octonomy.ai"
  hosted_zone_name = var.environment == "prd" ? "wss.octonomy.ai" : "${var.environment}.wss.octonomy.ai"
  tags             = var.tags
}

# data "aws_acm_certificate" "public" {
#   domain   = var.environment == "prd" ? "*.octonomy.ai" : "*.${var.environment}.octonomy.ai"
#   statuses = ["ISSUED"]
#   most_recent = true
# }

# data "aws_acm_certificate" "private" {
#   domain   = var.environment == "prd" ? "*.internal.octonomy.ai" : "*.internal.${var.environment}.octonomy.ai"
#   statuses = ["ISSUED"]
#   most_recent = true
# }

# data "aws_acm_certificate" "wss" {
#   domain   = var.environment == "prd" ? "*.wss.octonomy.ai" : "*.${var.environment}.wss.octonomy.ai"
#   statuses = ["ISSUED"]
#   most_recent = true
# }

module "public_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/alb/1.0.0"

  load_balancer_name = "qs-${var.environment}-${var.region_suffix}-main-alb-${var.project_version}"
  internal           = false
  vpc_id             = module.vpc.vpc_id
  subnets            = var.public_alb_subnet_ids
  # certificate_arn            = data.aws_acm_certificate.public.arn
  certificate_arn            = module.octonomy_acm.arn
  enable_waf                 = true
  web_acl_arn                = aws_wafv2_web_acl.this.arn
  enable_deletion_protection = var.enable_deletion_protection
  enable_access_logs         = true
  access_logs_s3_bucket_id   = module.alb_logs.id
  log_prefix                 = "qs-${var.environment}-${var.region_suffix}-main-alb-${var.project_version}"

  tags = var.tags
}

module "internal_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/alb/1.0.0"

  load_balancer_name = "qs-${var.environment}-${var.region_suffix}-main-ilb-${var.project_version}"
  vpc_id             = module.vpc.vpc_id
  subnets            = var.private_alb_subnet_ids
  # certificate_arn            = data.aws_acm_certificate.private.arn
  certificate_arn            = module.internal_acm.arn
  enable_deletion_protection = var.enable_deletion_protection
  enable_access_logs         = true
  access_logs_s3_bucket_id   = module.alb_logs.id
  log_prefix                 = "qs-${var.environment}-${var.region_suffix}-main-ilb-${var.project_version}"
  idle_timeout               = 300

  tags = var.tags
}

module "wss_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/alb/1.0.0"

  load_balancer_name = "qs-${var.environment}-${var.region_suffix}-wss-alb-${var.project_version}"
  internal           = false
  vpc_id             = module.vpc.vpc_id
  subnets            = var.public_alb_subnet_ids
  # certificate_arn            = data.aws_acm_certificate.wss.arn
  certificate_arn            = module.wss_acm.arn
  enable_waf                 = true
  web_acl_arn                = aws_wafv2_web_acl.this.arn
  enable_deletion_protection = var.enable_deletion_protection
  enable_access_logs         = true
  access_logs_s3_bucket_id   = module.alb_logs.id
  log_prefix                 = "qs-${var.environment}-${var.region_suffix}-wss-alb-${var.project_version}"
  idle_timeout               = 1800

  tags = var.tags
}

variable "enable_deletion_protection" {
  description = "Enable or disable deletion protection for the load balancer"
  type        = bool
  default     = true
}