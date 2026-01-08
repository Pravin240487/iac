provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.role_arn
  }
}

# Get VPC and subnet information from proxy-vpcs/wenko-prod-proxy remote state
data "terraform_remote_state" "proxy_vpc" {
  backend = "s3"
  config = {
    bucket         = "qs-terraform-remote-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    region         = "eu-central-1"
    key            = "proxy-vpcs/wenko-prod-proxy/terraform.tfstate"
  }
}

# Get appcompute VPC information for VPC endpoint creation
data "terraform_remote_state" "appcompute" {
  backend = "s3"
  config = {
    bucket         = "qs-terraform-remote-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    region         = "eu-central-1"
    key            = var.appcompute_state_key
  }
}

# Get appcompute VPC details - using VPC name from tfvars or remote state
data "aws_vpc" "appcompute" {
  filter {
    name   = "tag:Name"
    values = [var.appcompute_vpc_name != null ? var.appcompute_vpc_name : "qs-${var.environment}-ec1-main-vpc-v1"]
  }
}

# Get appcompute private subnets for VPC endpoint
data "aws_subnets" "appcompute_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.appcompute.id]
  }
}

# Get subnet details for all subnets in consumer VPC (for CIDR-based lookup and filtering)
data "aws_subnet" "appcompute_private" {
  for_each = toset(data.aws_subnets.appcompute_private.ids)
  id       = each.value
}

# Get all subnets in the proxy VPC
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id != null ? var.vpc_id : data.terraform_remote_state.proxy_vpc.outputs.vpc_id]
  }
}

# Get subnet details to identify public and private subnets
data "aws_subnet" "all" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}


# 1) Fetch all "private" subnets in the consumer VPC (adjust tag key/value!)
data "aws_subnets" "consumer_private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.appcompute.id]
  }

  # CHANGE THIS TAG FILTER TO MATCH YOUR ENV
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}

# 2) Get details (AZ) for each subnet so we can filter by AZ
data "aws_subnet" "consumer_private" {
  for_each = toset(data.aws_subnets.consumer_private.ids)
  id       = each.value
}

locals {
  # Public subnets (for EC2 instance - allows direct SSH access)
  public_subnet_ids = [
    for subnet in data.aws_subnet.all : subnet.id
    if subnet.map_public_ip_on_launch
  ]

  # Private subnets (for NLB - better security)
  private_subnet_ids = [
    for subnet in data.aws_subnet.all : subnet.id
    if !subnet.map_public_ip_on_launch
  ]

  # Use public subnet for Envoy EC2 instance to allow direct SSH access
  envoy_subnet_id = var.envoy_subnet_id != null ? var.envoy_subnet_id : (
    length(local.public_subnet_ids) > 0 ? local.public_subnet_ids[0] : null
  )

  # NLB should remain in private subnets for security
  nlb_subnet_ids = length(var.nlb_subnet_ids) > 0 ? var.nlb_subnet_ids : local.private_subnet_ids

  envoy_config = templatefile("${path.module}/envoy.yaml.tmpl", {
    upstream_host = var.upstream_host
  })

  # If specific subnet names are provided, find subnets by name from all subnets in consumer VPC
  # Otherwise, use the tag-based discovery
  consumer_private_subnets_by_name = length(var.vpc_endpoint_subnet_names) > 0 ? [
    for subnet_name in var.vpc_endpoint_subnet_names :
    [for s in data.aws_subnet.appcompute_private : s.id if s.tags.Name == subnet_name][0]
  ] : []

  # Group consumer private subnets by availability zone and select first one from each AZ
  # This ensures VPC endpoint has subnets in all AZs for DNS names to work properly
  consumer_private_subnets_by_az = {
    for az in distinct([for s in data.aws_subnet.consumer_private : s.availability_zone]) :
    az => [for s in data.aws_subnet.consumer_private : s.id if s.availability_zone == az][0]
  }

  # Get one subnet per availability zone for VPC endpoint (VPC endpoints require unique AZs)
  # If specific subnet names are provided, use those; otherwise use all AZs to ensure DNS names are available
  consumer_private_subnet_ids = length(var.vpc_endpoint_subnet_names) > 0 ? local.consumer_private_subnets_by_name : values(local.consumer_private_subnets_by_az)
}

module "envoy_proxy" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//envoy-proxy/1.0.0"

  vpc_id          = var.vpc_id != null ? var.vpc_id : data.terraform_remote_state.proxy_vpc.outputs.vpc_id
  envoy_subnet_id = local.envoy_subnet_id
  nlb_subnet_ids  = local.nlb_subnet_ids

  envoy_ami_id        = var.envoy_ami_id
  envoy_instance_name = var.envoy_instance_name
  nlb_name            = var.nlb_name

  allowed_ssh_cidr   = var.allowed_ssh_cidr
  allowed_admin_cidr = var.allowed_admin_cidr

  # Optional: override envoy config if you want
  envoy_config = var.envoy_config != null ? var.envoy_config : local.envoy_config

  # Optional: override endpoint service name if you want
  endpoint_service_name = var.endpoint_service_name

  ssh_key_name = var.key_pair_name

  vpc_cidr_blocks = [ var.allowed_ssh_cidr ]

  enable_public_ip = true

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )

  upstream_host = var.upstream_host

  egress_cidr_blocks = var.egress_block_list

  cloudwatch_log_group_name = var.cw_log_group_name
}

# Security group for VPC endpoint in appcompute VPC
resource "aws_security_group" "appcompute_envoy_vpce" {
  name        = "qs-${var.environment}-ec1-envoy-vpce-sg-v1"
  description = "Security group for VPC endpoint to Envoy proxy service in appcompute VPC"
  vpc_id      = data.aws_vpc.appcompute.id

  ingress {
    description = "Allow inbound on port 8001 from consumer VPC"
    from_port   = 8001
    to_port     = 8001
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.appcompute.cidr_block]
  }

  ingress {
    description = "Allow inbound on port 8080 from consumer VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.appcompute.cidr_block]
  }

  ingress {
    description = "Allow inbound on port 22 from consumer VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.appcompute.cidr_block]
  }

  egress {
    description = "Allow outbound to Envoy proxy service"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "qs-${var.environment}-ec1-envoy-vpce-sg-v1"
      Environment = var.environment
    }
  )
}

# VPC Endpoint in appcompute VPC for Envoy Proxy Service
# Note: private_dns_enabled must be false initially. After the endpoint connection is accepted,
# you can change this to true and apply again to enable private DNS.
# Without private DNS, use the DNS entries from the output: appcompute_vpc_endpoint_dns_entries
resource "aws_vpc_endpoint" "appcompute_envoy_proxy" {
  vpc_id              = data.aws_vpc.appcompute.id
  service_name        = module.envoy_proxy.vpc_endpoint_service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.consumer_private_subnet_ids
  security_group_ids  = [aws_security_group.appcompute_envoy_vpce.id]
  private_dns_enabled = false # Set to true after connection is accepted to enable private DNS

  tags = merge(
    var.tags,
    {
      Name        = "${var.endpoint_service_name}-vpce-v1"
      Environment = var.environment
    }
  )
}

# Allow the consumer VPC's account to connect to the endpoint service
resource "aws_vpc_endpoint_service_allowed_principal" "appcompute_envoy_proxy" {
  vpc_endpoint_service_id = module.envoy_proxy.vpc_endpoint_service_id
  principal_arn           = "arn:aws:iam::${data.aws_vpc.appcompute.owner_id}:root"
}

# Accept the VPC endpoint connection to populate DNS entries
# Even with acceptance_required = false, we need to explicitly accept the connection
# for DNS entries to be available
# Note: DNS entries may take a few minutes to populate after acceptance
resource "aws_vpc_endpoint_connection_accepter" "appcompute_envoy_proxy" {
  vpc_endpoint_service_id = module.envoy_proxy.vpc_endpoint_service_id
  vpc_endpoint_id         = aws_vpc_endpoint.appcompute_envoy_proxy.id
  depends_on              = [aws_vpc_endpoint_service_allowed_principal.appcompute_envoy_proxy]
}

# Data source to query the VPC endpoint for current state (including DNS entries)
# This helps get fresh DNS entries that may not be in Terraform state yet
data "aws_vpc_endpoint" "appcompute_envoy_proxy" {
  id = aws_vpc_endpoint.appcompute_envoy_proxy.id
  depends_on = [
    aws_vpc_endpoint_connection_accepter.appcompute_envoy_proxy
  ]
}
