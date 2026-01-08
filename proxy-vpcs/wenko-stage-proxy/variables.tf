variable "region" {
  description = "AWS region to create the resources"
  type        = string
  default     = "eu-central-1"
}

variable "role_arn" {
  description = "Role ARN to assume"
  type        = string
}

variable "cidr_block" {
  description = "cidr value is for the subnet"
  type        = string
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    Name = string
    key  = string
  }))
}

variable "private_subnets" {
  type = list(object({
    cidr = string
    az   = string
    Name = string
    key  = string
  }))
}

variable "nat_subnet_index" {
  description = "Subnet index number for the nat"
  type        = number
}

variable "nat_name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "environment" {
  description = "The environment in which the instances are being deployed. Typical values are 'prod', 'dev', or 'test'."
  type        = string
}

variable "vpc_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = { Terraformed = "true"
    Owner = "Octonomy.devops@talentship.io"
  }
}

variable "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarms"
  type        = string
  default     = null
}