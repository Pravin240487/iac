provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.role_arn
  }
}

# Get VPC and route table information from proxy-vpcs/wenko-prod-proxy remote state
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

module "site2site_vpn" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/site2site-vpn/1.0.0"

  # Required variables
  vpc_id              = var.vpc_id != null ? var.vpc_id : data.terraform_remote_state.proxy_vpc.outputs.vpc_id
  customer_gateway_ip = var.customer_gateway_ip

  # Optional variables
  vpn_gateway_name         = var.vpn_gateway_name
  customer_gateway_bgp_asn = var.customer_gateway_bgp_asn
  destination_cidr_blocks  = var.destination_cidr_blocks
  route_table_ids          = length(var.route_table_ids) > 0 ? var.route_table_ids : data.terraform_remote_state.proxy_vpc.outputs.route_table_ids
  static_routes_only       = var.static_routes_only
  tunnel1_inside_cidr      = var.tunnel1_inside_cidr
  tunnel2_inside_cidr      = var.tunnel2_inside_cidr
  tunnel1_preshared_key    = var.tunnel1_preshared_key
  tunnel2_preshared_key    = var.tunnel2_preshared_key

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

