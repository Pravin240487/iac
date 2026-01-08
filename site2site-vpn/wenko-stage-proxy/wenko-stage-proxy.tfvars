#################################
########     ROLE     ###########
#################################

role_arn = "arn:aws:iam::180294192430:role/terraform-role"

#################################
########     TAG     ############
#################################

environment = "stg"

tags = {
  "Project"     = "oc"
  "Environment" = "stg"
  "Terraformed" = "true"
  "Owner"       = "Octonomy.devops@talentship.io"
  "TenantID"    = "wenko"
}

#################################
########   Site2Site VPN  #######
#################################

# VPC ID where the VPN will be attached
# If not provided, will be automatically retrieved from proxy-vpcs/wenko-stage-proxy remote state
# vpc_id = "vpc-xxxxxxxxxxxxxxxxx"

# Name for the Virtual Private Gateway
vpn_gateway_name = "oc-wenko-stage-proxy-vpg"

# Public IP address of your customer gateway (on-premises device)
customer_gateway_ip = "88.79.215.100"

# BGP ASN of the customer gateway (default: 65000)
customer_gateway_bgp_asn = 65000

# Whether to use static routing (true) or BGP (false)
static_routes_only = true

# If using static routing, specify destination CIDR blocks
destination_cidr_blocks = ["172.20.2.187/32", "172.16.211.13/32"]

# Route table IDs to propagate VPN routes to (optional)
# route_table_ids = ["rtb-xxxxxxxxxxxxxxxxx"]

# Tunnel inside CIDR blocks (optional, AWS will auto-assign if not specified)
# tunnel1_inside_cidr = "169.254.1.0/30"
# tunnel2_inside_cidr = "169.254.2.0/30"

# Pre-shared keys for tunnels (optional, AWS will auto-generate if not specified)
# tunnel1_preshared_key = "your-preshared-key-1"
# tunnel2_preshared_key = "your-preshared-key-2"

sns_topic_name = "qs-stg-ec1-sns-alert-v1"
