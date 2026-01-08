terraform {
  required_version = "> 1.5.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.89.0, <= 6.5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1" # You can adjust to the exact version needed
    }

  }

  backend "s3" {
    bucket         = "qs-terraform-remote-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    region         = "eu-central-1"
  }
}
