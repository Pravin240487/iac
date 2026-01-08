variable "vpc_name" {
  type = string
}

variable "key" {
  description = "Terraform state file path"
  type        = string
}

variable "region" {
  description = "region to create the resources"
  type        = string
  default     = "eu-central-1"
}

variable "role_arn" {
  description = "Role arn to assume"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = { Terraformed = "true"
    Owner = "Octonomy.devops@talentship.io"
  }
}

variable "vpc_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = { Terraformed = "true"
    Owner = "Octonomy.devops@talentship.io"
  }
}

#################################
########     VPC     ############
#################################

variable "cidr_block" {
  description = "cidr value is for the subnet"
  type        = string
}

# variable "public_subnets" {
#   description = "A map of public subnets with their CIDR blocks, availability zones, and names"
#   type = map(object({
#     cidr = string
#     az   = string
#     Name = string
#   }))
# }

# variable "private_subnets" {
#   description = "A map of private subnets with their CIDR blocks, availability zones, and names"
#   type = map(object({
#     cidr = string
#     az   = string
#     Name = string
#   }))
# }
variable "private_subnets" {
  type = list(object({
    cidr = string
    az   = string
    Name = string
    key  = string
  }))
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    Name = string
    key  = string
  }))
}

variable "nat_subnet_index" {
  description = "Subnet index number for the nat"
  type        = number
}

variable "nat_name" {
  type = string
}

# variable "image_tags" {
#   description = "Provide values in k v , where k is key name of the service and value is the tag from CI"
#   default     = {} #  -var 'image_tags={"api"="latest", "app"="v1.0"}'
#   type        = map(string)
# }

# #################################
# ########     EC2     ############
# #################################

variable "instances" {
  description = "A map of instances, where each key represents an instance name and the value is an object defining the instance attributes, such as AMI ID, instance type, availability zone, disk size, and other configurations."
  type = map(object({
    ami                  = string
    instance_type        = string
    role_name            = optional(string, null)
    profile_name         = optional(string)
    availability_zone    = string
    disk_size            = number
    stop_protection      = bool
    delete_protection    = optional(bool, true)
    name                 = string
    use_user_data        = bool
    use_user_data_script = optional(bool, false)
    subnet_index         = number
    subnet_type          = string
    user_data_script     = string
    vpc_name             = string
    eip                  = bool
    ebs                  = bool
    secret               = bool
    ssh_pub_key          = string
    kms_key_arn          = optional(string)
    security_group_names = optional(list(string))
    ingress_ports        = optional(list(number))
    ingress = map(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      security_groups = optional(list(string), [])
      description     = optional(string, "")
    }))
  }))
}

variable "environment" {
  description = "The environment in which the instances are being deployed. Typical values are 'prod', 'dev', or 'test'."
  type        = string
}

variable "lb" {
  type = map(object({
    lb_name                       = optional(string, "main")
    lb_enable_deletion_protection = optional(bool, false)
    lb_type                       = optional(string, "application")
    is_nlb                        = optional(bool, false)
    lb_subnets_name               = list(string)
    is_internal_lb                = optional(bool)
    vpc_name                      = optional(string)
    enable_access_logs            = optional(bool)
    alb_s3_log_bucket_name        = optional(string)
    lb_idle_timeout               = number
    lb_client_keep_alive          = number
    security_group_name           = string
    listeners = map(object({
      port               = number
      protocol           = string
      ssl_policy         = optional(string, "ELBSecurityPolicy-2016-08")
      certificate_domain = optional(string)
      hosted_zone        = optional(string)
      is_private_zone    = optional(bool)
      default_action     = string # fixed-response or forward
      fixed_response = optional(object({
        content_type = string
        message_body = string
        status_code  = string
      }), null)
      forward = optional(object({
        target_group_name = string
      }), null)

      rules = optional(map(object({
        priority    = number
        action_type = string
        forward = optional(object({
          target_group_name = string
        }))
        host_header  = optional(list(string))
        http_header  = optional(list(string))
        path_pattern = optional(list(string))

        cognito_authentication = optional(object({
          user_pool_arn              = string
          user_pool_client_id        = string
          user_pool_domain           = string
          session_cookie_name        = string
          scope                      = string
          session_timeout            = number
          on_unauthenticated_request = string
        }), null)

        source_ips = optional(list(string), null)


      })), null)
    }))
    target_groups = map(object({
      name                 = string
      target_type          = string
      protocol             = optional(string, "HTTP")
      port                 = optional(number, 80)
      vpc_name             = optional(string)
      deregistration_delay = number
      health_check = optional(object({
        path                = optional(string)
        interval            = optional(number)
        timeout             = optional(number)
        healthy_threshold   = optional(number)
        unhealthy_threshold = optional(number)
        matcher             = optional(string)
        port                = optional(number)
      }))
      enable_stickiness   = optional(bool, false)
      stickiness_type     = optional(string, "lb_cookie")
      stickiness_duration = optional(number, 86400)
      target_name         = optional(string)
      target_port         = optional(number)
      })
    )
  }))
}

variable "alb_security_group" {
  type = string
}
# variable "nlb_security_group" {
#   type = string
# }
variable "ilb_security_group" {
  type = string
}
variable "wss_alb_security_group" {
  type = string
}

variable "ecs_cluster_name" {
  type    = string
  default = "main"
}

variable "enable_container_insights" {
  type = bool
}

variable "ecs" {
  type = map(object({
    existing_service       = optional(bool, true)
    ecs_name               = string
    family                 = string
    desired_count          = optional(number, 1)
    target_group_name      = list(string)
    subnets                = list(string)
    enable_execute_command = optional(bool, true)
    cpu_task_definition    = number
    memory_task_definition = number
    log_group_name         = string
    ingress_port           = number
    execution_role_name    = string
    task_role_name         = string

    # container_definition
    secrets = optional(list(string))
    environment_variables = optional(list(object({
      name  = string
      value = string
    })))
    secret_manager_arn   = optional(string)
    container_port       = optional(number, 3000)
    host_port            = optional(number, 3000)
    cpu                  = optional(number, 2048)
    memory               = optional(number, 4096)
    logs_stream_prefix   = optional(string, "ecs")
    security_group_names = list(string)
    autoscaling_enabled  = optional(bool, false)
    autoscaling_policies = optional(list(object({
      name                   = string
      policy_type            = string # e.g., "TargetTrackingScaling"
      scalable_dimension     = string # e.g., "ecs:service:DesiredCount"
      service_namespace      = string # e.g., "ecs"
      max_capacity           = number
      min_capacity           = number
      target_value           = number
      predefined_metric_type = string # e.g., "ECSServiceAverageCPUUtilization"
      scale_in_cooldown      = number
      scale_out_cooldown     = number
    })), [])
  }))
}

# Subnet Group

variable "dbsubnet" {
  type = map(object({
    name        = string
    subnet_name = list(string)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

# RDS

variable "rds" {
  type = map(object({
    vpc_name                     = string
    subnet_group_name            = string
    instance_name                = string
    storage                      = optional(number, 20)
    max_storage                  = optional(number, 22)
    database_name                = optional(string, "masterdb")
    engine                       = optional(string, "postgres")
    engine_version               = optional(string, "16.3")
    instance_type                = optional(string, "db.t4g.micro")
    username                     = optional(string, "masteruser")
    auto_minor_version_upgrade   = optional(bool, false)
    performance_insights_enabled = optional(bool, true)
    storage_type                 = optional(string, "gp3")
    kms_key_arn                  = string
    public_access                = optional(bool, false)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
  default = null
}

# Cognito

variable "tenants" {
  type = map(object({
    user_pool_name               = string
    deletion_protection          = optional(string, "ACTIVE")
    post_confirmation_lambda_arn = optional(string, null)
    user_pool_schemas = optional(list(object({
      attribute_data_type = string
      name                = string
      required            = bool
      mutable             = bool
      string_attribute_constraints = object({
        min_length = number
        max_length = number
      })
    })), null)

    # Adding IDP configuration
    idp = optional(map(object({
      idp_name       = string
      metadataUrl    = string
      idp_attributes = optional(map(string), {})
    })), null)
    app_client_name = string
    callbackUrls    = list(string)
    logout_urls     = list(string)
    token_validity_units = optional(object({
      refresh_token = string
      access_token  = string
      id_token      = string
      }), {
      refresh_token = "days"
      access_token  = "days"
      id_token      = "days"
    })
    token_validity_periods = optional(object({
      refresh_token = number
      access_token  = number
      id_token      = number
      }), {
      refresh_token = 1
      access_token  = 1
      id_token      = 1
    })
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
  default = null
}

#Lambda

variable "lambda" {
  type = map(object({
    function_name = string
    handler       = optional(string, "index.handler")
    runtime       = optional(string, "nodejs20.x")
    role_name     = string
    memory_size   = optional(number, 128)
    timeout       = optional(number, 3)
    variables     = optional(map(string), {})
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

#sqs

variable "sqs" {
  type = map(object({
    name                      = string
    delay_seconds             = optional(number, 0)
    max_message_size          = optional(number, 262144)
    message_retention_seconds = optional(number, 345600)
    receive_wait_time_seconds = optional(number, 0)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

# App Config

variable "appconfig" {
  type = map(object({
    app_name = any
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
    environment = map(object({
      name        = string
      description = optional(string, null)
      tags = optional(map(string), { Terraformed = "true"
        Owner = "Octonomy.devops@talentship.io"
      })
    }))
    config = map(object({
      name        = string
      description = optional(string, null)
      tags = optional(map(string), { Terraformed = "true"
        Owner = "Octonomy.devops@talentship.io"
      })
    }))
  }))
}

# scheduler
variable "schedulers" {
  description = "List of schedule configurations"
  type = list(object({
    name                         = string
    description                  = string
    job_id                       = string
    job_type                     = string
    tenant_id                    = number
    schedule_expression          = string
    group_name                   = string
    sqs_name                     = string
    execution_role               = string
    schedule_expression_timezone = string # Added timezone here
    state                        = string # Added state here
    retry_policy = object({               # Added retry policy here
      maximum_event_age_in_seconds = number
      maximum_retry_attempts       = number
    })
    flexible_time_window = object({ # Added flexible time window configuration
      maximum_window_in_minutes = number
      mode                      = string
    })
  }))
}

variable "secret" {
  type = map(object({
    secret_name = string
    secret_keys = map(string)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

# IAM

variable "iam_policies" {
  type = map(object({
    name        = string
    description = string
    statements = list(object({
      Action   = list(string)
      Effect   = string
      Resource = list(string)
    }))
  }))
}

variable "role" {
  type = map(object({
    name           = string
    type           = string
    service_type   = list(string)
    permission_arn = list(string)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

# Redis Subnet Group
variable "redis_subnet" {
  type = map(object({
    name        = string
    subnet_name = list(string)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

# Redis Parameter Group
variable "redis_params" {
  type = map(object({
    redis_pg_name   = string
    redis_pg_family = string
    redis_pg_parameters = optional(list(object({
      name  = string
      value = string
    })), [])
  }))
}

# Redis
variable "redis" {
  type = map(object({
    name                 = string
    size                 = string
    sneGroupName         = string
    vpc_name             = string
    environment          = string
    num_cache_clusters   = optional(number, 2)
    cluster_mode         = optional(string, "disabled")
    parameter_group_name = optional(string, "default.redis7.cluster.on")
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "s3" {
  type = map(object({
    bucket_name                        = string
    block_all_public_access            = bool
    noncurrent_version_expiration_days = optional(number, 30)
    kms_key_arn                        = optional(string, null)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "buckets" {
  type    = list(string)
  default = []
}

variable "s3_bucket_policy" {
  type = map(object({
    bucket_id     = string
    bucket_policy = any
  }))
}

# KMS New

variable "kms-new" {
  type = map(object({
    environment             = string
    key_name                = string
    enable_key_rotation     = optional(bool, false)
    deletion_window_in_days = optional(number, 7)
    kms_key_policy = optional(any, {
      Id = "example"
      Statement = [
        {
          Action = "kms:*"
          Effect = "Allow"
          Principal = {
            AWS = "*"
          }
          Resource = "*"
          Sid      = "Enable IAM User Permissions"
        }
      ]
      Version = "2012-10-17"
    })
    tags = optional(map(string), {
      Terraformed = "true"
      Owner       = "Octonomy.devops@talentship.io"
    })
  }))
}

# RDS - New

# RDS Parameter Group
variable "rds_pg_name" {}

variable "rds_pg_family" {}

variable "rds_pg_parameters" {}

variable "rds-new" {
  type = map(object({
    vpc_name                     = string
    subnet_group_name            = string
    instance_name                = string
    storage                      = optional(number, 20)
    max_storage                  = optional(number, 22)
    database_name                = optional(string, "masterdb")
    engine                       = optional(string, "postgres")
    engine_version               = optional(string, "16.3")
    instance_type                = optional(string, "db.t4g.micro")
    username                     = optional(string, "masteruser")
    skip_final_snapshot          = optional(bool, false)
    backup_retention_period      = optional(number, 7)
    deletion_protection          = optional(bool, true)
    delete_automated_backups     = optional(bool, false)
    auto_minor_version_upgrade   = optional(bool, false)
    performance_insights_enabled = optional(bool, true)
    storage_type                 = optional(string, "gp3")
    kms_key_arn                  = string
    public_access                = optional(bool, false)
    parameter_group_name         = optional(string, "default.postgres16")
    environment                  = string
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "sns_topics" {
  type = map(object({
    name = string
  }))
}

variable "sns_topic_subscription" {
  type = map(object({
    sns_name = string
    protocol = string
    endpoint = string
  }))

}

variable "alarms" {
  type = map(object({
    alarm_name                = string
    comparison_operator       = string
    evaluation_periods        = number
    metric_name               = string
    namespace                 = string
    period                    = number
    statistic                 = string
    threshold                 = number
    alarm_description         = string
    treat_missing_data        = string
    insufficient_data_actions = list(string)
    sns_name                  = string
    ec2_key                   = optional(string)
    dimensions                = map(string)
    actions_enabled           = optional(bool, false)
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "app_version" {
  type = string
}
#################Sqs alarams variables################
variable "sqs_old_message_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "sqs_old_message_threshold" {
  default     = 300
  type        = number
  description = "The threshold of the alarm"
}
variable "sqs_oldest_message_statistic" {
  default     = "Maximum"
  type        = string
  description = "The statistic of the alarm"
}
variable "sqs_messages_not_visible_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "sqs_messages_not_visible_threshold" {
  default     = 100
  type        = number
  description = "The threshold of the alarm"
}
variable "sqs_messages_not_visible_statistic" {
  default     = "Maximum"
  type        = string
  description = "The statistic of the alarm"
}
variable "evaluation_periods" {
  default     = 1
  type        = number
  description = "The evaluation period of the alarm"
}
variable "sqs_actions_enabled" {
  default     = true
  type        = bool
  description = "The action enabled of the alarm"
}
# ############EC2 Alarm Variables################
# variable "ec2_network_in_alarm_period"{
#   default = 300
#   type = number
#   description = "The period of the alarm"
# }
# variable "ec2_network_in_alarm_threshold"{
#   default = 1000000
#   type = number
#   description = "The threshold of the alarm"
# }
# variable "ec2_network_in_alarm_statistic"{
#   default = "Sum"
#   type = string
#   description = "The statistic of the alarm"
# }
# variable "ec2_network_out_alarm_period"{
#   default = 300
#   type = number
#   description = "The period of the alarm"
# }
# variable "ec2_network_out_alarm_threshold"{
#   default = 1000000
#   type = number
#   description = "The threshold of the alarm"
# }
# variable "ec2_network_out_alarm_statistic"{
#   default = "Sum"
#   type = string
#   description = "The statistic of the alarm"
# }
############ECS Alarm Variables################
variable "ecs_mem_utilization_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "ecs_mem_utilization_threshold" {
  default     = 85
  type        = number
  description = "The threshold of the alarm"

}
variable "ecs_mem_utilization_statistic" {
  default     = "Maximum"
  type        = string
  description = "The statistic of the alarm"
}
variable "ecs_desired_task_count_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "ecs_desired_task_count_threshold" {
  default     = 1
  type        = number
  description = "The threshold of the alarm"
}
variable "ecs_desired_task_count_statistic" {
  default     = "Average"
  type        = string
  description = "The statistic of the alarm"
}
variable "lb_5xx_errors_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "lb_5xx_errors_threshold" {
  default     = 2
  type        = number
  description = "The threshold of the alarm"

}
variable "lb_5xx_errors_statistic" {
  default     = "Sum"
  type        = string
  description = "The statistic of the alarm"

}

############Redis Alarm Variables################
variable "redis_cpu_alarm_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "redis_cpu_alarm_statistic" {
  default     = "Maximum"
  type        = string
  description = "The statistic of the alarm"
}
variable "redis_memory_alarm_statistic" {
  default     = "Maximum"
  type        = string
  description = "The statistic of the alarm"
}
variable "redis_cpu_alarm_threshold" {
  default     = 85
  type        = number
  description = "The threshold of the alarm"
}
variable "redis_cpu_alarm_evaluation_period" {
  default     = 1
  type        = number
  description = "Thre evaluation period of the alarm"
}
variable "redis_cpu_alarm_datapoints" {
  default     = 1
  type        = number
  description = "The datapoints of the alarm"

}
###################Schedulers#####################
variable "schedulers_statistic" {
  default     = "Sum"
  type        = string
  description = "statictics for the schedulers"
}
variable "schedulers_period" {
  default     = 300
  type        = number
  description = "period for the schedulers metric alarm"
}
variable "schedulers_threshold" {
  default     = 1
  type        = number
  description = "threshold for the scheduler metric alarm"

}
variable "schedulers_datapts" {
  default     = 1
  type        = number
  description = "datapoints for the scheduler metric alarm"

}
variable "treat_missing_data" {
  default     = "notBreaching"
  type        = string
  description = "treat missing data for the scheduler metric alarm"

}
variable "treat_missing_data_breaching" {
  default     = "breaching"
  type        = string
  description = "treat missing data for the scheduler metric alarm"

}
#### Cloudfront0001 ###
variable "cf_origin_0001" {
  type = string
}

variable "cf_enableOriginAccessControl_0001" {
  type    = bool
  default = true
}

variable "cf_default_cache_policy_id_0001" {
  type    = string
  default = "Managed-CachingOptimized"
}

variable "cf_cloudfront_default_certificate_0001" {
  type    = bool
  default = false
}

variable "cf_default_response_headers_policy_id_0001" {
  type    = string
  default = "Managed-CORS-With-Preflight"
}

#### Cloudfront0002 ###
# variable "cf_origin_0002" {
#   type = string
# }

# variable "cf_enableOriginAccessControl_0002" {
#   type = bool
#   default = false
# }

# variable "cf_default_cache_policy_id_0002" {
#   type = string
#   default = "UseOriginCacheControlHeaders"
# }

# variable "cf_cloudfront_default_certificate_0002" {
#   type = bool
#   default = false
# }

# variable "cf_default_response_headers_policy_id_0002" {
#   type = string
#   default = "Managed-SimpleCORS"
# }

# variable "default_origin_request_policy_id_0002" {
#   type = string
#   default = "Managed-AllViewer"
# }

# variable "ordered_cache_behavior_0002" {
#   type = list(object({
#     path_pattern               = optional(string, "/*.png")
#     allowed_methods            = optional(list(string), ["GET", "HEAD"])
#     cached_methods             = optional(list(string), ["GET", "HEAD"])
#     cache_policy_id            = optional(string, "Managed-CachingOptimized")
#     origin_request_policy_id   = optional(string, "Managed-AllViewer")
#     response_headers_policy_id = optional(string, "Managed-CORS-With-Preflight")
#     min_ttl                    = optional(number, 0)
#     default_ttl                = optional(number, 0)
#     max_ttl                    = optional(number, 0)
#     compress                   = optional(bool, false)
#     viewer_protocol_policy     = optional(string, "redirect-to-https")
#   }))
#   default = []
# }

#### Cloudfront0003 ###
# variable "cf_origin_0003" {
#   type = string
# }

# variable "cf_enableOriginAccessControl_0003" {
#   type = bool
#   default = false
# }

# variable "cf_default_cache_policy_id_0003" {
#   type = string
#   default = "UseOriginCacheControlHeaders"
# }

# variable "cf_cloudfront_default_certificate_0003" {
#   type = bool
#   default = false
# }

# variable "cf_default_response_headers_policy_id_0003" {
#   type = string
#   default = "Managed-SimpleCORS"
# }

# variable "default_origin_request_policy_id_0003" {
#   type = string
#   default = "Managed-AllViewer"
# }

# variable "acm_certificate_arn_0003" {
#   type = string
# }

# variable "ordered_cache_behavior_0003" {
#   type = list(object({
#     path_pattern               = optional(string, "/*.png")
#     allowed_methods            = optional(list(string), ["GET", "HEAD"])
#     cached_methods             = optional(list(string), ["GET", "HEAD"])
#     cache_policy_id            = optional(string, "Managed-CachingOptimized")
#     origin_request_policy_id   = optional(string, "Managed-AllViewer")
#     response_headers_policy_id = optional(string, "Managed-CORS-With-Preflight")
#     min_ttl                    = optional(number, 0)
#     default_ttl                = optional(number, 0)
#     max_ttl                    = optional(number, 0)
#     compress                   = optional(bool, false)
#     viewer_protocol_policy     = optional(string, "redirect-to-https")
#   }))
#   default = []
# }

##########

variable "resource_groups" {
  type = map(object({
    resource_group_name = string
    resource_query      = string
  }))
}
# variable "retention_period" {
#   type = number
#   default = 7
#   description = "Retention period for the RDS snapshots"

# }
# variable "timeout" {
#   type = number
#   default = 30
#   description = "Timeout for the lambda function"
# }
# variable "memory_size" {
#   type = number
#   default = 128
#   description = "Memory size for the lambda function"

# }
variable "rds_instance_id" {
  type = string
}
# variable "ebs_volume_arns" {
#   type = list(string)
#   default = []

# }
variable "DBInstanceIdentifier" {
  type    = list(string)
  default = []
}
variable "rds_cpu_threshold" {
  type    = number
  default = 85
}
variable "alarm_period" {
  type    = number
  default = 300

}
variable "read_latency_threshold" {
  type    = number
  default = 0.12 # 120ms (in seconds)

}
variable "dbload_threshold" {
  type    = number
  default = 2

}
variable "dbconnection_threshold" {
  type    = number
  default = 367

}
variable "storage_threshold" {
  type    = number
  default = 4294967296 #4 Gb

}

variable "addresses" {
  type        = list(string)
  description = "List of IP addresses in CIDR notation"
}

variable "waf_acls" {
  description = "Map of WAF ACLs with rules"
  type = map(object({
    name            = string
    scope           = string
    description     = string
    waf_metric_name = string
    log_group_name  = string
    waf_rules = list(object({
      name                     = string
      priority                 = number
      statement_type           = string
      rate_limit               = optional(number)
      evaluation_window_sec    = optional(number)
      aggregate_key_type       = optional(string)
      vendor_name              = optional(string)
      rule_group_name          = optional(string)
      rule_action_overrides    = optional(list(string))
      country_codes            = optional(list(string))
      action                   = optional(string)
      override_action          = optional(string)
      response_code            = optional(number)
      custom_response_body_key = optional(string)
      metric_name              = string
      statement = optional(object({
        and_statement = optional(object({
          statements = list(object({
            byte_match_statement = optional(object({
              search_string         = string
              positional_constraint = string
              text_transformations = list(object({
                priority = number
                type     = string
              }))
            }))

            not_statement = optional(object({
            }))
          }))
        }))
      }))
    }))
  }))
  default = {
  }
}
variable "cloudwatch_log_group" {
  description = "Map of CloudWatch log group configurations"
  type = map(object({
    log_group_name    = string
    retention_in_days = optional(number, 90)
  }))
}
variable "private_buckets" {
  type        = list(string)
  default     = []
  description = "List of private S3 buckets that should not be publicly accessible"
}


variable "public_alb_subnet_ids" {
  type        = list(string)
  default     = []
  description = "List of public ALB subnet IDs"
}

variable "private_alb_subnet_ids" {
  type        = list(string)
  default     = []
  description = "List of private ALB subnet IDs"
}

variable "ecs_subnet_id" {
  type        = list(string)
  default     = []
  description = "List of ECS subnet IDs"
}
variable "ecs_cpu_utilization_period" {
  description = "Period for ECS CPU Utilization CloudWatch alarm"
  type        = number
  default     = 300
}

variable "ecs_cpu_utilization_statistic" {
  description = "Statistic type for ECS CPU Utilization"
  type        = string
  default     = "Average"
}

variable "ecs_cpu_utilization_threshold" {
  description = "Threshold for ECS CPU Utilization"
  type        = number
  default     = 80
}
variable "sns_actions_enabled" {
  default     = false
  type        = bool
  description = "The action enabled of the alarm"
}

## Powerbi
variable "ec2_subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the resources"
  default     = ""
}

variable "ec2_CIDR" {
  type        = string
  description = "CIDR block for the EC2 instance"
  default     = "125.17.235.158/32"
}

# Ingestion worker commands are now auto-generated from SQS URLs