variable "region" {
  description = "AWS region to create the resources"
  type        = string
  default     = "eu-central-1"
}

variable "role_arn" {
  description = "Role ARN to assume"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, stage, prod, etc.)"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Terraformed = "true"
    Owner       = "Octonomy.devops@talentship.io"
  }
}

#################################
########   Envoy Proxy   #######
#################################

variable "vpc_id" {
  description = "VPC ID where the Envoy proxy will be deployed. If not provided, will use the VPC ID from proxy-vpcs/wenko-stage-proxy remote state"
  type        = string
  default     = null
}

variable "envoy_subnet_id" {
  description = "Subnet ID for the Envoy EC2 instance. If not provided, will use the first available public subnet from the VPC (allows direct SSH access)"
  type        = string
  default     = null
}

variable "nlb_subnet_ids" {
  description = "List of subnet IDs for the Network Load Balancer (should span multiple AZs). If not provided, will use all private subnets from the VPC"
  type        = list(string)
  default     = []
}

variable "envoy_ami_id" {
  description = "AMI ID for the Envoy proxy EC2 instance"
  type        = string
}

variable "envoy_instance_name" {
  description = "Name for the Envoy proxy EC2 instance"
  type        = string
  default     = "envoy-mtls-proxy"
}

variable "nlb_name" {
  description = "Name for the Network Load Balancer"
  type        = string
  default     = "envoy-nlb"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH to the Envoy instance"
  type        = string
}

variable "allowed_admin_cidr" {
  description = "CIDR block allowed to access the Envoy admin interface"
  type        = string
}

variable "envoy_config" {
  description = "Optional Envoy configuration file path. If not provided, module will use default configuration"
  type        = string
  default     = null
}

variable "endpoint_service_name" {
  description = "Name for the VPC endpoint service. If not provided, defaults to nlb_name-ep-svc"
  type        = string
  default     = null
}

variable "appcompute_state_key" {
  description = "Terraform state key path for appcompute (e.g., 'stage/terraform.tfstate')"
  type        = string
  default     = "stage/terraform.tfstate"
}

variable "appcompute_vpc_name" {
  description = "Name of the appcompute VPC (e.g., 'qs-stg-ec1-main-vpc-v1'). If not provided, will default based on environment"
  type        = string
  default     = null
}

variable "upstream_host" {
  description = "Upstream ALB/API hostname, e.g. api.internal.poc.octonomy.ai"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the key pair to use for the Envoy instance"
  type        = string
  default     = null
}

variable "vpc_endpoint_subnet_names" {
  description = "List of subnet names to use for VPC endpoint in consumer VPC. If provided, will use these specific subnets instead of auto-discovering by tags"
  type        = list(string)
  default     = []
}

variable "egress_block_list" {
  description = "List of CIDR blocks allowed to egress from the Envoy instance"
  type        = list(string)
}

variable "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarms"
  type        = string
  default     = null
}

variable "cw_log_group_name" {
  description = "Name of the CloudWatch log group for the Envoy proxy"
  type        = string
}