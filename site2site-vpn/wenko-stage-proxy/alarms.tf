locals {
  sns_topic_arn = var.sns_topic_name != null ? "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}" : null
}

##################################################################################################################################
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
##################################################################################################################################

######################## VPN Connection Metric Alarms ############################
# Alarm for VPN Tunnel 1 state - critical for connectivity
resource "aws_cloudwatch_metric_alarm" "vpn_tunnel1_state" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${module.site2site_vpn.vpn_connection_id}-tunnel1-state-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TunnelState"
  namespace           = "AWS/VPN"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Alarm when VPN Tunnel 1 is down (state < 1)"
  treat_missing_data  = "breaching"

  dimensions = {
    VpnId    = module.site2site_vpn.vpn_connection_id
    TunnelIp = module.site2site_vpn.vpn_connection_tunnel1_address
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

# Alarm for VPN Tunnel 2 state - critical for redundancy
resource "aws_cloudwatch_metric_alarm" "vpn_tunnel2_state" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${module.site2site_vpn.vpn_connection_id}-tunnel2-state-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TunnelState"
  namespace           = "AWS/VPN"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Alarm when VPN Tunnel 2 is down (state < 1)"
  treat_missing_data  = "breaching"

  dimensions = {
    VpnId    = module.site2site_vpn.vpn_connection_id
    TunnelIp = module.site2site_vpn.vpn_connection_tunnel2_address
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

# Alarm for VPN data in - monitor traffic flow
resource "aws_cloudwatch_metric_alarm" "vpn_data_in" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${module.site2site_vpn.vpn_connection_id}-data-in-zero"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "TunnelDataIn"
  namespace           = "AWS/VPN"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alarm when VPN has no incoming data for 15 minutes (potential connectivity issue)"
  treat_missing_data  = "notBreaching"

  dimensions = {
    VpnId = module.site2site_vpn.vpn_connection_id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

