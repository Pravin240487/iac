locals {
  sns_topic_arn = var.sns_topic_name != null ? "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}" : null
}

##################################################################################################################################
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
##################################################################################################################################

# Get NAT Gateway by name
data "aws_nat_gateway" "this" {
  filter {
    name   = "tag:Name"
    values = [var.nat_name]
  }
  depends_on = [module.vpc]
}

######################## NAT Gateway Metric Alarms ############################
# Alarm for NAT Gateway packet drops - indicates potential connectivity issues
resource "aws_cloudwatch_metric_alarm" "nat_packet_drops" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.nat_name}-alarm-packet-drops"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "PacketsDropCount"
  namespace           = "AWS/NATGateway"
  period              = 300
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Alarm when NAT Gateway packet drops exceed 100 in 5 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    NatGatewayId = data.aws_nat_gateway.this.id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.vpc_tags
}

# Alarm for NAT Gateway bytes out - monitor traffic patterns
resource "aws_cloudwatch_metric_alarm" "nat_bytes_out" {
  count               = var.sns_topic_name != null ? 1 : 0
  alarm_name          = "${var.nat_name}-alarm-bytes-out-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "BytesOutToDestination"
  namespace           = "AWS/NATGateway"
  period              = 300
  statistic           = "Sum"
  threshold           = 10737418240 # 10 GB in 5 minutes
  alarm_description   = "Alarm when NAT Gateway bytes out exceed 10 GB in 5 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    NatGatewayId = data.aws_nat_gateway.this.id
  }

  actions_enabled = true
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.vpc_tags
}

