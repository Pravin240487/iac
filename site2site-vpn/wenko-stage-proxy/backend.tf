terraform {
  required_version = "> 1.5.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.89.0, <= 6.5.0"
    }
  }

  backend "s3" {
    bucket         = "qs-terraform-remote-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    region         = "eu-central-1"
    key            = "site2site-vpn/wenko-stage-proxy/terraform.tfstate"
  }
}

