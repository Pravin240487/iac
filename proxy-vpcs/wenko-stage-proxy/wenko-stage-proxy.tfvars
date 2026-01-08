role_arn = "arn:aws:iam::180294192430:role/terraform-role"

cidr_block = "10.48.0.0/26"

# Public Subnets
public_subnets = [
  { cidr = "10.48.0.0/28", az = "eu-central-1a", Name = "wenko-stage-proxy-public-sne-01a-v1", key = "subnet1" }
]

# Private Subnets
private_subnets = [
  { cidr = "10.48.0.32/28", az = "eu-central-1a", Name = "wenko-stage-proxy-private-sne-01a-v1", key = "subnet3" },     #NLB
  { cidr = "10.48.0.48/28", az = "eu-central-1b", Name = "wenko-stage-proxy-private-sne-01b-v1", key = "subnet4" }      #NLB
]

# Indicates index of the public subnet
nat_subnet_index = 0

# NAT Name
nat_name = "wenko-stage-proxy-nat-v1"

vpc_name = "wenko-stage-proxy-vpc-v1"

# Define the environment (e.g., "production", "stg", "test")
environment = "stg"


vpc_tags = {
  "Name"        = "wenko-stage-proxy-vpc-v1"
  "Project"     = "oc"
  "Environment" = "stg"
  "Terraformed" = true
  "Owner"       = "Octonomy.devops@talentship.io"
  "Version"     = "V1"
  "TenantID"    = "wenko"
}

sns_topic_name = "qs-stg-ec1-sns-alert-v1"