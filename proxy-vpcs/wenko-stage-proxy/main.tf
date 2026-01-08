provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.role_arn
  }
}

module "vpc" {
  source           = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//vpc?archive=zip"
  cidr_block       = var.cidr_block
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  nat_subnet_index = var.nat_subnet_index
  nat_name         = var.nat_name
  vpc_name         = var.vpc_name
  environment      = var.environment
  tags             = var.vpc_tags
}

//END=VPC

data "aws_route_tables" "this" {
  vpc_id = module.vpc.vpc_id
}
