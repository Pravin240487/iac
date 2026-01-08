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
########   Site2Site VPN  #######
#################################

variable "vpc_id" {
  description = "VPC ID where the VPN will be attached. If not provided, will use the VPC ID from proxy-vpcs/wenko-stage-proxy remote state"
  type        = string
  default     = null
}

variable "vpn_gateway_name" {
  description = "Name for the Virtual Private Gateway"
  type        = string
  default     = "main-vpg"
}

variable "customer_gateway_ip" {
  description = "Public IP address of the customer gateway"
  type        = string
}

variable "customer_gateway_bgp_asn" {
  description = "BGP ASN of the customer gateway"
  type        = number
  default     = 65000
}

variable "destination_cidr_blocks" {
  description = "List of CIDR blocks to route through the VPN (required if static_routes_only is true)"
  type        = list(string)
  default     = []
}

variable "route_table_ids" {
  description = "List of route table IDs to propagate VPN routes to. If not provided, will use route table IDs from proxy-vpcs/wenko-stage-proxy remote state"
  type        = list(string)
  default     = []
}

variable "static_routes_only" {
  description = "Whether to use static routing only (true) or BGP (false)"
  type        = bool
  default     = false
}

variable "tunnel1_inside_cidr" {
  description = "CIDR block for tunnel 1 inside IP addresses"
  type        = string
  default     = null
}

variable "tunnel2_inside_cidr" {
  description = "CIDR block for tunnel 2 inside IP addresses"
  type        = string
  default     = null
}

variable "tunnel1_preshared_key" {
  description = "Pre-shared key for tunnel 1"
  type        = string
  default     = null
  sensitive   = true
}

variable "tunnel2_preshared_key" {
  description = "Pre-shared key for tunnel 2"
  type        = string
  default     = null
  sensitive   = true
}

variable "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarms"
  type        = string
  default     = null
}

