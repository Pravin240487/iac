provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
  assume_role {
    role_arn = var.role_arn
  }
}

data "aws_acm_certificate" "useast1" {
  provider = aws.useast1
  domain   = var.environment != "prd" ? "*.${var.environment}.octonomy.ai" : "*.octonomy.ai"
  statuses = ["ISSUED"]
}
