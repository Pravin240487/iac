output "envoy_instance_id" {
  description = "ID of the Envoy proxy EC2 instance"
  value       = module.envoy_proxy.envoy_instance_id
}

output "envoy_private_ip" {
  description = "Private IP address of the Envoy proxy EC2 instance"
  value       = module.envoy_proxy.envoy_private_ip
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = module.envoy_proxy.nlb_dns_name
}

output "nlb_arn" {
  description = "ARN of the Network Load Balancer"
  value       = module.envoy_proxy.nlb_arn
}

output "target_group_arn" {
  description = "ARN of the NLB target group"
  value       = module.envoy_proxy.target_group_arn
}

output "envoy_security_group_id" {
  description = "ID of the security group attached to the Envoy instance"
  value       = module.envoy_proxy.envoy_security_group_id
}

output "vpc_endpoint_service_id" {
  description = "ID of the VPC endpoint service"
  value       = module.envoy_proxy.vpc_endpoint_service_id
}

output "vpc_endpoint_service_name" {
  description = "Name of the VPC endpoint service"
  value       = module.envoy_proxy.vpc_endpoint_service_name
}

output "appcompute_vpc_endpoint_id" {
  description = "ID of the VPC endpoint in appcompute VPC for Envoy proxy service"
  value       = aws_vpc_endpoint.appcompute_envoy_proxy.id
}

output "appcompute_vpc_endpoint_dns_entries" {
  description = "DNS entries for the VPC endpoint in appcompute VPC. Use these DNS names to connect to the envoy proxy service. Each entry corresponds to a network interface in a different AZ. Note: DNS entries may take a few minutes to populate after connection acceptance."
  # Use data source for fresh DNS entries, fallback to resource if data source is empty
  value = length(data.aws_vpc_endpoint.appcompute_envoy_proxy.dns_entry) > 0 ? data.aws_vpc_endpoint.appcompute_envoy_proxy.dns_entry : aws_vpc_endpoint.appcompute_envoy_proxy.dns_entry
}

output "appcompute_vpc_endpoint_dns_name" {
  description = "Primary DNS name for the VPC endpoint (first DNS entry). Use this to connect to the envoy proxy service when private_dns_enabled is false. Note: May be null if DNS entries haven't populated yet - wait a few minutes and refresh."
  value = try(
    data.aws_vpc_endpoint.appcompute_envoy_proxy.dns_entry[0].dns_name,
    length(aws_vpc_endpoint.appcompute_envoy_proxy.dns_entry) > 0 ? aws_vpc_endpoint.appcompute_envoy_proxy.dns_entry[0].dns_name : null
  )
}

output "appcompute_vpc_endpoint_state" {
  description = "Current state of the VPC endpoint (pendingAcceptance, pending, available, etc.)"
  value       = data.aws_vpc_endpoint.appcompute_envoy_proxy.state
}

