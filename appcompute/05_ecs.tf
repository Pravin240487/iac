locals {
  # Ingestion workers - available in all environments
  ingestion_worker_task_definitions = var.ingestion_worker_task_definitions

  # Ingestion workers that need ECS services (exclude ingestion-queue-orchestrator)
  ingestion_worker_services = {
    for k, v in local.ingestion_worker_task_definitions : k => v
    if k != "ingestion-worker" && k != "queue-handler" && k != "ingestion-queue-orchestrator"
  }
  
  # Direct SQS URL mapping - let each service use its own SQS queue
  ingestion_worker_commands = {
    "ingestion-worker-llm" = [
      "/app/packages/quickstep-package/quickstep_etl/tasks/stage_processor.py",
      "--QUEUE_URL",
      module.fifo_sqs_queue_llm.sqs_queue_url
    ]
    "ingestion-worker-generic" = [
      "/app/packages/quickstep-package/quickstep_etl/tasks/stage_processor.py",
      "--QUEUE_URL",
      module.fifo_sqs_queue_task.sqs_queue_url
    ]
    "ingestion-worker-pgvector-loader" = [
      "/app/packages/quickstep-package/quickstep_etl/tasks/stage_processor.py",
      "--QUEUE_URL",
      module.fifo_sqs_queue_loader.sqs_queue_url
    ]
    # Other workers use their default commands
    "ingestion-queue-orchestrator" = ["/home/glue_user/workspace/frontend/app.py"]
  }
}

########################
### Task Definitions ###
########################

module "ingestion_worker_task_definition" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/task-definition/1.0.0"

  for_each = local.ingestion_worker_task_definitions

  task_definition_name    = "qs-${var.environment}-${var.region_suffix}-${each.value.task_definition_name}-task-${var.project_version}"
  container_name          = each.value.task_definition_name
  image                   = "${var.shared_account_id}.dkr.ecr.${var.region}.amazonaws.com/${each.value.ecr_repository_name}:${var.environment}"
  cpu                     = each.value.cpu
  memory                  = each.value.memory
  container_port          = each.value.container_port
  host_port               = each.value.host_port
  awslogs_region          = var.region
  task_iam_role_arn       = try(module.iam.arn[each.key], module.iam.arn["ingestion-queue-orchestrator"], "")
  execution_iam_role_arn  = try(module.iam.arn[each.key], module.iam.arn["ingestion-queue-orchestrator"])
  skip_destroy            = each.value.skip_destroy
  secret_arn              = try(module.secrets.arns["stage-processor"], module.secrets.arns[each.key], "")
  secret_keys             = try(each.value.secret_keys, [])
  kms_key_id              = each.value.kms_key_id
  service_log_group_name  = "qs-${var.environment}-${var.region_suffix}-${each.value.service_log_group_name}-log-group-${var.project_version}"
  operating_system_family = each.value.operating_system_family
  
  # Add command and entryPoint for container definitions
  entry_point             = try(each.value.entry_point, ["python3"])
  command                 = try(local.ingestion_worker_commands[each.key], each.value.command, ["/home/glue_user/workspace/frontend/app.py"])
  environment             = try(each.value.environment, [])
  
  tags                    = var.tags
}

####################
### ECS Services ###
####################

module "ingestion_worker_ecs_service" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/ecs-service/1.1.0"

  # Only create services for ingestion-worker-llm, ingestion-workers-task, ingestion-workers-load
  # Exclude ingestion-workers (task definition only)
  for_each = local.ingestion_worker_services

  service_name                = each.value.task_definition_name
  service_security_group_name = "qs-${var.environment}-${var.region_suffix}-${each.value.task_definition_name}-sg-${var.project_version}"
  cluster_id                  = module.ecs_cluster.id
  task_definition_id          = module.ingestion_worker_task_definition[each.key].arn
  desired_count               = each.value.desired_count
  subnets                     = var.ecs_subnet_id
  autoscaling                 = each.value.autoscaling
  cluster_name                = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
  # No load balancers - ingestion workers don't need ALB/target groups
  load_balancers = []
  vpc_id         = module.vpc.vpc_id
  tags           = var.tags
}

####################
### Autoscaling ###
####################

# Autoscaling target for LLM processor
resource "aws_appautoscaling_target" "ingestion_worker_llm_target" {
  max_capacity       = 15
  min_capacity       = 0
  resource_id        = "service/qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}/ingestion-worker-llm"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [module.ingestion_worker_ecs_service]
}

# Autoscaling target for Task processor
resource "aws_appautoscaling_target" "ingestion_worker_generic_target" {
  max_capacity       = 5
  min_capacity       = 0
  resource_id        = "service/qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}/ingestion-worker-generic"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [module.ingestion_worker_ecs_service]
}

# Autoscaling target for Load processor
resource "aws_appautoscaling_target" "ingestion_worker_pgvector_loader_target" {
  max_capacity       = 1
  min_capacity       = 0
  resource_id        = "service/qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}/ingestion-worker-pgvector-loader"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [module.ingestion_worker_ecs_service]
}

# Scale up policy for LLM processor
resource "aws_appautoscaling_policy" "ingestion_worker_llm_scale_up" {
  name               = "qs-${var.environment}-${var.region_suffix}-ingestion-worker-llm-scale-up-${var.app_version}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ingestion_worker_llm_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ingestion_worker_llm_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ingestion_worker_llm_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 15
    }
  }
}

# Scale up policy for Task processor
resource "aws_appautoscaling_policy" "ingestion_worker_generic_scale_up" {
  name               = "qs-${var.environment}-${var.region_suffix}-ingestion-worker-generic-scale-up-${var.app_version}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ingestion_worker_generic_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ingestion_worker_generic_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ingestion_worker_generic_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 5
    }
  }
}

# Scale up policy for Load processor
resource "aws_appautoscaling_policy" "ingestion_worker_pgvector_loader_scale_up" {
  name               = "qs-${var.environment}-${var.region_suffix}-ingestion-worker-pgvector-loader-scale-up-${var.app_version}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ingestion_worker_pgvector_loader_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ingestion_worker_pgvector_loader_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ingestion_worker_pgvector_loader_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

# Scale down policy for LLM processor
resource "aws_appautoscaling_policy" "ingestion_worker_llm_scale_down" {
  name               = "qs-${var.environment}-${var.region_suffix}-ingestion-worker-llm-scale-down-${var.app_version}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ingestion_worker_llm_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ingestion_worker_llm_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ingestion_worker_llm_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    cooldown                = 0
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 0
    }
  }
}


# Scale down policy for Task processor
resource "aws_appautoscaling_policy" "ingestion_worker_generic_scale_down" {
  name               = "qs-${var.environment}-${var.region_suffix}-ingestion-worker-generic-scale-down-${var.app_version}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ingestion_worker_generic_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ingestion_worker_generic_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ingestion_worker_generic_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    cooldown                = 0
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 0
    }
  }
}

# Scale down policy for Load processor
resource "aws_appautoscaling_policy" "ingestion_worker_pgvector_loader_scale_down" {
  name               = "qs-${var.environment}-${var.region_suffix}-ingestion-worker-pgvector-loader-scale-down-${var.app_version}"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ingestion_worker_pgvector_loader_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ingestion_worker_pgvector_loader_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ingestion_worker_pgvector_loader_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    cooldown                = 0
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 0
    }
  }
}

#################
### Variables ###
#################

variable "ingestion_worker_task_definitions" {
  description = "Map of ingestion worker ECS task definitions to create, keyed by task name"
  type = map(object({
    task_definition_name    = string
    container_name          = string
    ecr_repository_name     = string
    cpu                     = optional(number, 256)
    memory                  = optional(number, 512)
    container_port          = optional(number, 80)
    host_port               = optional(number, 80)
    skip_destroy            = optional(bool, true)
    secret_keys             = optional(list(string), [])
    kms_key_id              = optional(string, null)
    service_log_group_name  = optional(string, null)
    operating_system_family = optional(string, "LINUX")
    desired_count           = optional(number, 1)
    autoscaling             = optional(bool, false)
    entry_point             = optional(list(string), ["python3"])
    command                 = optional(list(string), ["/home/glue_user/workspace/frontend/app.py"])
    environment             = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
  default = {
    "ingestion-queue-orchestrator" = {
      task_definition_name    = "ingestion-queue-orchestrator"
      container_name          = "ingestion-queue-orchestrator"
      ecr_repository_name     = "ingestion-worker"
      cpu                     = 2048
      memory                  = 4096
      container_port          = 5000
      host_port               = 5000
      service_log_group_name  = "ingestion-queue-orchestrator"
      autoscaling             = false
      desired_count           = 0
      entry_point             = ["python3"]
      command                 = ["/home/glue_user/workspace/frontend/app.py"]
      secret_keys            = ["ETL_API_TOKEN"]
    }
    "ingestion-worker-llm" = {
      task_definition_name    = "ingestion-worker-llm"
      container_name          = "ingestion-worker-llm"
      ecr_repository_name     = "ingestion-worker"
      cpu                     = 2048
      memory                  = 4096
      container_port          = 5000
      host_port               = 5000
      service_log_group_name  = "ingestion-worker-llm"
      autoscaling             = false
      desired_count           = 0
      entry_point             = ["python3"]
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "eu-central-1"
        }
      ]
      secret_keys            = ["SENTRY_DSN", "ENV_MODE"]
    }
    "ingestion-worker-generic" = {
      task_definition_name    = "ingestion-worker-generic"
      container_name          = "ingestion-worker-generic"
      ecr_repository_name     = "ingestion-worker"
      cpu                     = 2048
      memory                  = 4096
      container_port          = 5000
      host_port               = 5000
      service_log_group_name  = "ingestion-worker-generic"
      autoscaling             = false
      desired_count           = 0
      entry_point             = ["python3"]
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "eu-central-1"
        }
      ]
      secret_keys            = ["SENTRY_DSN", "ENV_MODE"]
    }
    "ingestion-worker-pgvector-loader" = {
      task_definition_name    = "ingestion-worker-pgvector-loader"
      container_name          = "ingestion-worker-pgvector-loader"
      ecr_repository_name     = "ingestion-worker"
      cpu                     = 2048
      memory                  = 4096
      container_port          = 5000
      host_port               = 5000
      service_log_group_name  = "ingestion-worker-pgvector-loader"
      autoscaling             = false
      desired_count           = 0
      entry_point             = ["python3"]
      environment = [
        {
          name  = "AWS_DEFAULT_REGION"
          value = "eu-central-1"
        }
      ]
      secret_keys            = ["SENTRY_DSN", "ENV_MODE"]
    }
  }
}