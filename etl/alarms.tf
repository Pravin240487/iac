locals {
  sns_topic_arn = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_topic}"
}
####################################################################################################################################
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
#######################################SQS DLQ METRIC ALARM#################################
resource "aws_cloudwatch_metric_alarm" "dlq_messages_sent" {
  for_each            = toset([var.sqs["sqs001"]["dlq_name"], var.sqs["sqs002"]["dlq_name"], var.sqs["sqs003"]["dlq_name"]])
  alarm_name          = "${each.value}-alarm-dlq-messages-sent-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NumberOfMessagesSent"
  namespace           = "AWS/SQS"
  period              = var.dlq_messages_sent_period
  statistic           = var.dlq_messages_sent_statistic
  threshold           = var.dlq_messages_sent_threshold
  treat_missing_data  = var.treat_missing_data
  tags                = var.tags
  alarm_description   = "Triggered when more than 10 messages are sent to the DLQ in a 5-minute period."

  dimensions = {
    QueueName = each.value
  }

  actions_enabled = var.sqs_actions_enabled

  alarm_actions = [local.sns_topic_arn]
}
######################## Step Function ####################
resource "aws_cloudwatch_metric_alarm" "step_function_timeout_executions" {
  for_each            = { for index, attr in module.sf : index => attr.arn }
  alarm_name          = "${each.value}-StepFunctionTimeoutExecutions"
  alarm_description   = "Triggers when Step Functions executions timeout"
  metric_name         = "ExecutionsTimedOut"
  namespace           = "AWS/States"
  statistic           = var.sf_statistic
  period              = var.sf_period
  threshold           = var.sf_threshold
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  datapoints_to_alarm = var.sf_datapoints_to_alarm
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags

  dimensions = {
    StateMachineArn = each.value
  }
  treat_missing_data = var.treat_missing_data
  actions_enabled    = var.sqs_actions_enabled
}
resource "aws_cloudwatch_metric_alarm" "step_function_executions_failed" {
  for_each            = { for index, attr in module.sf : index => attr.arn }
  alarm_name          = "${each.value}-StepFunctionExecutionsFailed"
  alarm_description   = "Triggers when Step Functions executions fail"
  metric_name         = "ExecutionsFailed"
  namespace           = "AWS/States"
  statistic           = var.sf_statistic
  period              = var.sf_period
  threshold           = var.sf_threshold
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  datapoints_to_alarm = var.sf_datapoints_to_alarm
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags


  dimensions = {
    StateMachineArn = each.value
  }
  treat_missing_data = var.treat_missing_data
  actions_enabled    = var.sqs_actions_enabled
}
################# Lambda ###################
resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  for_each            = toset(var.lambdas)
  alarm_name          = "${each.key}-alarm-throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = var.lambda_period
  statistic           = "Sum"
  threshold           = var.lambda_threshold
  alarm_description   = "Alarm for Throttles in Lambda"
  treat_missing_data  = var.treat_missing_data
  actions_enabled     = var.sqs_actions_enabled
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags
  dimensions = {
    FunctionName = each.key
  }
}
resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  for_each            = toset(var.lambdas)
  alarm_name          = "${each.key}-alarm-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = var.lambda_period
  statistic           = "Sum"
  threshold           = var.lambda_errors_threshold
  alarm_description   = "Alarm for Errors in Lambda"
  treat_missing_data  = var.treat_missing_data
  actions_enabled     = var.sqs_actions_enabled
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags
  dimensions = {
    FunctionName = each.key
  }
}