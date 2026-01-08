# output "private_sub" {
#   value = module.vpc.private_subnet_ids
# }

# output "kms_key_arn_customer0002" {
#   value = module.kms_new["customer0002"].target_key_id
# }

# output "lb_ids" {
#   value = {for k,v in module.lb : k => v.lb_arn}
# }
output "waf_web_acl_arns" {
  description = "A map of WAFv2 Web ACL ARNs keyed by WAF ACL name"
  value = {
    for k, mod in module.waf_acl_cloudfront :
    k => mod.waf_web_acl_arn
  }
}
