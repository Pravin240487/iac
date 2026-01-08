output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = var.vpc_name
}

# Route table IDs for VPN route propagation
# These can be used in the site2site_vpn module's route_table_ids variable
output "route_table_ids" {
  description = "List of all route table IDs in the VPC for VPN route propagation"
  value       = data.aws_route_tables.this.ids
}

