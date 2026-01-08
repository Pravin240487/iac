locals {
  ecs_subnets = [
    for subnet in var.private_subnets : subnet.cidr
    if subnet.key == "subnet1"
  ]
}

###################
### ECS Cluster ###
###################

module "ecs_cluster" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/ecs-cluster/1.0.0"

  name = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
  tags = var.tags
}

########################
### Task Definitions ###
########################

module "task_definition" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/task-definition/1.0.0"

  for_each = var.task_definitions

  task_definition_name    = "qs-${var.environment}-${var.region_suffix}-${each.value.task_definition_name}-task-${var.project_version}"
  container_name          = each.value.task_definition_name
  image                   = "${var.shared_account_id}.dkr.ecr.${var.region}.amazonaws.com/${each.value.ecr_repository_name}:${var.environment}"
  cpu                     = each.value.cpu
  memory                  = each.value.memory
  container_port          = each.value.container_port
  host_port               = each.value.host_port
  awslogs_region          = var.region
  task_iam_role_arn       = try(module.iam.arn[each.key], "")
  execution_iam_role_arn  = try(module.iam.arn[each.key], "")
  skip_destroy            = each.value.skip_destroy
  secret_arn              = try(module.secrets.arns[each.key], "")
  secret_keys             = try(each.value.secret_keys, [])
  kms_key_id              = each.value.kms_key_id
  service_log_group_name  = "qs-${var.environment}-${var.region_suffix}-${each.value.service_log_group_name}-log-group-${var.project_version}"
  operating_system_family = each.value.operating_system_family
  tags                    = var.tags
}

####################
### ECS Services ###
####################

module "ecs_service" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/ecs-service/1.1.0"

  ## Exclude agent-runtime from the ECS service module becuse it has a different configuration - 2 target groups need to be attached
  for_each = {
    for k, v in var.task_definitions : k => v
    if !contains(
      concat(
        ["agent-runtime", "whg-agent-runtime"],
        (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? ["librarian-assets"] : []
      ),
      k
    )
  }

  service_name                = each.value.task_definition_name
  service_security_group_name = "qs-${var.environment}-${var.region_suffix}-${each.value.task_definition_name}-sg-${var.project_version}"
  cluster_id                  = module.ecs_cluster.id
  task_definition_id          = module.task_definition[each.key].arn
  desired_count               = each.value.desired_count
  subnets                     = var.ecs_subnet_id
  autoscaling                 = each.value.autoscaling
  cluster_name                = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
  load_balancers = [
    {
      target_group_arn = try(module.target_groups[each.key].arn, null),
      container_name   = each.value.task_definition_name
      container_port   = each.value.container_port
    }
  ]
  vpc_id = module.vpc.vpc_id
  tags   = var.tags

  depends_on = [
    module.internal_alb_listener_rule_01,
    module.internal_alb_listener_rule_02,
    module.internal_alb_listener_rule_03,
    module.internal_alb_listener_rule_04,
    module.internal_alb_listener_rule_06,
    module.wss_alb_listener_rule_01
  ]
}

module "agent_runtime_ecs_service" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/ecs-service/1.1.0"

  service_name                = "agent-runtime"
  service_security_group_name = "qs-${var.environment}-${var.region_suffix}-agent-runtime-sg-${var.project_version}"
  cluster_id                  = module.ecs_cluster.id
  task_definition_id          = module.task_definition["agent-runtime"].arn
  desired_count               = 1
  subnets                     = var.ecs_subnet_id
  autoscaling                 = var.environment == "prd" || var.environment == "stg" ? true : false
  cluster_name                = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
  load_balancers = [
    {
      target_group_arn = try(module.target_groups["agent-runtime"].arn, null),
      container_name   = "agent-runtime"
      container_port   = 3006
    },
    {
      target_group_arn = try(module.target_groups["agent-runtime-ilb"].arn, null),
      container_name   = "agent-runtime"
      container_port   = 3006
    }
  ]
  vpc_id = module.vpc.vpc_id
  tags   = var.tags

  depends_on = [
    module.internal_alb_listener_rule_05,
    module.wss_alb_listener_rule_01
  ]
}

# WHG ECS Service
module "whg-agent_runtime_ecs_service" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/ecs-service/1.1.0"

  service_name                = "whg-agent-runtime"
  service_security_group_name = "qs-${var.environment}-${var.region_suffix}-whg-agent-runtime-sg-${var.project_version}"
  cluster_id                  = module.ecs_cluster.id
  task_definition_id          = module.task_definition["whg-agent-runtime"].arn
  desired_count               = var.environment == "prd" ? 0 : 1
  subnets                     = var.ecs_subnet_id
  autoscaling                 = var.environment == "prd" || var.environment == "stg" ? true : false
  cluster_name                = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
  load_balancers = [
    {
      target_group_arn = try(module.target_groups["whg-agent-runtime"].arn, null),
      container_name   = "whg-agent-runtime"
      container_port   = 3006
    },
    {
      target_group_arn = try(module.target_groups["whg-agent-runtime-ilb"].arn, null),
      container_name   = "whg-agent-runtime"
      container_port   = 3006
    }
  ]
  vpc_id = module.vpc.vpc_id
  tags   = var.tags

  depends_on = [
    module.internal_alb_listener_rule_05,
    module.wss_alb_listener_rule_01
  ]
}

## Librarian Assets ECS Service
module "librarian_asset_ecs_service" {
  count  = (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? 1 : 0
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/ecs-service/1.1.0"

  service_name                = "librarian-assets"
  service_security_group_name = "qs-${var.environment}-${var.region_suffix}-librarian-assets-sg-${var.project_version}"
  cluster_id                  = module.ecs_cluster.id
  task_definition_id          = module.task_definition["librarian-assets"].arn
  desired_count               = 1
  subnets                     = var.ecs_subnet_id
  autoscaling                 = var.environment == "prd" || var.environment == "stg" ? true : false
  cluster_name                = "qs-${var.environment}-${var.region_suffix}-main-ecs-${var.project_version}"
  load_balancers = [
    {
      target_group_arn = try(module.target_groups["librarian-assets"].arn, null),
      container_name   = "librarian-assets"
      container_port   = 9099
    },
    {
      target_group_arn = try(module.target_groups["librarian-assets-ilb"].arn, null),
      container_name   = "librarian-assets"
      container_port   = 9099
    }
  ]
  vpc_id = module.vpc.vpc_id
  tags   = var.tags

  depends_on = [
    module.internal_alb_listener_rule_05,
    module.wss_alb_listener_rule_01
  ]
}

############################
### Public ALB NSG Rules ###
############################

module "ecs_security_group_inbound_rules_public_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  for_each = {
    for k, v in var.public_alb : k => v
    if !contains(
      concat(
        ["agent-runtime", "whg-agent-runtime"],
        (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? ["librarian-assets"] : []
      ),
      k
    )
  }

  security_group_id            = module.ecs_service[each.key].ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-${each.key}-rule-${var.project_version}"
  description                  = "Allow inbound traffic from public ALB for ${each.key}"
  referenced_security_group_id = module.public_alb.lb_security_group_id
  from_port                    = each.value.container_port
  to_port                      = each.value.container_port
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

#############################
### Private ALB NSG Rules ###
#############################

module "ecs_security_group_inbound_rules_internal_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  for_each = {
    for k, v in var.internal_alb : k => v
    if !contains(
      concat(
        ["agent-runtime", "whg-agent-runtime"],
        (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? ["librarian-assets"] : []
      ),
      k
    )
  }

  security_group_id            = module.ecs_service[each.key].ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-${each.key}-rule-${var.project_version}"
  description                  = "Allow inbound traffic from internal ALB for ${each.key}"
  referenced_security_group_id = module.internal_alb.lb_security_group_id
  from_port                    = each.value.container_port
  to_port                      = each.value.container_port
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

###########################################
### Agent Runtime ECS Service NSG Rules ###
###########################################

module "ecs_security_group_inbound_rules_agent_runtime_wss_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id            = module.agent_runtime_ecs_service.ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-agent-runtime-rule-${var.project_version}"
  description                  = "Allow inbound traffic from WSS ALB for agent-runtime"
  referenced_security_group_id = module.wss_alb.lb_security_group_id
  from_port                    = 3006
  to_port                      = 3006
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

module "ecs_security_group_inbound_rules_agent_runtime_private_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id            = module.agent_runtime_ecs_service.ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-agent-runtime-rule-${var.project_version}"
  description                  = "Allow inbound traffic from internal ALB for agent-runtime"
  referenced_security_group_id = module.internal_alb.lb_security_group_id
  from_port                    = 3006
  to_port                      = 3006
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

module "ecs_security_group_inbound_rules_whg_agent_runtime_wss_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id            = module.whg-agent_runtime_ecs_service.ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-whg-agent-runtime-rule-${var.project_version}"
  description                  = "Allow inbound traffic from WSS ALB for whg-agent-runtime"
  referenced_security_group_id = module.wss_alb.lb_security_group_id
  from_port                    = 3006
  to_port                      = 3006
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

module "ecs_security_group_inbound_rules_whg_agent_runtime_private_alb" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id            = module.whg-agent_runtime_ecs_service.ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-whg-agent-runtime-rule-${var.project_version}"
  description                  = "Allow inbound traffic from internal ALB for whg-agent-runtime"
  referenced_security_group_id = module.internal_alb.lb_security_group_id
  from_port                    = 3006
  to_port                      = 3006
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

############################
### Librairan ALB NSG Rules 
############################

module "ecs_security_group_inbound_rules_librarian_asset_public_alb" {
  count  = (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? 1 : 0
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id            = module.librarian_asset_ecs_service[0].ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-librarian-asset-rule-${var.project_version}"
  description                  = "Allow inbound traffic from public ALB for librarian-asset"
  referenced_security_group_id = module.public_alb.lb_security_group_id
  from_port                    = 9099
  to_port                      = 9099
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

# Private

module "ecs_security_group_inbound_rules_librarian_asset_internal_alb" {
  count  = (var.environment == "dev" || var.environment == "test" || var.environment == "stg" || var.environment == "prd") ? 1 : 0
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id            = module.librarian_asset_ecs_service[0].ecs_security_group_id
  name                         = "qs-${var.environment}-${var.region_suffix}-librarian-asset-rule-${var.project_version}"
  description                  = "Allow inbound traffic from internal ALB for librarian-asset"
  referenced_security_group_id = module.internal_alb.lb_security_group_id
  from_port                    = 9099
  to_port                      = 9099
  ip_protocol                  = "tcp"
  tags                         = var.tags
}

#####################
### Target Groups ###
#####################

module "target_groups" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/target-group/1.0.0"

  for_each = var.target_groups

  target_group_name          = "qs-${var.environment}-${each.key}-${var.project_version}"
  target_group_port          = each.value.target_group_port
  vpc_id                     = module.vpc.vpc_id
  healthy_threshold          = each.value.healthy_threshold
  interval                   = each.value.interval
  matcher                    = each.value.matcher
  path                       = each.value.path
  unhealthy_threshold        = each.value.unhealthy_threshold
  timeout                    = each.value.timeout
  enable_stickiness          = each.value.enable_stickiness
  stickiness_type            = each.value.stickiness_type
  stickiness_cookie_duration = each.value.stickiness_cookie_duration
  protocol                   = each.value.protocol
  tags                       = var.tags

  depends_on = []
}

#################
### Variables ###
#################

variable "project_version" {
  description = "Version identifier for the deployment"
  type        = string
  default     = "v3"
}

variable "region_suffix" {
  description = "Suffix for the region, used in resource naming"
  type        = string
  default     = "ec1"
}

variable "shared_account_id" {
  description = "AWS Account ID for shared resources"
  type        = string
  default     = "654654596584"
}

variable "task_definitions" {
  description = "Map of ECS task definitions to create, keyed by task name"
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
  }))
  default = {
    "agent-runtime" = {
      task_definition_name   = "agent-runtime"
      container_name         = "agent-runtime"
      ecr_repository_name    = "agent-runtime"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3006
      host_port              = 3006
      service_log_group_name = "agent-runtime"
      secret_keys            = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
      autoscaling            = true
    }
    "ai-agent" = {
      task_definition_name   = "ai-agent"
      container_name         = "ai-agent"
      ecr_repository_name    = "ai-agent"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 80
      host_port              = 80
      service_log_group_name = "ai-agent"
      secret_keys            = ["RETRIVAL_AUTH_TOKEN", "VOYAGE_API_KEY", "VOYAGE_RERANK_MODEL"]
      autoscaling            = true
    }
    "api" = {
      task_definition_name   = "api"
      container_name         = "api"
      ecr_repository_name    = "api"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3001
      host_port              = 3001
      service_log_group_name = "api"
      secret_keys            = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "VAPI_API_KEY", "VAPI_API_ENDPOINT", "VAPI_CUSTOMER_KEY", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "POWER_BI_CLIENT_ID", "POWER_BI_CLIENT_SECRET", "POWER_BI_TENANT_ID", "POWER_BI_WORKSPACE_ID", "POWER_BI_SCOPE", "POWER_BI_DATASET_ID", "POWER_BI_ROLE_FUNCTION_NAME_OF_DAX", "POWER_BI_API_URL", "POWER_BI_APP_URL", "FISSION_DEPLOY_QUEUE_URL", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "CR_DATA_LOAD_QUEUE_URL", "ASSETS_SERVICE_URL", "ASSETS_AUTH_TOKEN"]
      autoscaling            = true
    }
    "app" = {
      task_definition_name   = "app"
      container_name         = "app"
      ecr_repository_name    = "app"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3000
      host_port              = 3000
      service_log_group_name = "app"
      secret_keys            = ["NEXT_PUBLIC_DOMAIN", "NEXT_PUBLIC_SOCKET_DOMAIN", "DOMAIN", "SOCKET_DOMAIN", "NEXT_PUBLIC_ASSETS_BASE_URL"]
      autoscaling            = true
    }
    "dbms" = {
      task_definition_name   = "dbms"
      container_name         = "dbms"
      ecr_repository_name    = "dbms"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3002
      host_port              = 3002
      service_log_group_name = "dbms"
      secret_keys            = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "ALLOWED_PREFIXES", "DBMS_AUTH_TOKEN", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL_ETL", "SHADOW_DATABASE_URL_ETL", "AGENT_RUNTIME_SERVICE_URL", "INTEGRATION_SERVICE_URL", "SCH_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "AI_AGENT_AUTH_TOKEN"]
      autoscaling            = true
    }
    "etl" = {
      task_definition_name   = "etl"
      container_name         = "etl"
      ecr_repository_name    = "etl"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3004
      host_port              = 3004
      service_log_group_name = "etl"
      secret_keys            = ["DATABASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "PORT", "ETL_AUTH_TOKEN", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "INTEG_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "ASSETS_SERVICE_URL", "ASSETS_AUTH_TOKEN"]
      autoscaling            = true
    }
    "integration" = {
      task_definition_name   = "integration"
      container_name         = "integration"
      ecr_repository_name    = "integration"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3005
      host_port              = 3005
      service_log_group_name = "integration"
      secret_keys            = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "CONFLUENCE_CONNECTION_ID", "ATLASSIAN_BASE_URL", "CONFLUENCE_BASE_URL", "CONFLUENCE_AUTH_TOKEN", "S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_DB_PASSWORD", "OPENAI_API_BASE_URL", "ANTHROPIC_API_BASE_URL", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "PG_DB_HOST", "PG_DB_PORT", "PG_DB_USERNAME", "PG_DB_PASSWORD", "PG_DB_NAME", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "DHL_API_BASE_URL", "DHL_TEST_TRACKING_NUMBER", "GOKARLA_BASE_URL", "VAPI_API_ENDPOINT", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "FEATURE_FLAG_SERVICE_PROVIDER", "LAUNCHDARKLY_SDK_KEY"]
      autoscaling            = true
    }
    "librarian-assets" = {
      task_definition_name   = "librarian-assets"
      container_name         = "librarian-assets"
      ecr_repository_name    = "librarian-assets"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 9099
      host_port              = 9099
      service_log_group_name = "librarian-assets"
      secret_keys            = ["COMMON_DATABASE_URL", "DATABASE_URL", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "SERVICE_NAME", "VOYAGEAI_API_URL", "VOYAGE_API_KEY", "ENCRYPTION_KEY", "AUTH_STRATEGY", "CONFIGURATION_SCHEMA_BUCKET", "CONFIGURATION_SCHEMA_PATH", "CONFIGURATION_SCHEMA_DEFAULT_VERSION", "VECTOR_DB_TYPE", "LIBRARIAN_ASSETS_AUTH_TOKEN"]
      autoscaling            = true
    }
    "librarian-retrieval" = {
      task_definition_name   = "librarian-retrieval"
      container_name         = "librarian-retrieval"
      ecr_repository_name    = "librarian-retrieval"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 9098
      host_port              = 9098
      service_log_group_name = "librarian-retrieval"
      secret_keys            = ["COMMON_DATABASE_URL", "DATABASE_URL", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "VOYAGEAI_API_URL", "VOYAGE_API_KEY", "ASSETS_API_PATH", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "API_VERSION"]
      autoscaling            = true
    }
    "scheduler" = {
      task_definition_name   = "scheduler"
      container_name         = "scheduler"
      ecr_repository_name    = "scheduler"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3003
      host_port              = 3003
      service_log_group_name = "scheduler"
      secret_keys            = ["NODE_ENV", "AWS_REGION", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "COGNITO_WORKER_SQS_QUEUE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "COGNITO_USER_SYNC_SQS_QUEUE_URL", "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL", "DEFAULT_SCHEDULER_ROLE_ARN", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "FULL_LOAD_SQS_QUEUE_URL", "INCREMENTAL_LOAD_SQS_QUEUE_URL", "DBMS_SERVICE_URL", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "EVALUATION_SQS_QUEUE_URL", "WEBHOOK_WORKER_SQS_QUEUE_URL", "FISSION_STATUS_QUEUE_URL", "CR_DATA_LOAD_QUEUE_URL"]
      autoscaling            = true
    }
    "librarian-migration" = {
      task_definition_name   = "librarian-migration"
      container_name         = "librarian-migration"
      ecr_repository_name    = "librarian-migration"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 9097
      host_port              = 9097
      service_log_group_name = "librarian-migration"
      secret_keys            = ["COMMON_DATABASE_URL", "DATABASE_URL", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "SERVICE_NAME", "VOYAGEAI_API_URL", "VOYAGE_API_KEY", "ENCRYPTION_KEY", "AUTH_STRATEGY", "CONFIGURATION_SCHEMA_BUCKET", "CONFIGURATION_SCHEMA_PATH", "CONFIGURATION_SCHEMA_DEFAULT_VERSION", "VECTOR_DB_TYPE"]
      autoscaling            = true
    }
    "whg-api" = {
      task_definition_name   = "whg-api"
      container_name         = "whg-api"
      ecr_repository_name    = "whg-api"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3001
      host_port              = 3001
      service_log_group_name = "whg-api"
      secret_keys            = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "VAPI_API_KEY", "VAPI_API_ENDPOINT", "VAPI_CUSTOMER_KEY", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "POWER_BI_CLIENT_ID", "POWER_BI_CLIENT_SECRET", "POWER_BI_TENANT_ID", "POWER_BI_WORKSPACE_ID", "POWER_BI_SCOPE", "POWER_BI_DATASET_ID", "POWER_BI_ROLE_FUNCTION_NAME_OF_DAX", "POWER_BI_API_URL", "POWER_BI_APP_URL", "FISSION_DEPLOY_QUEUE_URL", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "CR_DATA_LOAD_QUEUE_URL"]
      autoscaling            = true
    }
    "whg-agent-runtime" = {
      task_definition_name   = "whg-agent-runtime"
      container_name         = "whg-agent-runtime"
      ecr_repository_name    = "whg-agent-runtime"
      cpu                    = 2048
      memory                 = 4096
      container_port         = 3006
      host_port              = 3006
      service_log_group_name = "whg-agent-runtime"
      secret_keys            = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
      autoscaling            = true
    }
  }
}

variable "public_alb" {
  description = "ECS Service Security Group Inbound Rules for Public ALB"
  type = map(object({
    container_port               = optional(number, 80)
    cidr_ipv4                    = optional(string, null)
    referenced_security_group_id = optional(string, null)
  }))
  default = {
    "ai-agent" = {
      container_port = 80
    }
    "librarian-assets" = {
      container_port = 9099
    }
    "whg-api" = {
      container_port = 3001
    }
    "api" = {
      container_port = 3001
    }
    "app" = {
      container_port = 3000
    }
  }
}

variable "internal_alb" {
  description = "ECS Service Security Group Inbound Rules for Internal ALB"
  type = map(object({
    container_port               = optional(number, 80)
    cidr_ipv4                    = optional(string, null)
    referenced_security_group_id = optional(string, null)
  }))
  default = {
    "dbms" = {
      container_port = 3002
    }
    "scheduler" = {
      container_port = 3003
    }
    "etl" = {
      container_port = 3004
    }
    "integration" = {
      container_port = 3005
    }
    "librarian-retrieval" = {
      container_port = 9098
    }
  }
}

### Target Groups
variable "target_groups" {
  description = "Map of target groups to create, keyed by target group name"
  type = map(object({
    target_group_port          = optional(number, 80)
    healthy_threshold          = optional(number, 3)
    interval                   = optional(number, 40)
    matcher                    = optional(string, "200-499")
    path                       = optional(string, "/")
    unhealthy_threshold        = optional(number, 3)
    timeout                    = optional(number, 30)
    enable_stickiness          = optional(bool, false)
    stickiness_type            = optional(string, "lb_cookie")
    stickiness_cookie_duration = optional(number, 3600)
    protocol                   = optional(string, "HTTP")
  }))
  default = {
    "agent-runtime" = {
      enable_stickiness          = true
      stickiness_cookie_duration = 86400
      path                       = "/agent-runtime/api/v1/health-check"
    }
    "agent-runtime-ilb" = {
      path = "/agent-runtime/api/v1/health-check"
    }
    "whg-agent-runtime" = {
      enable_stickiness          = true
      stickiness_cookie_duration = 86400
      path                       = "/agent-runtime/api/v1/health-check"
    }
    "whg-agent-runtime-ilb" = {
      path = "/agent-runtime/api/v1/health-check"
    }
    "ai-agent" = {}
    "api" = {
      path = "/api/appconnect/health-check"
    }
    "app" = {}
    "dbms" = {
      path = "/dbms/api/v1/health-check"
    }
    "etl" = {
      path = "/etl/api/v1/health-check"
    }
    "integration" = {
      path = "/integration/api/v1/health-check"
    }
    "librarian-assets" = {
      path = "/assets/health-check"
    }
    "librarian-assets-ilb" = {
      path = "/assets/health-check"
    }
    "librarian-retrieval" = {
      path = "/librarian/retrieval/health-check"
    }
    "scheduler" = {
      path = "/scheduler/api/v1/health-check"
    }
    "librarian-migration" = {
      path = "/health-check"
    }
    "whg-api" = {
      path = "/api/appconnect/health-check"
    }
  }
}