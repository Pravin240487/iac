locals {
  sns_topic_arn = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_topics["sns01"]["name"]}"
}
##################################################################################################################################
data "aws_caller_identity" "current" {}
##################################################################################################################################
resource "aws_cloudwatch_metric_alarm" "sqs_oldest_message_age" {
  for_each            = var.environment == "test" ? toset([var.sqs["sqs001"]["name"], var.sqs["sqs002"]["name"], var.sqs["sqs003"]["name"], var.sqs["sqs004"]["name"]]) : toset([var.sqs["sqs0001"]["name"], var.sqs["sqs0002"]["name"], var.sqs["sqs0003"]["name"], var.sqs["sqs0004"]["name"]])
  alarm_name          = "${each.value}-alarm-sqs-oldest-message-age-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = var.sqs_old_message_period
  statistic           = var.sqs_oldest_message_statistic
  threshold           = var.sqs_old_message_threshold
  alarm_description   = "Triggered when the oldest message in the SQS queue is older than 5 minutes."
  treat_missing_data  = var.treat_missing_data

  dimensions = {
    QueueName = each.value
  }
  actions_enabled = var.sqs_actions_enabled
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}
resource "aws_cloudwatch_metric_alarm" "sqs_messages_not_visible" {
  for_each            = var.environment == "test" ? toset([var.sqs["sqs001"]["name"], var.sqs["sqs002"]["name"], var.sqs["sqs003"]["name"], var.sqs["sqs004"]["name"]]) : toset([var.sqs["sqs0001"]["name"], var.sqs["sqs0002"]["name"], var.sqs["sqs0003"]["name"], var.sqs["sqs0004"]["name"]])
  alarm_name          = "${each.value}-alarm-sqs-messages-not-visible"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "NumberOfMessagesNotVisible"
  namespace           = "AWS/SQS"
  period              = var.sqs_messages_not_visible_period
  statistic           = var.sqs_messages_not_visible_statistic
  threshold           = var.sqs_messages_not_visible_threshold
  alarm_description   = "Triggered when there are more than 5 messages in flight for lower env and 10 for prod and stg"
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    QueueName = each.value
  }

  actions_enabled = var.sqs_actions_enabled

  alarm_actions = [local.sns_topic_arn]
  tags          = var.tags
}
######################## ECS Metric Alarm ############################
# resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization" {
#   for_each = {for k, v in var.ecs : k => v["ecs_name"]}
#   alarm_name          = "qs-${var.environment}-${each.value}-alarm-memory-utilization-high"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = var.evaluation_periods
#   period              = var.ecs_mem_utilization_period
#   statistic           = var.ecs_mem_utilization_statistic
#   threshold           = var.ecs_mem_utilization_threshold
#   namespace           = "AWS/ECS"
#   metric_name         = "MemoryUtilization"
#   treat_missing_data =  var.treat_missing_data_breaching
#   dimensions = {
#     ClusterName = module.ecs_cluster.name
#     ServiceName = each.value
#   }
#   actions_enabled = var.sns_actions_enabled
#   alarm_actions = [local.sns_topic_arn]
#   tags = var.tags
# }
# resource "aws_cloudwatch_metric_alarm" "ecs_desired_task_count" {
#   for_each = {for k, v in var.ecs : k => v["ecs_name"]}
#   alarm_name          = "qs-${var.environment}-${each.value}-alarm-desired-task-count-failure"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = var.evaluation_periods
#   period              = var.ecs_desired_task_count_period
#   statistic           = var.ecs_desired_task_count_statistic
#   threshold           = var.ecs_desired_task_count_threshold
#   namespace           = "AWS/ECS"
#   metric_name         = "DesiredTaskCount"
#   dimensions = {
#     ClusterName = module.cluster.cluster_name
#     ServiceName = each.value
#   }
#   actions_enabled = var.sns_actions_enabled
#   alarm_actions = [local.sns_topic_arn]
#   tags = var.tags
# }
################### Redis###################
resource "aws_cloudwatch_metric_alarm" "redis_cpu_alarm" {
  for_each            = { for k, v in var.redis : k => v["name"] }
  alarm_name          = "${each.value}-alarm-RedisCPUHighUtilization"
  alarm_description   = "Triggers when Redis CPU utilization exceeds 90%"
  metric_name         = "CPUUtilization"
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
  actions_enabled = var.sqs_actions_enabled
  alarm_actions   = [local.sns_topic_arn]
  tags            = var.tags
}

# resource "aws_cloudwatch_metric_alarm" "redis_memory_alarm" {
#   for_each = {for k, v in var.ecs : k => v["ecs_name"]}
#   alarm_name                = "${each.value}-alarm-RedisMemoryHighUsage"
#   alarm_description         = "Triggers when Redis memory usage exceeds 85%"
#   metric_name               = "MemoryUsage"
#   namespace                 = "AWS/ElastiCache"
#   statistic                 = var.redis_cpu_alarm_statistic
#   period                    = var.redis_cpu_alarm_period
#   threshold                 = var.redis_cpu_alarm_threshold
#   comparison_operator      = "GreaterThanThreshold"
#   evaluation_periods       = var.redis_cpu_alarm_evaluation_period
#   datapoints_to_alarm      = var.redis_cpu_alarm_datapoints
#   treat_missing_data =  var.treat_missing_data_breaching
#   dimensions = {
#     CacheClusterId = each.value  
#   }

#  alarm_actions = [local.sns_topic_arn]
#  actions_enabled = var.sqs_actions_enabled
#  tags = var.tags
# }

##########################LB Metric Alarm################################
resource "aws_cloudwatch_metric_alarm" "elb_5xx_errors" {
  for_each            = { for k, v in var.lb : k => v["lb_name"] }
  alarm_name          = "${each.value}-alarm-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  period              = var.lb_5xx_errors_period
  statistic           = var.lb_5xx_errors_statistic
  threshold           = var.lb_5xx_errors_threshold
  namespace           = "AWS/ELB"
  metric_name         = "HTTPCode_ELB_5XX"
  treat_missing_data  = var.treat_missing_data
  dimensions = {
    LoadBalancerName = each.value
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sns_actions_enabled
  tags            = var.tags

}
resource "aws_cloudwatch_metric_alarm" "target_5xx_errors" {
  for_each            = { for k, v in var.lb : k => v["lb_name"] }
  alarm_name          = "${each.value}-alarm-target-5xx-errors"
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
    LoadBalancerName = each.value
  }
  alarm_actions   = [local.sns_topic_arn]
  actions_enabled = var.sns_actions_enabled
}
#####################Schedulers Metric Alarm##################################
resource "aws_cloudwatch_metric_alarm" "eventbridge_failed_invocations" {
  for_each            = toset([for x in var.schedulers : x["name"]])
  alarm_name          = "${each.value}-alarm-EventBridgeSchedulerFailedInvocations"
  alarm_description   = "Triggers when EventBridge Scheduler invocations fail"
  metric_name         = "FailedInvocations"
  namespace           = "AWS/Events"
  statistic           = var.schedulers_statistic
  period              = var.schedulers_period
  threshold           = var.schedulers_threshold
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  datapoints_to_alarm = var.schedulers_datapts
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags
  dimensions = {
    RuleName = each.value
  }
  actions_enabled    = var.sqs_actions_enabled
  treat_missing_data = var.treat_missing_data
}
###############RDS ALARM ######################
resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  for_each            = toset(var.DBInstanceIdentifier)
  alarm_name          = "${each.key}-alarm-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Maximum"
  threshold           = var.rds_cpu_threshold
  alarm_description   = "Alarm for RDS DB cpu usage"
  actions_enabled     = var.sqs_actions_enabled
  treat_missing_data  = var.environment == "test" || var.environment == "dev" ? var.treat_missing_data : var.treat_missing_data_breaching
  alarm_actions       = [local.sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = each.key
  }
  tags = var.tags
}
resource "aws_cloudwatch_metric_alarm" "rds_read-latency" {
  for_each            = toset(var.DBInstanceIdentifier)
  alarm_name          = "${each.key}-alarm-read-latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "ReadLatency"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Maximum"
  threshold           = var.read_latency_threshold
  alarm_description   = "Alarm for RDS DB read latency"
  actions_enabled     = var.sqs_actions_enabled
  treat_missing_data  = var.treat_missing_data
  alarm_actions       = [local.sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = each.key
  }
  tags = var.tags
}
resource "aws_cloudwatch_metric_alarm" "rds_dbload" {
  for_each            = toset(var.DBInstanceIdentifier)
  alarm_name          = "${each.key}-alarm-dbload"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "DBLoad"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.dbload_threshold
  alarm_description   = "Alarm for RDS DB load"
  actions_enabled     = var.sqs_actions_enabled
  treat_missing_data  = var.treat_missing_data
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}
resource "aws_cloudwatch_metric_alarm" "rds_dbconnections" {
  for_each            = toset(var.DBInstanceIdentifier)
  alarm_name          = "${each.key}-alarm-dbconnections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Maximum"
  threshold           = var.dbconnection_threshold
  alarm_description   = "Alarm for RDS DB Connections"
  actions_enabled     = var.sqs_actions_enabled
  treat_missing_data  = var.treat_missing_data
  alarm_actions       = [local.sns_topic_arn]
  tags                = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}
resource "aws_cloudwatch_metric_alarm" "rds_storage" {
  for_each            = toset(var.DBInstanceIdentifier)
  alarm_name          = "${each.key}-alarm-storage"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Minimum"
  threshold           = var.storage_threshold
  alarm_description   = "Alarm for RDS DB Storage Usage"
  actions_enabled     = var.sqs_actions_enabled
  tags                = var.tags
  treat_missing_data  = var.environment == "test" || var.environment == "dev" ? var.treat_missing_data : var.treat_missing_data_breaching
  alarm_actions       = [local.sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}


#############################################
#######         Queue Handler       #########
#############################################
resource "aws_cloudwatch_metric_alarm" "llmqueue_scale_up" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-ingestion-llm-scale-up-${var.app_version}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1 # 2 datapoints
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 30 # 1 minute
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when LLM SQS queue has >= 1 visible message for 2 minutes"
  treat_missing_data  = "breaching" # Treat missing data as missing
  dimensions = {
    QueueName = module.fifo_sqs_queue_llm.sqs_name
  }

  # Actions to trigger autoscaling policy
  alarm_actions = [aws_appautoscaling_policy.ingestion_worker_llm_scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "loaderqueue_scale_up" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-ingestion-pgvector-loader-scale-up-${var.app_version}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1 # 2 datapoints
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 30 # 1 minute
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when Loader SQS queue has >= 1 visible message for 2 minutes"
  treat_missing_data  = "breaching" # Treat missing data as missing
  dimensions = {
    QueueName = module.fifo_sqs_queue_loader.sqs_name
  }

  # Actions to trigger autoscaling policy
  alarm_actions = [aws_appautoscaling_policy.ingestion_worker_pgvector_loader_scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "taskqueue_scale_up" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-ingestion-generic-scale-up-${var.app_version}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1 # 2 datapoints
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 30 # 1 minute
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when Task SQS queue has >= 1 visible message for 2 minutes"
  treat_missing_data  = "breaching" # Treat missing data as missing
  dimensions = {
    QueueName = module.fifo_sqs_queue_task.sqs_name
  }

  # Actions to trigger autoscaling policy
  alarm_actions = [aws_appautoscaling_policy.ingestion_worker_generic_scale_up.arn]
}


resource "aws_cloudwatch_metric_alarm" "taskqueue_scale_down" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-ingestion-generic-scale-down-${var.app_version}"
  alarm_description   = "Scale down when no messages are in the taskqueue"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 12
  threshold           = 0
  datapoints_to_alarm = 12
  treat_missing_data  = "breaching"

  # Actions to trigger autoscaling scale down policy
  alarm_actions = [aws_appautoscaling_policy.ingestion_worker_generic_scale_down.arn]

  metric_query {
    id          = "m5"
    label       = "ApproximateNumberOfMessagesVisible"
    return_data = false

    metric {
      namespace   = "AWS/SQS"
      metric_name = "ApproximateNumberOfMessagesVisible"
      dimensions = {
        QueueName = module.fifo_sqs_queue_task.sqs_name
      }
      stat   = "Average"
      period = 60
    }
  }

  metric_query {
    id          = "m6"
    label       = "ApproximateNumberOfMessagesNotVisible"
    return_data = false

    metric {
      namespace   = "AWS/SQS"
      metric_name = "ApproximateNumberOfMessagesNotVisible"
      dimensions = {
        QueueName = module.fifo_sqs_queue_task.sqs_name
      }
      stat   = "Average"
      period = 60
    }
  }

  metric_query {
    id          = "e1"
    expression  = "m5 + m6"
    label       = "ApproximateNumberOfMessages-taskqueue"
    return_data = true
  }
}

resource "aws_cloudwatch_metric_alarm" "llmqueue_scale_down" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-ingestion-llm-scale-down-${var.app_version}"
  alarm_description   = "Scale down when no messages are in the llmqueue"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 12
  threshold           = 0
  datapoints_to_alarm = 12
  treat_missing_data  = "breaching"

  # Actions to trigger autoscaling scale down policy
  alarm_actions = [aws_appautoscaling_policy.ingestion_worker_llm_scale_down.arn]

  metric_query {
    id          = "m1"
    label       = "ApproximateNumberOfMessagesVisible"
    return_data = false

    metric {
      namespace   = "AWS/SQS"
      metric_name = "ApproximateNumberOfMessagesVisible"
      dimensions = {
        QueueName = module.fifo_sqs_queue_llm.sqs_name
      }
      stat   = "Average"
      period = 60
    }
  }

  metric_query {
    id          = "m2"
    label       = "ApproximateNumberOfMessagesNotVisible"
    return_data = false

    metric {
      namespace   = "AWS/SQS"
      metric_name = "ApproximateNumberOfMessagesNotVisible"
      dimensions = {
        QueueName = module.fifo_sqs_queue_llm.sqs_name
      }
      stat   = "Average"
      period = 60
    }
  }

  metric_query {
    id          = "e1"
    expression  = "m1 + m2"
    label       = "ApproximateNumberOfMessages-llmqueue"
    return_data = true
  }
}

resource "aws_cloudwatch_metric_alarm" "loaderqueue_scale_down" {
  alarm_name          = "qs-${var.environment}-${var.region_suffix}-alarm-ingestion-pgvector-loader-scale-down-${var.app_version}"
  alarm_description   = "Scale down when no messages are in the loaderqueue"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 12
  threshold           = 0
  datapoints_to_alarm = 12
  treat_missing_data  = "breaching"

  # Actions to trigger autoscaling scale down policy
  alarm_actions = [aws_appautoscaling_policy.ingestion_worker_pgvector_loader_scale_down.arn]

  metric_query {
    id          = "m3"
    label       = "ApproximateNumberOfMessagesVisible"
    return_data = false

    metric {
      namespace   = "AWS/SQS"
      metric_name = "ApproximateNumberOfMessagesVisible"
      dimensions = {
        QueueName = module.fifo_sqs_queue_loader.sqs_name
      }
      stat   = "Average"
      period = 60
    }
  }

  metric_query {
    id          = "m4"
    label       = "ApproximateNumberOfMessagesNotVisible"
    return_data = false

    metric {
      namespace   = "AWS/SQS"
      metric_name = "ApproximateNumberOfMessagesNotVisible"
      dimensions = {
        QueueName = module.fifo_sqs_queue_loader.sqs_name
      }
      stat   = "Average"
      period = 60
    }
  }

  metric_query {
    id          = "e2"
    expression  = "m3 + m4"
    label       = "ApproximateNumberOfMessages-loaderqueue"
    return_data = true
  }
}