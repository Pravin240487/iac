#################################
### Public ALB Listener Rules ###
#################################

module "public_alb_listener_rule_01" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-01"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 100
  target_group_arn          = module.target_groups["ai-agent"].arn
  path_pattern              = []
  host_header               = var.environment == "prd" ? ["ai-agent.octonomy.ai"] : ["ai-agent.${var.environment}.octonomy.ai"]
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "public_alb_listener_rule_02" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-02"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 110
  target_group_arn          = module.target_groups["librarian-assets"].arn
  path_pattern              = ["/assets/*"]
  host_header               = var.environment == "prd" ? ["*.octonomy.ai"] : ["*.${var.environment}.octonomy.ai"]
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "public_alb_listener_rule_03" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-03"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 120
  target_group_arn          = module.target_groups["whg-api"].arn
  path_pattern              = ["/api/appconnect/*"]
  host_header               = var.environment == "prd" ? ["worldhost-group.octonomy.ai"] : ["worldhost-group.${var.environment}.octonomy.ai"]
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "public_alb_listener_rule_04" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-04"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 130
  target_group_arn          = module.target_groups["api"].arn
  path_pattern              = ["/api/appconnect/*"]
  host_header               = var.environment == "prd" ? ["*.assets.octonomy.ai", "*.octonomy.ai"] : ["*.${var.environment}.assets.octonomy.ai", "*.${var.environment}.octonomy.ai"]
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "public_alb_listener_rule_05" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-05"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 140
  target_group_arn          = module.target_groups["app"].arn
  path_pattern              = []
  host_header               = var.environment == "prd" ? ["*.octonomy.ai"] : ["*.${var.environment}.octonomy.ai"]
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "public_alb_listener_rule_06" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"
  count  = var.environment == "prd" ? 1 : 0

  aws_lb_listener_rule_name = "Rule-06"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 1000
  action_type               = "redirect"
  redirect_config = {
    host        = "www.octonomy.ai"
    path        = "/"
    port        = "443"
    protocol    = "HTTPS"
    status_code = "HTTP_301"
  }
  path_pattern        = []
  host_header         = ["*.octonomy.com", "octonomy.com"]
  stickiness_enabled  = false
  stickiness_duration = 600
  tags                = var.tags
}

module "public_alb_listener_rule_07" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"
  count  = var.environment == "prd" ? 1 : 0

  aws_lb_listener_rule_name = "Rule-07"
  listener_arn              = module.public_alb.https_listener_arn
  priority                  = 1001
  action_type               = "redirect"
  redirect_config = {
    host        = "www.octonomy.ai"
    path        = "/"
    port        = "443"
    protocol    = "HTTPS"
    status_code = "HTTP_301"
  }
  path_pattern        = []
  host_header         = ["*.octonomy.de", "octonomy.de"]
  stickiness_enabled  = false
  stickiness_duration = 600
  tags                = var.tags
}

###################################
### Internal ALB Listener Rules ###
###################################

module "internal_alb_listener_rule_01" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-01"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 100
  target_group_arn          = module.target_groups["whg-agent-runtime-ilb"].arn
  path_pattern              = ["/agent-runtime/*"]
  host_header               = var.environment == "prd" ? ["worldhost-group.internal.octonomy.ai"] : ["worldhost-group.internal.${var.environment}.octonomy.ai"]
  stickiness_enabled        = true
  stickiness_duration       = 3600
  tags                      = var.tags
}

module "internal_alb_listener_rule_02" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-02"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 110
  target_group_arn          = module.target_groups["dbms"].arn
  path_pattern              = ["/dbms/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "internal_alb_listener_rule_03" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-03"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 120
  target_group_arn          = module.target_groups["scheduler"].arn
  path_pattern              = ["/scheduler/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "internal_alb_listener_rule_04" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-04"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 130
  target_group_arn          = module.target_groups["etl"].arn
  path_pattern              = ["/etl/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "internal_alb_listener_rule_05" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-05"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 140
  target_group_arn          = module.target_groups["integration"].arn
  path_pattern              = ["/integration/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "internal_alb_listener_rule_06" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-06"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 150
  target_group_arn          = module.target_groups["agent-runtime-ilb"].arn
  path_pattern              = ["/agent-runtime/*"]
  host_header               = []
  stickiness_enabled        = true
  stickiness_duration       = 3600
  tags                      = var.tags
}

module "internal_alb_listener_rule_07" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-07"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 160
  target_group_arn          = module.target_groups["librarian-retrieval"].arn
  path_pattern              = ["/librarian/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "internal_alb_listener_rule_08" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-08"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 170
  target_group_arn          = module.target_groups["librarian-migration"].arn
  path_pattern              = ["/migrations/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

module "internal_alb_listener_rule_009" {
  count  = (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? 1 : 0
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-09"
  listener_arn              = module.internal_alb.https_listener_arn
  priority                  = 180
  target_group_arn          = module.target_groups["librarian-assets-ilb"].arn
  path_pattern              = ["/assets/*"]
  host_header               = []
  stickiness_enabled        = false
  stickiness_duration       = 600
  tags                      = var.tags
}

##############################
### WSS ALB Listener Rules ###
##############################

module "wss_alb_listener_rule_01" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-01"
  listener_arn              = module.wss_alb.https_listener_arn
  priority                  = 100
  target_group_arn          = module.target_groups["whg-agent-runtime"].arn
  path_pattern              = ["/socket.io/*", "/agent-runtime/*"]
  host_header               = var.environment == "prd" ? ["worldhost-group.wss.octonomy.ai"] : ["worldhost-group.${var.environment}.wss.octonomy.ai"]
  stickiness_enabled        = true
  stickiness_duration       = 3600
  tags                      = var.tags
}

module "wss_alb_listener_rule_02" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/load-balancer/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "Rule-02"
  listener_arn              = module.wss_alb.https_listener_arn
  priority                  = 110
  target_group_arn          = module.target_groups["agent-runtime"].arn
  path_pattern              = ["/socket.io/*", "/agent-runtime/*"]
  host_header               = var.environment == "prd" ? ["*.wss.octonomy.ai"] : ["*.${var.environment}.wss.octonomy.ai"]
  stickiness_enabled        = true
  stickiness_duration       = 3600
  tags                      = var.tags
}
