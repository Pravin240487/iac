terraform {
  required_version = "> 1.5.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }

  backend "s3" {
    bucket         = "qs-terraform-remote-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    region         = "eu-central-1"
  }
}