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
########   Envoy Proxy   #######
#################################

# VPC ID where the Envoy proxy will be deployed
# If not provided, will be automatically retrieved from proxy-vpcs/wenko-stage-proxy remote state
# vpc_id = "vpc-xxxxxxxxxxxxxxxxx"

# Subnet ID for the Envoy EC2 instance
# If not provided, will use the first available public subnet from the VPC (allows direct SSH access)
# envoy_subnet_id = "subnet-xxxxxxxxxxxxxxxxx"

# List of subnet IDs for the Network Load Balancer (should span multiple AZs)
# If not provided, will use all private subnets from the VPC
# nlb_subnet_ids = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]

# AMI ID for the Envoy proxy EC2 instance
envoy_ami_id = "ami-04865745555ae0eef"

# Name for the Envoy proxy EC2 instance
envoy_instance_name = "oc-wenko-stage-proxy-envoy"

# Name for the Network Load Balancer
nlb_name = "oc-wenko-stage-proxy-envoy-nlb"

# CIDR block allowed to SSH to the Envoy instance
allowed_ssh_cidr = "10.48.0.0/26"

# CIDR block allowed to access the Envoy admin interface
allowed_admin_cidr = "10.48.0.0/26"

# Optional: Envoy configuration file path
# envoy_config = "${path.module}/envoy.yaml"

# Optional: VPC endpoint service name (defaults to nlb_name-ep-svc if not provided)
endpoint_service_name = "stg-wenko-pxy-evy-ep-svc"

# Appcompute VPC configuration for VPC endpoint
# Terraform state key path for appcompute (e.g., 'stage/terraform.tfstate')
appcompute_state_key = "stage/terraform.tfstate"

# Optional: Appcompute VPC name (defaults to 'qs-${var.environment}-ec1-main-vpc-v1' if not provided)
# appcompute_vpc_name = "qs-stg-ec1-main-vpc-v1"

upstream_host = "api.internal.poc.octonomy.ai"

# Name of the key pair to use for the Envoy instance
key_pair_name = "qs-stg-ec1-bastion-key"

# List of subnet names to use for VPC endpoint in consumer VPC
# Reusing existing RDS subnets to avoid creating new subnets
vpc_endpoint_subnet_names = [
  "qs-stg-ec1-private-sne-rds-01a-v1",
  "qs-stg-ec1-private-sne-rds-02b-v1"
]

egress_block_list = [ "0.0.0.0/0" ]

sns_topic_name = "qs-stg-ec1-sns-alert-v1"

cw_log_group_name = "qs-stg-ec1-wenko-proxy"
