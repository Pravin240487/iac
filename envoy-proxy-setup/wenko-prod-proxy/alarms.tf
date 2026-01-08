locals {
  sns_topic_arn = var.sns_topic_name != null ? "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}" : null
}

##################################################################################################################################
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
##################################################################################################################################

######################## EC2 Instance Metric Alarms ############################
# Alarm for Envoy EC2 instance CPU utilization
resource "aws_cloudwatch_metric_alarm" "envoy_cpu_utilization" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.envoy_instance_name}-alarm-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when Envoy instance CPU utilization exceeds 80%"
  treat_missing_data  = "breaching"

  dimensions = {
    InstanceId = module.envoy_proxy.envoy_instance_id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

# Alarm for Envoy EC2 instance status check failed
resource "aws_cloudwatch_metric_alarm" "envoy_status_check_failed" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.envoy_instance_name}-alarm-status-check-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "Alarm when Envoy instance status check fails"
  treat_missing_data  = "breaching"

  dimensions = {
    InstanceId = module.envoy_proxy.envoy_instance_id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

######################## Network Load Balancer Metric Alarms ############################
# Alarm for NLB unhealthy target count
resource "aws_cloudwatch_metric_alarm" "nlb_unhealthy_targets" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.nlb_name}-alarm-unhealthy-targets"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "Alarm when NLB has unhealthy targets"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = split("/", module.envoy_proxy.nlb_arn)[length(split("/", module.envoy_proxy.nlb_arn)) - 1]
    TargetGroup  = split("/", module.envoy_proxy.target_group_arn)[length(split("/", module.envoy_proxy.target_group_arn)) - 1]
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

# Alarm for NLB healthy target count - ensure at least one healthy target
resource "aws_cloudwatch_metric_alarm" "nlb_healthy_targets" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.nlb_name}-alarm-no-healthy-targets"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Alarm when NLB has no healthy targets"
  treat_missing_data  = "breaching"

  dimensions = {
    LoadBalancer = split("/", module.envoy_proxy.nlb_arn)[length(split("/", module.envoy_proxy.nlb_arn)) - 1]
    TargetGroup  = split("/", module.envoy_proxy.target_group_arn)[length(split("/", module.envoy_proxy.target_group_arn)) - 1]
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

######################## VPC Endpoint Metric Alarms ############################
# Alarm for VPC endpoint packet drops
resource "aws_cloudwatch_metric_alarm" "vpce_packet_drops" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.endpoint_service_name != null ? var.endpoint_service_name : var.nlb_name}-vpce-alarm-packet-drops"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "PacketsDropped"
  namespace           = "AWS/PrivateLinkEndpoints"
  period              = 300
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Alarm when VPC endpoint packet drops exceed 100 in 5 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    VpcEndpointId = aws_vpc_endpoint.appcompute_envoy_proxy.id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

# Alarm for VPC endpoint connection errors
resource "aws_cloudwatch_metric_alarm" "vpce_connection_errors" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.endpoint_service_name != null ? var.endpoint_service_name : var.nlb_name}-vpce-alarm-connection-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ConnectionErrorCount"
  namespace           = "AWS/PrivateLinkEndpoints"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Alarm when VPC endpoint connection errors exceed 10 in 5 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    VpcEndpointId = aws_vpc_endpoint.appcompute_envoy_proxy.id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

