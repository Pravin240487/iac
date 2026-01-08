######################## ECS Metric Alarm ############################
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization_new" {
  for_each = { for k, v in var.task_definitions : k => v["task_definition_name"] }

  alarm_name          = "qs-${var.environment}-${each.value}-alarm-cpu-utilization-high-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.ecs_cpu_utilization_period
  statistic           = var.ecs_cpu_utilization_statistic
  threshold           = var.ecs_cpu_utilization_threshold
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  treat_missing_data  = var.treat_missing_data_breaching

  dimensions = {
    ClusterName = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
    ServiceName = each.value
  }

  actions_enabled = var.environment == "prd" && contains(["librarian-migration", "whg-agent-runtime", "whg-api"], each.value) ? false : var.sqs_actions_enabled
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization_new" {
  for_each            = { for k, v in var.task_definitions : k => v["task_definition_name"] }
  alarm_name          = "qs-${var.environment}-${each.value}-alarm-memory-utilization-high-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.ecs_mem_utilization_period
  statistic           = var.ecs_mem_utilization_statistic
  threshold           = var.ecs_mem_utilization_threshold
  namespace           = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  treat_missing_data  = var.treat_missing_data_breaching
  dimensions = {
    ClusterName = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
    ServiceName = each.value
  }
  actions_enabled = var.environment == "prd" && contains(["librarian-migration", "whg-agent-runtime", "whg-api"], each.value) ? false : var.sqs_actions_enabled
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}
resource "aws_cloudwatch_metric_alarm" "ecs_container_insights" {
  for_each            = { for k, v in var.task_definitions : k => v["task_definition_name"] }
  alarm_name          = "qs-${var.environment}-${each.value}-alarm-running-task-count-failure-${var.project_version}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.ecs_desired_task_count_period
  statistic           = var.ecs_desired_task_count_statistic
  threshold           = var.ecs_desired_task_count_threshold
  namespace           = "ECS/ContainerInsights"
  metric_name         = "RunningTaskCount"
  dimensions = {
    ClusterName = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
    ServiceName = each.value
  }
  actions_enabled = var.environment == "prd" && contains(["librarian-migration", "whg-agent-runtime", "whg-api"], each.value) ? false : var.sqs_actions_enabled
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}
resource "aws_cloudwatch_metric_alarm" "ecs_desired_task_count_new" {
  for_each            = { for k, v in var.task_definitions : k => v["task_definition_name"] }
  alarm_name          = "qs-${var.environment}-${each.value}-alarm-desired-task-count-failure-${var.project_version}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.ecs_desired_task_count_period
  statistic           = var.ecs_desired_task_count_statistic
  threshold           = var.ecs_desired_task_count_threshold
  namespace           = "AWS/ECS"
  metric_name         = "DesiredTaskCount"
  dimensions = {
    ClusterName = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
    ServiceName = each.value
  }
  actions_enabled = var.environment == "prd" && contains(["librarian-migration", "whg-agent-runtime", "whg-api"], each.value) ? false : var.sqs_actions_enabled
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}
################### Redis###################
resource "aws_cloudwatch_metric_alarm" "redis_memory_alarm_new" {
  for_each            = { for k, v in var.task_definitions : k => v["task_definition_name"] }
  alarm_name          = "qs-${var.environment}-${each.value}-alarm-redis-mem-usage-${var.project_version}"
  alarm_description   = "Triggers when Redis memory usage exceeds 85%"
  metric_name         = "MemoryUsage"
  namespace           = "AWS/ElastiCache"
  statistic           = var.redis_cpu_alarm_statistic
  period              = var.redis_cpu_alarm_period
  threshold           = var.redis_cpu_alarm_threshold
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.redis_cpu_alarm_evaluation_period
  datapoints_to_alarm = var.redis_cpu_alarm_datapoints
  treat_missing_data  = var.treat_missing_data_breaching
  dimensions = {
    CacheClusterId = each.value
  }

  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.environment == "prd" && contains(["librarian-migration", "whg-agent-runtime", "whg-api"], each.value) ? false : var.sqs_actions_enabled
  tags            = var.tags
}
##########################LB Metric Alarm################################
resource "aws_cloudwatch_metric_alarm" "main_alb_5xx_errors" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-main-alb-5xx-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_ELB_5XX"
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    LoadBalancerName = "qs-${var.environment}-${var.region_suffix}-main-alb-${var.project_version}"
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sqs_actions_enabled
  tags            = var.tags

}
resource "aws_cloudwatch_metric_alarm" "main_target_5xx_errors" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-main-target-alb5xx-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_Target_5XX"
  treat_missing_data  = var.treat_missing_data
  tags                = var.tags
  dimensions = {
    LoadBalancerName = "qs-${var.environment}-${var.region_suffix}-main-alb-${var.project_version}"
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sqs_actions_enabled
}
resource "aws_cloudwatch_metric_alarm" "internal_5xx_errors" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-internal-alb5xx-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_ELB_5XX"
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    LoadBalancerName = "qs-${var.environment}-${var.region_suffix}-main-ilb-${var.project_version}"
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sqs_actions_enabled
  tags            = var.tags

}
resource "aws_cloudwatch_metric_alarm" "internal_target_5xx_errors" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-internal-target-5xx-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_Target_5XX"
  treat_missing_data  = var.treat_missing_data
  tags                = var.tags
  dimensions = {
    LoadBalancerName = "qs-${var.environment}-${var.region_suffix}-main-ilb-${var.project_version}"
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sqs_actions_enabled
}
resource "aws_cloudwatch_metric_alarm" "wss_5xx_errors" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-wss-alb5xx-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_ELB_5XX"
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    LoadBalancerName = "qs-${var.environment}-${var.region_suffix}-wss-alb-${var.project_version}"
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sqs_actions_enabled
  tags            = var.tags

}
resource "aws_cloudwatch_metric_alarm" "wss_target_5xx_errors" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-wss-target-5xx-${var.project_version}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_Target_5XX"
  treat_missing_data  = var.treat_missing_data
  tags                = var.tags
  dimensions = {
    LoadBalancerName = "qs-${var.environment}-${var.region_suffix}-wss-alb-${var.project_version}"
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sqs_actions_enabled
}