provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.role_arn
  }
}

data "terraform_remote_state" "shared" {
  backend = "s3"

  config = {
    bucket = "qs-terraform-remote-state"
    key    = "global/app/terraform.tfstate"
    region = "eu-central-1"
  }
}