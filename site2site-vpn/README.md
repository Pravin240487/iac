# Site-to-Site VPN Module

This directory contains Terraform configuration for creating AWS Site-to-Site VPN connections using the site2site-vpn module.

## Files

- `main.tf` - Main Terraform configuration that uses the site2site-vpn module
- `variables.tf` - Variable definitions
- `outputs.tf` - Output values from the module
- `backend.tf` - Terraform backend configuration
- `*.tfvars` - Environment-specific variable files (dev, stage, prod, test)

## Usage

### Prerequisites

1. Ensure you have the site2site-vpn module available at `s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/site2site-vpn/1.0.0`
2. Configure your AWS credentials and assume role permissions
3. Update the `*.tfvars` files with your specific values

### Required Variables

- `vpc_id` - The VPC ID where the VPN will be attached
- `customer_gateway_ip` - Public IP address of your on-premises customer gateway
- `role_arn` - AWS IAM role ARN to assume
- `environment` - Environment name (dev, stage, prod, test)

### Optional Variables

- `vpn_gateway_name` - Name for the Virtual Private Gateway (default: "main-vpg")
- `customer_gateway_bgp_asn` - BGP ASN of the customer gateway (default: 65000)
- `static_routes_only` - Use static routing instead of BGP (default: false)
- `destination_cidr_blocks` - List of CIDR blocks for static routing (required if static_routes_only is true)
- `route_table_ids` - List of route table IDs to propagate VPN routes to
- `tunnel1_inside_cidr` / `tunnel2_inside_cidr` - Inside CIDR blocks for tunnels (optional)
- `tunnel1_preshared_key` / `tunnel2_preshared_key` - Pre-shared keys for tunnels (optional)

### Example: Deploy to Dev Environment

```bash
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

### Example: Deploy to Production

```bash
terraform init -backend-config="key=site2site-vpn/prod/terraform.tfstate"
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
```

## Outputs

After deployment, you can access the following outputs:

- `vpn_gateway_id` - ID of the VPN Gateway
- `customer_gateway_id` - ID of the Customer Gateway
- `vpn_connection_id` - ID of the VPN Connection
- `vpn_connection_tunnel1_address` - Public IP address of tunnel 1
- `vpn_connection_tunnel2_address` - Public IP address of tunnel 2
- `vpn_connection_tunnel1_preshared_key` - Pre-shared key for tunnel 1 (sensitive)
- `vpn_connection_tunnel2_preshared_key` - Pre-shared key for tunnel 2 (sensitive)
- `customer_gateway_configuration` - Configuration information for the customer gateway (sensitive)

## Notes

- If you don't specify pre-shared keys, AWS will auto-generate them. You can retrieve them from the outputs after creation.
- If you don't specify tunnel inside CIDR blocks, AWS will auto-assign them.
- For static routing, you must provide `destination_cidr_blocks`.
- For BGP routing, ensure your customer gateway supports BGP and configure the BGP ASN accordingly.

