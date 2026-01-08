provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.role_arn
  }
}

data "terraform_remote_state" "shared" {
  backend = "s3"

  config = {
    bucket = "qs-terraform-remote-state"
    key    = "global/app/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source           = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//vpc?archive=zip"
  cidr_block       = var.cidr_block
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  nat_subnet_index = var.nat_subnet_index
  nat_name         = var.nat_name
  vpc_name         = var.vpc_name
  environment      = var.environment
  tags = merge(var.vpc_tags, {
  })
}

//END=VPC

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }

  //depends_on = [ module.vpc ]
}

# module "lb_security_group" {
#   source              = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sg?archive=zip"
#   security_group_name = var.alb_security_group
#   vpc_id              = module.vpc.vpc_id
#   ingress = {
#     ingress80 = {
#       protocol    = "tcp"
#       from_port   = 80
#       to_port     = 80
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress443 = {
#       from_port   = 443
#       to_port     = 443
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   egress = {
#     egress = {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   tags = var.tags
# }

# module "alb_security_group" {
#   source              = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sg?archive=zip"
#   security_group_name = var.wss_alb_security_group
#   vpc_id              = data.aws_vpc.this.id
#   ingress = {
#     ingress80 = {
#       protocol    = "tcp"
#       from_port   = 80
#       to_port     = 80
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress443 = {
#       from_port   = 443
#       to_port     = 443
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   egress = {
#     egress = {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   tags = var.tags
# }

# module "nlb_security_group" {
#   source              = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sg?archive=zip"
#   security_group_name = var.nlb_security_group
#   vpc_id              = module.vpc.vpc_id
#   ingress = {
#     ingress22 = {
#       protocol    = "tcp"
#       from_port   = 7687
#       to_port     = 7687
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress80 = {
#       protocol    = "tcp"
#       from_port   = 7688
#       to_port     = 7688
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress443 = {
#       from_port   = 7689
#       to_port     = 7689
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress7474 = {
#       from_port   = 7474
#       to_port     = 7474
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }

#     ingress7687 = {
#       from_port   = 7687
#       to_port     = 7687
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   egress = {
#     egress = {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   tags = var.tags
# }

# module "ilb_security_group" {
#   source              = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sg?archive=zip"
#   security_group_name = var.ilb_security_group
#   vpc_id              = module.vpc.vpc_id
#   ingress = {
#     ingress443 = {
#       from_port   = 443
#       to_port     = 443
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   egress = {
#     egress = {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
#   tags = var.tags
# }

//END=SG

data "aws_subnet" "az" {
  for_each = var.instances
  id = (
    each.value.subnet_type == "public" ? module.vpc.public_subnet_ids[each.value.subnet_index] :
    each.value.subnet_type == "private" ? module.vpc.private_subnet_ids[each.value.subnet_index] :
    null
  )
}

#EC2
module "ec2" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//ec2?archive=zip"
  for_each = var.instances
  instances = {
    for key, value in { "${each.key}" = each.value } : key => merge(value, {
      availability_zone = data.aws_subnet.az[key].availability_zone
      delete_protection = true
    })
  }
  public_subnets  = module.vpc.public_subnet_ids
  private_subnets = module.vpc.private_subnet_ids
  vpc_id          = data.aws_vpc.this.id
  environment     = var.environment
  app_version     = var.app_version
  kms_key_arn     = each.value.kms_key_arn != null ? module.kms_new[each.value.kms_key_arn].target_key_id : null
  tags            = var.tags
}

//END=EC2

data "aws_subnets" "this_db" {
  for_each = var.dbsubnet
  filter {
    name   = "tag:Name"
    values = each.value.subnet_name
  }
  //depends_on = [ data.aws_vpc.this ]
}

module "dbsubnet" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//dbsubnetgroup?archive=zip"
  for_each    = var.dbsubnet
  name        = each.value.name
  subnet_name = data.aws_subnets.this_db[each.key].ids
  tags        = var.tags
  //depends_on = [module.vpc.vpc_id]
}

module "iam_policy" {
  source                = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//iampolicy?archive=zip"
  for_each              = var.iam_policies
  iam_policy_name       = each.value.name
  iam_policy_name_desc  = each.value.description
  iam_policy_statements = each.value.statements
}

module "iam" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//iam?archive=zip"
  role       = var.role
  depends_on = [module.iam_policy]
}

//END=RDS
module "cognito" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cognito?archive=zip"

  count      = 1
  tenants    = var.tenants
  depends_on = [module.lambda]
}

module "lambda" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//lambda/zip?archive=zip"
  lambda     = var.lambda
  depends_on = [module.iam]
}

### SQS ###

module "sqs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sqs?archive=zip"
  sqs    = var.sqs
}

module "webhook_sqs" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/sqs/1.0.0"
  sqs_name = "qs-${var.environment}-ec1-webhook-process-sqs-${contains(["dev", "test"], var.environment) ? "v2" : "v1"}"
  tags     = var.tags
}

# data "aws_security_group" "this" {
#   for_each   = var.lb
#   name       = each.value.security_group_name
#   depends_on = [module.lb_security_group, module.ilb_security_group, module.alb_security_group]
# }
# data "aws_subnets" "this_lb" {
#   for_each = var.lb
#   filter {
#     name   = "tag:Name"
#     values = each.value.lb_subnets_name
#   }
# }
# locals {
#   target_groups_data = merge(flatten([
#     for lb_details in values(var.lb) :
#     [lb_details.target_groups]
#   ])...)
#   listeners_data = merge(flatten([
#     for lb_details in values(var.lb) :
#     [lb_details.listeners]
#   ])...)
# }
# data "aws_instance" "this" {
#   for_each = { for k, v in local.target_groups_data : k => v if v.target_type == "instance" }
#   filter {
#     name   = "tag:Name"
#     values = [each.value.target_name]
#   }
#   filter {
#     name   = "instance-state-name"
#     values = ["running"]
#   }
#   //depends_on = [ module.ec2 ]
# }
# data "aws_lambda_function" "this" {
#   for_each      = { for k, v in local.target_groups_data : k => v if v.target_type == "lambda" }
#   function_name = each.value.target_name
#   depends_on    = [module.lambda]
# }
# data "aws_route53_zone" "this" {
#   for_each     = { for k, v in local.listeners_data : k => v if v.hosted_zone != null }
#   name         = each.value.hosted_zone
#   private_zone = each.value.is_private_zone
# }
# locals {
#   transformed_target_groups = merge([for k, v in var.lb : {
#     for tg_key, tg_value in v.target_groups : "${k}/${tg_key}" => merge({ key = k }, tg_value)
#   } if v.target_groups != null]...)
# }
# locals {
#   all_target_groups_names = flatten([
#     [
#       for lb_key, lb in var.lb : [
#         for listener_key, listener in lb.listeners :
#         listener.forward.target_group_name
#         if try(listener.forward.target_group_name, null) != null
#       ]
#     ],
#     [
#       for lb_key, lb in var.lb : [
#         for listener_key, listener in lb.listeners : [
#           for rule_key, rule in listener.rules :
#           rule.forward.target_group_name
#           if try(rule.forward.target_group_name, null) != null
#         ] if listener.rules != null
#       ]
#     ]
#   ])
#   unique_target_group_names = distinct(local.all_target_groups_names)
#   target_group_arns = {
#     for tg_name in local.unique_target_group_names :
#     tg_name => module.target_group[tg_name].arn
#   }
#   depends_on = [module.target_group]
# }
# module "target_group" {
#   for_each = { for k, v in local.transformed_target_groups : v.name => {
#     name                 = v.name
#     target_type          = v.target_type
#     protocol             = v.protocol
#     port                 = v.port
#     vpc_id               = v.vpc_name
#     deregistration_delay = v.deregistration_delay
#     health_check         = v.health_check
#     target_name          = v.target_name
#     target_port          = v.target_port
#     }
#   }
#   source               = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//lb/target_group?archive=zip"
#   target_group_name    = each.value.name
#   vpc_id               = each.value.target_type != "lambda" ? data.aws_vpc.this.id : null //lookup(data.aws_vpc.tg, each.key, null) != null ? data.aws_vpc.tg[each.key].id : null
#   port                 = each.value.port
#   protocol             = each.value.protocol
#   target_type          = each.value.target_type
#   deregistration_delay = each.value.deregistration_delay
#   enable_stickiness   = try(each.value.enable_stickiness, false)
#   stickiness_type     = try(each.value.stickiness_type, "lb_cookie")
#   stickiness_duration = try(each.value.stickiness_duration, 86400)

#   health_check = {
#     enabled             = true
#     path                = try(each.value.health_check.path, "/")
#     interval            = try(each.value.health_check.interval, 5)
#     timeout             = try(each.value.health_check.timeout, 4)
#     healthy_threshold   = try(each.value.health_check.healthy_threshold, 2)
#     unhealthy_threshold = try(each.value.health_check.unhealthy_threshold, 3)
#     matcher             = try(each.value.health_check.matcher, "200-399")
#     port                = try(each.value.health_check.port, 443)
#   }
#   tags = try(each.value.tags, null)
# }
# module "lb" {
#   for_each                      = var.lb
#   source                        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//lb?archive=zip"
#   lb_security_groups            = [data.aws_security_group.this[each.key].id]
#   lb_subnets                    = data.aws_subnets.this_lb[each.key].ids
#   lb_enable_deletion_protection = each.value.lb_enable_deletion_protection
#   lb_name                       = each.value.lb_name
#   lb_type                       = each.value.lb_type
#   is_nlb                        = each.value.is_nlb
#   vpc_id                        = data.aws_vpc.this.id
#   is_internal_lb                = each.value.is_internal_lb
#   lb_idle_timeout               = each.value.lb_idle_timeout
#   lb_client_keep_alive          = each.value.lb_client_keep_alive
#   rules_tg                      = local.target_group_arns
#   enable_access_logs            = each.value.enable_access_logs
#   alb_s3_log_bucket_name        = each.value.alb_s3_log_bucket_name
#   listeners = {
#     for key, value in each.value.listeners : key => merge(value, {
#       hosted_zone_id = value.protocol != "HTTP" ? (each.value.is_nlb == false && value.hosted_zone != null ? data.aws_route53_zone.this[key].zone_id : null) : null
#       tg_arn         = try(value.forward.target_group_name, "") == "" ? null : module.target_group[value.forward.target_group_name].arn
#     })
#   }
#   target_groups = {
#     for key, value in each.value.target_groups : key => merge(value, {
#       target_name = value.target_type == "instance" ? data.aws_instance.this[key].id : (value.target_type == "lambda" ? data.aws_lambda_function.this[key].id : null)
#       tg          = module.target_group[value.name].arn != null ? module.target_group[value.name].arn : null
#     })
#   }
#   tags       = var.tags
#   depends_on = [module.lb_security_group, module.target_group]
# }
//END=LB

# locals {
#   transformed_ecs = {
#     for k, v in var.ecs :
#     k => merge(v, {
#       existing_service       = try(v.existing_service, false)
#       ecs_name               = v.ecs_name
#       family                 = v.family
#       desired_count          = v.desired_count
#       target_group_name      = v.target_group_name
#       subnets                = v.subnets
#       enable_execute_command = v.enable_execute_command
#       cpu_task_definition    = v.cpu_task_definition
#       memory_task_definition = v.memory_task_definition
#       log_group_name         = v.log_group_name
#       ingress_port           = v.ingress_port
#       execution_role_name    = v.execution_role_name
#       task_role_name         = v.task_role_name

#       # container_definition
#       secrets               = v.secrets
#       environment_variables = v.environment_variables
#       secret_manager_name   = v.secret_manager_arn
#       container_port        = v.container_port
#       host_port             = v.host_port
#       cpu                   = v.cpu
#       memory                = v.memory
#       logs_stream_prefix    = v.logs_stream_prefix
#       image_uri = "${lookup(data.terraform_remote_state.shared.outputs, replace("${v.ecs_name == "ai-agent" ? "ai_tools" : v.ecs_name == "2-agent-runtime" ? "agent-runtime" : v.ecs_name == "whg-agent-runtime" ? "agent-runtime" : v.ecs_name == "whg-api" ? "api" : v.ecs_name}_repository_url", "new", ""))}:${v.ecs_name == "2-agent-runtime" ? var.image_tags["agent-runtime"] : v.ecs_name == "whg-agent-runtime" ? var.image_tags["agent-runtime"] : v.ecs_name == "whg-api" ? var.image_tags["api"] : var.image_tags[k]}"
#       //"${lookup(data.terraform_remote_state.shared.outputs, replace("${v.ecs_name == "ai-agent" ? "ai_tools" : v.ecs_name}_repository_url", "new", ""))}:${var.image_tags[k]}"

#       # Autoscaling fields
#       autoscaling_enabled  = contains(keys(v), "autoscaling_enabled") ? v.autoscaling_enabled : false
#       autoscaling_policies = contains(keys(v), "autoscaling_policies") ? v.autoscaling_policies : []
#   })
#  }
# }

data "aws_subnets" "this_ecs" {
  for_each = var.ecs
  filter {
    name   = "tag:Name"
    values = each.value.subnets
  }
}

data "aws_iam_role" "this_execution_role" {
  for_each   = var.ecs
  name       = each.value.execution_role_name
  depends_on = [module.iam]
}

data "aws_iam_role" "this_task_role" {
  for_each   = var.ecs
  name       = each.value.task_role_name
  depends_on = [module.iam]
}

# data "aws_lb_target_group" "this" {
#   for_each = { for name in flatten([for k, v in var.ecs : v.target_group_name]) : name => name }
#   name     = each.value
#   depends_on = [module.target_group]
# }


data "aws_region" "current" {}


# module "cluster" {
#   source                    = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//ecs/cluster?archive=zip"
#   name                      = var.ecs_cluster_name
#   enable_container_insights = var.enable_container_insights
#   tags                      = var.tags
# }

# data "aws_security_groups" "this_ecs" {
#   for_each = var.ecs
#   filter {
#     name   = "group-name"
#     values = each.value.security_group_names
#   }

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.this.id]
#   }
# }

module "secrets" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//secrets?archive=zip"
  secret = var.secret
}

# data "aws_ecs_service" "existing" {
#   for_each = local.transformed_ecs
#   cluster_arn  = module.cluster.cluster_arn
#   service_name  = each.value.ecs_name
# }

# data "aws_ecs_service" "existing" {
#   for_each = {
#     for k, v in local.transformed_ecs : k => v
#     if v.existing_service
#   }

#   cluster_arn  = module.cluster.cluster_arn
#   service_name = each.value.ecs_name
# }

# module "ecs" {
#   for_each     = local.transformed_ecs
#   source       = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//ecs?archive=zip"
#   cluster_name = module.cluster.cluster_name
#   environment  = var.environment
#   ecs = {
#     for key, value in { "${each.key}" = each.value } : key => merge(value, {
#       subnets              = data.aws_subnets.this_ecs[key].ids
#       task_role_name       = data.aws_iam_role.this_task_role[key].arn
#       execution_role_name  = data.aws_iam_role.this_execution_role[key].arn
#       target_group_name    = [for tg in value.target_group_name : data.aws_lb_target_group.this[tg].arn]
#       security_group_names = data.aws_security_groups.this_ecs[key].ids
#       current_task_definition_arn = try(data.aws_ecs_service.existing[key].task_definition, null)
#     })
#   }
#   aws_region = data.aws_region.current.name
#   vpc_id     = data.aws_vpc.this.id
#   tags       = var.tags
#   depends_on = [data.aws_lb_target_group.this, module.secrets] //[module.lb]
# }

//END=ECS

module "appconfig" {
  source    = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//appconfig?archive=zip"
  appconfig = var.appconfig
}

module "schedulers" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//schedulers?archive=zip"
  schedulers = var.schedulers
  depends_on = [module.iam]
}

# Conversation Timeout Scheduler
resource "aws_scheduler_schedule" "conversation_timeout" {
  count                        = var.environment == "dev" || var.environment == "test" ? 1 : 0
  name                         = "qs-${var.environment}-ec1-customer0001-conversation-timeout-job-schedule-v1"
  description                  = "Conversation timeout job for customer0001"
  group_name                   = "default"
  schedule_expression          = "rate(10 minutes)"
  schedule_expression_timezone = "Asia/Calcutta"
  state                        = "ENABLED"

  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 5
  }

  target {
    arn      = "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:qs-${var.environment}-ec1-conversation-timeout-sqs-v1"
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/qs-${var.environment}-ec1-scheduler-iam-role"
    input    = jsonencode({
      jobType  = "CONVERSATION_TIMEOUT"
      tenantId = 1
    })

    retry_policy {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
  }

  depends_on = [module.sqs, module.iam]
}

# Redis
data "aws_subnets" "this_redis" {
  for_each = var.redis_subnet
  filter {
    name   = "tag:Name"
    values = each.value.subnet_name
  }
  // depends_on = [ data.aws_vpc.this ]
}

module "redis_subnet" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//redis/subnetgroup?archive=zip"
  for_each    = var.redis_subnet
  name        = each.value.name
  subnet_name = data.aws_subnets.this_redis[each.key].ids
  tags        = var.tags
  //depends_on = [module.vpc.vpc_id]
}

module "redis_parameter_group" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//redis/redis_parameter_group?archive=zip"
  for_each = var.redis_params

  name       = each.value.redis_pg_name
  family     = each.value.redis_pg_family
  parameters = each.value.redis_pg_parameters
}

module "redis" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//redis/redis?archive=zip"
  for_each = var.redis

  name                 = each.value.name
  size                 = each.value.size
  sneGroupName         = each.value.sneGroupName
  vpc_name             = each.value.vpc_name
  environment          = each.value.environment
  cluster_mode         = each.value.cluster_mode
  parameter_group_name = each.value.parameter_group_name
  num_cache_clusters   = each.value.num_cache_clusters
  tags                 = each.value.tags
  depends_on           = [module.redis_subnet, module.redis_parameter_group]
}

module "s3" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//s3?archive=zip"
  for_each = var.s3
  s3 = {
    "${each.key}" = merge(each.value, {
      kms_key_arn = each.value.kms_key_arn != null ? module.kms_new[each.value.kms_key_arn].target_key_id : null
    })
  }
}

data "aws_s3_bucket" "this" {
  for_each = toset(var.buckets)
  bucket   = each.value
}

module "s3_bucket_policy" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//s3/s3_policy?archive=zip"
  for_each = var.s3_bucket_policy

  bucket_id     = data.aws_s3_bucket.this[each.value.bucket_id].id
  bucket_policy = each.value.bucket_policy

  depends_on = [data.aws_s3_bucket.this]
}

# KMS New
module "kms_new" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//kms-new?archive=zip"
  for_each = var.kms-new

  environment             = each.value.environment
  key_name                = each.value.key_name
  enable_key_rotation     = each.value.enable_key_rotation
  deletion_window_in_days = each.value.deletion_window_in_days
  kms_key_policy          = each.value.kms_key_policy
  tags                    = each.value.tags
}

module "rds_parameter_group" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//db-parameter-group?archive=zip"
  name       = var.rds_pg_name
  family     = var.rds_pg_family
  parameters = var.rds_pg_parameters
}

module "rds_new" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//rds-new?archive=zip"
  for_each = var.rds-new

  vpc_name                     = each.value.vpc_name
  subnet_group_name            = each.value.subnet_group_name
  instance_name                = each.value.instance_name
  storage                      = each.value.storage
  max_storage                  = each.value.max_storage
  database_name                = each.value.database_name
  parameter_group_name         = each.value.parameter_group_name
  engine                       = each.value.engine
  engine_version               = each.value.engine_version
  instance_type                = each.value.instance_type
  username                     = each.value.username
  auto_minor_version_upgrade   = each.value.auto_minor_version_upgrade
  performance_insights_enabled = each.value.performance_insights_enabled
  storage_type                 = each.value.storage_type
  kms_key_arn                  = module.kms_new[each.value.kms_key_arn].target_key_id
  public_access                = each.value.public_access
  skip_final_snapshot          = each.value.skip_final_snapshot
  backup_retention_period      = each.value.backup_retention_period
  deletion_protection          = each.value.deletion_protection
  delete_automated_backups     = each.value.delete_automated_backups
  environment                  = each.value.environment
  tags                         = each.value.tags
  app_version                  = var.app_version
  depends_on                   = [module.rds_parameter_group, module.dbsubnet]
}

module "sns_topic" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sns/sns_topic?archive=zip"
  for_each = { for k, v in var.sns_topics : v.name => v }
  name     = each.value.name
}

module "sns_subscription" {
  source    = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sns/sns_topic_subscription?archive=zip"
  for_each  = var.sns_topic_subscription
  topic_arn = module.sns_topic[each.value.sns_name].arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint
}

module "cloudwatch_metric_alarm" {
  source                    = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cloudwatch_metric_alarm?archive=zip"
  for_each                  = var.alarms
  alarm_name                = each.value.alarm_name
  comparison_operator       = each.value.comparison_operator
  evaluation_periods        = each.value.evaluation_periods
  metric_name               = each.value.metric_name
  namespace                 = each.value.namespace
  period                    = each.value.period
  statistic                 = each.value.statistic
  threshold                 = each.value.threshold
  alarm_description         = each.value.alarm_description
  treat_missing_data        = each.value.treat_missing_data
  insufficient_data_actions = each.value.insufficient_data_actions
  alarm_actions             = [module.sns_topic[each.value.sns_name].arn]
  actions_enabled           = each.value.actions_enabled
  tags                      = each.value.tags
  dimensions_list = merge(each.value.dimensions, {
    InstanceId = contains(keys(each.value.dimensions), "InstanceId") ? module.ec2[each.value.ec2_key].instance_ids[each.value.ec2_key] : null
  })
  # InstanceId = contains(keys(each.value.dimensions), "InstanceId") ? module.ec2[each.value.ec2_key].instance_ids[each.value.ec2_key] : null }
}

### Cloudfront ###

# logo bucket
module "cloudfront_0001" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cloudfront?archive=zip"
  role_arn = var.role_arn

  origin                             = var.cf_origin_0001
  enableOriginAccessControl          = var.cf_enableOriginAccessControl_0001
  environment                        = var.environment
  default_cache_policy_id            = var.cf_default_cache_policy_id_0001
  default_response_headers_policy_id = var.cf_default_response_headers_policy_id_0001
  aliases                            = [var.environment != "prd" ? "assets.${var.environment}.octonomy.ai" : "assets.octonomy.ai"]
  acm_certificate_arn                = data.aws_acm_certificate.useast1.arn
  cloudfront_default_certificate     = var.cf_cloudfront_default_certificate_0001
}

# chat widget bucket
# module "cloudfront_0002" {
#   source  = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cloudfront?archive=zip"
#   role_arn = var.role_arn

#   origin  = var.cf_origin_0002
#   enableOriginAccessControl = var.cf_enableOriginAccessControl_0001
#   environment = var.environment
#   default_cache_policy_id = var.cf_default_cache_policy_id_0001
#   default_response_headers_policy_id = var.cf_default_response_headers_policy_id_0001
#   aliases = [var.environment != "prd" ? "chatwidget-migration.${var.environment}.octonomy.ai" : "chatwidget.octonomy.ai"]
#   acm_certificate_arn = data.aws_acm_certificate.useast1.arn
#   cloudfront_default_certificate = var.cf_cloudfront_default_certificate_0001
# }

# module "cloudfront_0003" {
#   source  = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cloudfront?archive=zip"
#   role_arn = var.role_arn

#   origin  = var.cf_origin_0003
#   enableOriginAccessControl = var.cf_enableOriginAccessControl_0003
#   web_acl_id = module.waf_acl_cloudfront["cloudfront_main"].waf_web_acl_arn
#   environment = var.environment
#   default_cache_policy_id = var.cf_default_cache_policy_id_0003
#   default_response_headers_policy_id = var.cf_default_response_headers_policy_id_0003
#   aliases = [ var.environment == "prd" ? "talentship.wss.octonomy.ai" : var.environment == "dev" ? "dummy.dev.wss.octonomy.ai" : "talentship.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "aofoundation.wss.octonomy.ai" : var.environment == "dev" ? "dummy1.dev.wss.octonomy.ai" : "aofoundation.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "burnhard.wss.octonomy.ai" : var.environment == "dev" ? "dummy2.dev.wss.octonomy.ai" : "burnhard.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "anwr.wss.octonomy.ai" : var.environment == "dev" ? "dummy3.dev.wss.octonomy.ai" : "anwr.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "hepster.wss.octonomy.ai" : var.environment == "dev" ? "dummy4.dev.wss.octonomy.ai" : "hepster.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "pfalzkom.wss.octonomy.ai" : var.environment == "dev" ? "dummy5.dev.wss.octonomy.ai" : "pfalzkom.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "berner.wss.octonomy.ai" : var.environment == "dev" ? "dummy6.dev.wss.octonomy.ai" : "berner.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "thyssen-gas.wss.octonomy.ai" : var.environment == "dev" ? "dummy7.dev.wss.octonomy.ai" : "thyssen-gas.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "havi.wss.octonomy.ai" : var.environment == "dev" ? "dummy8.dev.wss.octonomy.ai" : "havi.${var.environment}.wss.octonomy.ai", var.environment == "prd" ? "deutsche-windtechnik.wss.octonomy.ai" : var.environment == "dev" ? "dummy8.dev.wss.octonomy.ai" : "deutsche-windtechnik.${var.environment}.wss.octonomy.ai"  ]
#   acm_certificate_arn = var.acm_certificate_arn_0003
#   cloudfront_default_certificate = var.cf_cloudfront_default_certificate_0003
#   ordered_cache_behavior = var.ordered_cache_behavior_0003
#   default_origin_request_policy_id = var.default_origin_request_policy_id_0003
# }

module "resource_group" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//resource_group?archive=zip"
  for_each = var.resource_groups

  resource_group_name = each.value.resource_group_name
  resource_query      = each.value.resource_query
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  assume_role {
    role_arn = var.role_arn # same role used, must have us-east-1 access
  }
}

module "waf_acl_cloudfront" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//waf?archive=zip"
  for_each = { for k, v in var.waf_acls : k => v if v.scope == "CLOUDFRONT" }

  name            = each.value.name
  description     = each.value.description
  scope           = each.value.scope
  waf_rules       = each.value.waf_rules
  waf_metric_name = each.value.waf_metric_name
  log_group_name  = each.value.log_group_name
  addresses       = var.addresses
  tags            = var.tags
  providers = {
    aws = aws.us_east_1
  }
}

module "aws_cloudwatch_log_group" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//cloudwatch_log_group?archive=zip"
  for_each = var.cloudwatch_log_group

  log_group_name              = each.value.log_group_name
  log_group_retention_in_days = each.value.retention_in_days
  tags                        = var.tags
}
######################
# VPC Endpoints for S3
######################

data "aws_route_tables" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

module "s3_vpc_endpoints" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//vpc_endpoint?archive=zip"

  vpc_id          = data.aws_vpc.this.id
  service_name    = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids = data.aws_route_tables.this.ids
  tags = {
    Name      = "qs-${var.environment}-ec1-s3-vpc-endpoint-01",
    CreatedBy = "Terraform"
  }
}

module "private_s3_bucket_policy" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//s3/s3_policy?archive=zip"
  for_each = toset(var.private_buckets)

  bucket_id = each.value
  bucket_policy = {
    "Version" : "2012-10-17",
    "Id" : "Policy1415115909152",
    "Statement" : [
      {
        "Sid" : "Access-to-specific-VPCE-only",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : ["s3:GetObject", "s3:PutObject"],
        "Resource" : "arn:aws:s3:::${each.value}/*",
        "Condition" : {
          "StringEquals" : {
            "aws:sourceVpce" : "${module.s3_vpc_endpoints.id}"
          }
        }
      }
    ]
  }
}

######################
## FIFO SQS Queues  ##
######################

module "fifo_sqs_queue_llm" {
  source                     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//messaging/sqs/1.0.0" # Update with actual module path
  sqs_name                   = "oc-${var.environment}-${var.region_suffix}-ingestion-llm-sqs-${var.project_version}"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 12

  # FIFO Configuration
  fifo_queue                  = true
  content_based_deduplication = false
  deduplication_scope         = "queue"
  fifo_throughput_limit       = "perQueue"

  # SSE-SQS Encryption (Amazon SQS managed encryption)
  kms_master_key_id = null

  create_dlq = false

  tags = {
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
}

module "fifo_sqs_queue_loader" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//messaging/sqs/1.0.0" # Update with actual module path

  sqs_name                   = "oc-${var.environment}-${var.region_suffix}-ingestion-pgvector-loader-sqs-${var.project_version}"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # FIFO Configuration
  fifo_queue                  = true
  content_based_deduplication = false
  deduplication_scope         = "queue"
  fifo_throughput_limit       = "perQueue"

  # SSE-SQS Encryption (Amazon SQS managed encryption)
  kms_master_key_id = null

  create_dlq = false

  tags = {
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
}

module "fifo_sqs_queue_task" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//messaging/sqs/1.0.0" # Update with actual module path

  sqs_name                   = "oc-${var.environment}-${var.region_suffix}-ingestion-generic-sqs-${var.project_version}"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 12

  # FIFO Configuration
  fifo_queue                  = true
  content_based_deduplication = false
  deduplication_scope         = "queue"
  fifo_throughput_limit       = "perQueue"

  # SSE-SQS Encryption (Amazon SQS managed encryption)
  kms_master_key_id = null

  create_dlq = false

  tags = {
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
}