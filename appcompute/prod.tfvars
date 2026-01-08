key = "prod/terraform.tfstate"

app_version = "v1"

#################################
########     ROLE     ###########
#################################

role_arn = "arn:aws:iam::597088029926:role/terraform-role"

#################################
########     TAG     ############
#################################

tags = {
  "Project"     = "qs"
  "Environment" = "prd"
  "Terraformed" = true
  "Version"     = "V1"
}


#################################
########     VPC     ############
#################################
vpc_name = "qs-prd-ec1-main-vpc-v1"
vpc_id   = "vpc-0b1866847ee875c6d"

cidr_block = "10.3.0.0/16"

public_subnets = [
  { cidr = "10.3.0.0/28", az = "eu-central-1a", Name = "qs-prd-ec1-public-sne-nat-01a-v1", key = "subnet1" },      #NAT
  { cidr = "10.3.0.32/27", az = "eu-central-1a", Name = "qs-prd-ec1-public-sne-alb-01a-v1", key = "subnet2" },     #ALB
  { cidr = "10.3.0.64/27", az = "eu-central-1b", Name = "qs-prd-ec1-public-sne-alb-02b-v1", key = "subnet3" },     #ALB
  { cidr = "10.3.0.96/27", az = "eu-central-1c", Name = "qs-prd-ec1-public-sne-alb-03c-v1", key = "subnet4" },     #ALB
  { cidr = "10.3.0.128/27", az = "eu-central-1a", Name = "qs-prd-ec1-public-sne-nlb-01a-v1", key = "subnet5" },    #NLB
  { cidr = "10.3.0.160/27", az = "eu-central-1b", Name = "qs-prd-ec1-public-sne-nlb-02b-v1", key = "subnet6" },    #NLB
  { cidr = "10.3.0.192/27", az = "eu-central-1c", Name = "qs-prd-ec1-public-sne-nlb-03c-v1", key = "subnet7" },    #NLB
  { cidr = "10.3.0.224/28", az = "eu-central-1a", Name = "qs-prd-ec1-public-sne-bastion-01a-v1", key = "subnet8" } #Bastion Host 

]

# Indicates index of the public subnet
nat_subnet_index = 0

# NAT Name
nat_name = "qs-prd-ec1-nat-v1"

# Private Subnets
private_subnets = [
  { cidr = "10.3.1.0/24", az = "eu-central-1a", Name = "qs-prd-ec1-private-sne-ecs-01a-v1", key = "subnet1" },    #ECS
  { cidr = "10.3.2.0/24", az = "eu-central-1a", Name = "qs-prd-ec1-private-sne-rds-01a-v1", key = "subnet2" },    #RDS
  { cidr = "10.3.3.0/24", az = "eu-central-1b", Name = "qs-prd-ec1-private-sne-rds-02b-v1", key = "subnet3" },    #RDS
  { cidr = "10.3.4.0/24", az = "eu-central-1c", Name = "qs-prd-ec1-private-sne-rds-03c-v1", key = "subnet4" },    #RDS
  { cidr = "10.3.5.0/27", az = "eu-central-1a", Name = "qs-prd-ec1-private-sne-lambda-01a-v1", key = "subnet5" }, #Lambda
  { cidr = "10.3.6.0/27", az = "eu-central-1a", Name = "qs-prd-ec1-private-sne-ilb-01a-v1", key = "subnet6" },    #ILB
  { cidr = "10.3.6.32/27", az = "eu-central-1b", Name = "qs-prd-ec1-private-sne-ilb-02b-v1", key = "subnet7" },   #ILB
  { cidr = "10.3.6.64/27", az = "eu-central-1c", Name = "qs-prd-ec1-private-sne-ilb-03c-v1", key = "subnet8" },   #ILB
  { cidr = "10.3.6.96/28", az = "eu-central-1a", Name = "qs-prd-ec1-private-sne-redis-01a-v1", key = "subnet9" }, #Redis
  { cidr = "10.3.7.0/24", az = "eu-central-1a", Name = "qs-prd-ec1-private-sne-glue-01a-v1", key = "subnet10" }   #Glue
]

vpc_tags = {
  "Name"        = "qs-prd-ec1-main-vpc-v1"
  "Project"     = "qs"
  "Environment" = "prd"
  "Terraformed" = true
  "Version"     = "V1"
}

#################################
########     EC2     ############
#################################

# Define the environment (e.g., "production", "prd", "test")
environment = "prd"

# Define EC2 instances
instances = {
  Bastion_Host = {
    ami               = "ami-0e04bcbe83a83792e"
    ssh_pub_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCfIvN9Mv5/L//y3N+PG95wP1ndNyuD/b+DZmvczq1sL291ysHnCeXqwLUP6fzuKyMG2v0CFQaweZCkKriTGghaPLqelUS4MMngH8lGi8HllRiTK9TZ7Wz9m7L9ml1pAWmQIYlcoDUweMUpW1DXytBGLigOdZOxCNu+dTS9GbE6aLc1JYmMIGcToWHti52ksEzjDL9QlRdVyKSV5NTyCYKVdieYfYOs9BYyXtiqJ+3XBF60S7M+CLAEAhyycEA+WQmAzhbQXeXaa+RfskLCcDT7QW676hMWoYF8+w9ZA7ItArwBxxNKqP2TE+S2hMBDg2tLhQMh2TFB9IEhJIhOokys0zuosBBoGQUO0r5C3tXFlCSRTtcjU61mi/u07cZGVpF+fnOWyK2qYH+19mNv3QSKLARFzdTIplEU8IQLpgJTgHzJnQi/qFrAkQY3fTzRAPhiUO4sNpMvHxzTl8A2kMm3GkQg9dWkrCrz0/J/CTOJ4S321+GDCUNdGFS2Q7QZ0jBZr30nRn8y0HDFY8f//5yBBee62nH6Gl5tUGC6ZrMW5C5JxrQxG7pSCIKFRxyP9Zs1F0ZrtfeVwGtESpT71ZXwFQ/X/P/q+QXgv0HVwqaJ/HI48jX03kEaVA0oHKpCf2VWjbKiaAGICFshbJkSGOOE+4zRa5MYZmiT0GBBf4KEXw=="
    instance_type     = "t2.micro"
    name              = "bastion"
    availability_zone = "eu-central-1b"
    disk_size         = 10
    stop_protection   = false
    delete_protection = false
    use_user_data     = false
    user_data_script  = null
    subnet_type       = "public"
    subnet_index      = 7
    vpc_name          = "qs-prd-ec1-main-vpc-v1"
    eip               = false
    ebs               = false
    secret            = false
    ingress = {
      sshoffice = {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["125.17.235.158/32"] # Example of a specific IP range
        security_groups = []
        description     = "office ssh"
      }
      sshtemp = {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["3.120.181.40/29"] # Example of a specific IP range
        security_groups = []
        description     = "AWS Static IP EC2 instance connect"
      }
    }
  }
}

#################################
### APPLICATION LOAD BALANCER ###
#################################

ecs_cluster_name          = "qs-prd-ec1-main-ecs-v1"
enable_container_insights = true

alb_security_group     = "qs-prd-ec1-alb-nsg"
ilb_security_group     = "qs-prd-ec1-ilb-nsg"
wss_alb_security_group = "qs-prd-ec1-wss-alb-nsg"

lb = {
  "alb" = {
    lb_enable_deletion_protection = false
    lb_name                       = "qs-prd-ec1-main-alb-v1"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-prd-ec1-main-vpc-v1"
    lb_subnets_name               = ["qs-prd-ec1-public-sne-alb-01a-v1", "qs-prd-ec1-public-sne-alb-02b-v1", "qs-prd-ec1-public-sne-alb-03c-v1"]
    security_group_name           = "qs-prd-ec1-alb-nsg"
    lb_idle_timeout               = 60
    lb_client_keep_alive          = 3600
    is_internal_lb                = false
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-prd-ec1-main-alb-logs"
    listeners = {
      alblistener80 = {
        port           = 80
        protocol       = "HTTP"
        default_action = "redirect"
      }
      alblistener443 = {
        port               = 443
        protocol           = "HTTPS"
        ssl_policy         = "ELBSecurityPolicy-2016-08"
        certificate_domain = "*.octonomy.ai"
        hosted_zone        = "octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          Api = {
            tags         = { "Name" = "API" }
            priority     = 20
            action_type  = "forward"
            host_header  = ["*.octonomy.ai"]
            path_pattern = ["/api/appconnect/*"]
            forward = {
              target_group_name = "qs-prd-api-alb"
            }
          }
          App = {
            tags        = { "Name" = "APP" }
            priority    = 21
            action_type = "forward"
            host_header = ["*.octonomy.ai"]
            forward = {
              target_group_name = "qs-prd-app-alb"
            }
          }
          AI-Agent = {
            tags        = { "Name" = "AI-Agent" }
            priority    = 10
            action_type = "forward"
            host_header = ["ai-agent.octonomy.ai"]
            forward = {
              target_group_name = "qs-prd-ai-agent-alb"
            }
          }
          librarian-assets = {
            tags         = { "Name" = "Librarian-assets" }
            priority     = 19
            action_type  = "forward"
            host_header  = ["*.octonomy.ai"]
            path_pattern = ["/assets/*"]
            forward = {
              target_group_name = "qs-prd-librarian-assets-alb"
            }
          }
        }
      }
    }
    target_groups = {
      ai-agent = {
        name                 = "qs-prd-ai-agent-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          matcher             = "200-499"
          port                = 80
        }
      }
      api = {
        name                 = "qs-prd-api-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/api/appconnect/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          matcher             = "200-499"
          port                = 3001
        }
      }
      app = {
        name                 = "qs-prd-app-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        deregistration_delay = 5
        health_check = {
          path                = "/"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          matcher             = "200-499"
          port                = 3000
        }
      }
      librarian-assets = {
        name                 = "qs-prd-librarian-assets-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/"
          interval            = 300
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 9099
          matcher             = "200-499"
        }
      }
    }
  }
  #################################
  #### INTERNAL LOAD BALANCER #####
  #################################
  "internal" = {
    lb_enable_deletion_protection = false
    lb_name                       = "qs-prd-ec1-main-ilb-v1"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-prd-ec1-main-vpc-v1"
    lb_subnets_name               = ["qs-prd-ec1-private-sne-ilb-01a-v1", "qs-prd-ec1-private-sne-ilb-02b-v1", "qs-prd-ec1-private-sne-ilb-03c-v1"]
    security_group_name           = "qs-prd-ec1-ilb-nsg"
    is_internal_lb                = true
    lb_idle_timeout               = 300
    lb_client_keep_alive          = 3600
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-prd-ec1-main-ilb-alb-logs"
    listeners = {
      internallistener80 = {
        port           = 80
        protocol       = "HTTP"
        default_action = "forward"
        forward = {
          target_group_name = "qs-prd-scheduler-ilb"
        }
      }
      internallistener443 = {
        port               = 443
        protocol           = "HTTPS"
        ssl_policy         = "ELBSecurityPolicy-2016-08"
        certificate_domain = "*.internal.octonomy.ai"
        hosted_zone        = "internal.octonomy.ai"
        is_private_zone    = false
        default_action     = "forward"
        forward = {
          target_group_name = "qs-prd-scheduler-ilb"
        }
        rules = {
          internal-scheduler = {
            tags         = { "Name" = "scheduler" }
            priority     = 2
            action_type  = "forward"
            path_pattern = ["/scheduler/*"]
            forward = {
              target_group_name = "qs-prd-scheduler-ilb"
            }
          }
          internal-dbms = {
            tags         = { "Name" = "dbms" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/dbms/*"]
            forward = {
              target_group_name = "qs-prd-dbms-ilb"
            }
          }
          internal-etl = {
            tags         = { "Name" = "etl" }
            priority     = 3
            action_type  = "forward"
            path_pattern = ["/etl/*"]
            forward = {
              target_group_name = "qs-prd-etl-ilb"
            }
          }
          internal-integration = {
            tags         = { "Name" = "integration" }
            priority     = 4
            action_type  = "forward"
            path_pattern = ["/integration/*"]
            forward = {
              target_group_name = "qs-prd-integration-ilb"
            }
          }
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 5
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*"]
            forward = {
              target_group_name = "qs-prd-agent-runtime-ilb"
            }
          }
          librarian-retrieval = {
            tags         = { "Name" = "Librarian-Retrieval" }
            priority     = 6
            action_type  = "forward"
            path_pattern = ["/librarian/*"]
            forward = {
              target_group_name = "qs-prd-librarian-retrieval-ilb"
            }
          }
        }
      }
    }
    target_groups = {
      internal-dbms = {
        name                 = "qs-prd-dbms-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        deregistration_delay = 5
        health_check = {
          path                = "/dbms/api/v1/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 3002
          matcher             = "200-499"
        }
      }
      internal-scheduler = {
        name                 = "qs-prd-scheduler-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/scheduler/api/v1/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 3003
          matcher             = "200-499"
        }
      }
      internal-etl = {
        name                 = "qs-prd-etl-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/etl/api/v1/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 3004
          matcher             = "200-499"
        }
      }
      internal-integration = {
        name                 = "qs-prd-integration-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/integration/api/v1/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 3005
          matcher             = "200-499"
        }
      }
      internal-agent-runtime = {
        name                 = "qs-prd-agent-runtime-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/agent-runtime/api/v1/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 3006
          matcher             = "200-499"
        }
      }
      internal-librarian-retrieval = {
        name                 = "qs-prd-librarian-retrieval-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/"
          interval            = 300
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          port                = 9098
          matcher             = "200-499"
        }
      }
    }
  }
  "alb_001" = {
    lb_enable_deletion_protection = false
    lb_name                       = "qs-prd-ec1-wss-alb-v1"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-prd-ec1-main-vpc-v1"
    lb_subnets_name               = ["qs-prd-ec1-public-sne-alb-01a-v1", "qs-prd-ec1-public-sne-alb-02b-v1", "qs-prd-ec1-public-sne-alb-03c-v1"]
    security_group_name           = "qs-prd-ec1-wss-alb-nsg"
    is_internal_lb                = false
    lb_idle_timeout               = 1800
    lb_client_keep_alive          = 1800
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-prd-ec1-wss-alb-logs"
    listeners = {
      albwsslistener80 = {
        port           = 80
        protocol       = "HTTP"
        default_action = "redirect"
      }
      albwsslistener443 = {
        port               = 443
        protocol           = "HTTPS"
        ssl_policy         = "ELBSecurityPolicy-2016-08"
        certificate_domain = "*.wss.octonomy.ai"
        hosted_zone        = "wss.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*", "/socket.io/*"]
            host_header  = ["*.wss.octonomy.ai"]
            forward = {
              target_group_name = "prd-qs-tg-alb-agent-runtime-v1"
            }
          }
          #  x-agent-runtime = {
          #     tags        = { "Name" = "2-agent-runtime" }
          #     priority    = 2
          #     action_type = "forward"
          #     path_pattern = ["/agent-runtime/*", "/socket.io/*"]
          #     host_header = ["*.wss.octonomy.ai"]
          #     http_header = ["widget"]
          #     forward = {
          #       target_group_name = "prd-qs-tg-alb-agent-runtime-2-v1"
          #     }
          #   }
        }
      }
    }
    target_groups = {
      agent-runtime = {
        name                 = "prd-qs-tg-alb-agent-runtime-v1"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-prd-ec1-main-vpc-v1"
        health_check = {
          path                = "/agent-runtime/api/v1/health-check"
          interval            = 50
          timeout             = 30
          healthy_threshold   = 2
          unhealthy_threshold = 3
          matcher             = "200-499"
          port                = 3006
        }
        enable_stickiness   = true
        stickiness_type     = "lb_cookie"
        stickiness_duration = 86400
      }


    }
  }
}

#################################
########     ECS     ############
#################################

ecs = {
  api = {
    existing_service       = true
    ecs_name               = "api"
    family                 = "qs-prd-ec1-api-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-api-alb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-api-ecs"
    ingress_port           = 3001
    secret_manager_name    = "qs-prd-api"
    secrets                = ["DATABASE_URL"]
    execution_role_name    = "qs-prd-ec1-api-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-api-ecs-iam-role"
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "VAPI_API_ENDPOINT", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
    secret_manager_arn     = "qs-prd-ec1-api-secret-v1"
    logs_stream_prefix     = "qs-prd-ec1-api-ecs"
    container_name         = "qs-prd-ec1-api-ecs"
    container_port         = 3001
    host_port              = 3001
    cpu                    = 2048
    memory                 = 4096
    security_group_names   = ["qs-prd-ec1-alb-nsg"]
  }
  app = {
    existing_service       = true
    ecs_name               = "app"
    family                 = "qs-prd-ec1-app-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-app-alb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-app-ecs"
    execution_role_name    = "qs-prd-ec1-app-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-app-ecs-iam-role"
    ingress_port           = 3000

    container_name = "qs-prd-ec1-app-ecs"

    container_port       = 3000
    host_port            = 3000
    cpu                  = 2048
    memory               = 4096
    security_group_names = ["qs-prd-ec1-alb-nsg"]
  }
  dbms = {
    existing_service       = true
    ecs_name               = "dbms"
    family                 = "qs-prd-ec1-dbms-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-dbms-ilb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-dbms-ecs"
    ingress_port           = 3002
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "ALLOWED_PREFIXES", "DBMS_AUTH_TOKEN", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL_ETL", "SHADOW_DATABASE_URL_ETL", "AGENT_RUNTIME_SERVICE_URL", "INTEGRATION_SERVICE_URL", "SCH_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "AI_AGENT_AUTH_TOKEN"]
    secret_manager_arn     = "qs-prd-ec1-dbms-secret-v1"
    container_name         = "qs-prd-ec1-dbms-ecs"
    secret_manager_name    = "qs-prd-dbms"
    # secrets             = ["PORT"]
    container_port       = 3002
    host_port            = 3002
    cpu                  = 2048
    memory               = 4096
    execution_role_name  = "qs-prd-ec1-dbms-ecs-iam-role"
    task_role_name       = "qs-prd-ec1-dbms-ecs-iam-role"
    security_group_names = ["qs-prd-ec1-ilb-nsg"]
  }
  ai-agent = {
    existing_service       = true
    ecs_name               = "ai-agent"
    family                 = "qs-prd-ec1-ai-agent-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-ai-agent-alb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-ai-agent-ecs"
    ingress_port           = 80
    secrets                = ["RETRIVAL_AUTH_TOKEN", "VOYAGE_API_KEY", "VOYAGE_RERANK_MODEL"]
    secret_manager_arn     = "qs-prd-ec1-ai-agent-secret-v2"

    container_name       = "qs-prd-ec1-ai-agent-ecs"
    container_port       = 80
    host_port            = 80
    cpu                  = 2048
    memory               = 4096
    execution_role_name  = "qs-prd-ec1-ai-agent-ecs-iam-role"
    task_role_name       = "qs-prd-ec1-ai-agent-ecs-iam-role"
    security_group_names = ["qs-prd-ec1-alb-nsg"]
  }
  scheduler = {
    existing_service       = true
    ecs_name               = "scheduler"
    family                 = "qs-prd-ec1-scheduler-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-scheduler-ilb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-scheduler-ecs"
    ingress_port           = 3003
    secrets                = ["NODE_ENV", "AWS_REGION", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "COGNITO_WORKER_SQS_QUEUE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "COGNITO_USER_SYNC_SQS_QUEUE_URL", "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL", "DEFAULT_SCHEDULER_ROLE_ARN", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "FULL_LOAD_SQS_QUEUE_URL", "INCREMENTAL_LOAD_SQS_QUEUE_URL", "DBMS_SERVICE_URL", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "EVALUATION_SQS_QUEUE_URL", "WEBHOOK_WORKER_SQS_QUEUE_URL", "FISSION_STATUS_QUEUE_URL"]
    secret_manager_arn     = "qs-prd-ec1-scheduler-secret-v1"
    container_name         = "qs-prd-ec1-scheduler-ecs"
    container_port         = 3003
    host_port              = 3003
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-prd-ec1-scheduler-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-scheduler-ecs-iam-role"
    security_group_names   = ["qs-prd-ec1-ilb-nsg"]
  }
  agent-runtime = {
    existing_service       = true
    ecs_name               = "agent-runtime"
    family                 = "qs-prd-ec1-agent-runtime-ecs"
    desired_count          = 0
    target_group_name      = ["prd-qs-tg-alb-agent-runtime-v1", "qs-prd-agent-runtime-ilb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-agent-runtime-ecs"
    ingress_port           = 3006
    secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
    secret_manager_arn     = "qs-prd-ec1-agent-runtime-secret-v1"
    container_name         = "qs-prd-ec1-agent-runtime-ecs"
    container_port         = 3006
    host_port              = 3006
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-prd-ec1-agent-runtime-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-agent-runtime-ecs-iam-role"
    security_group_names   = ["qs-prd-ec1-wss-alb-nsg", "qs-prd-ec1-ilb-nsg"]
  }
  etl = {
    existing_service       = true
    ecs_name               = "etl"
    family                 = "qs-prd-ec1-etl-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-etl-ilb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-etl-ecs"
    ingress_port           = 3004
    secrets                = ["DATABASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "PORT", "ETL_AUTH_TOKEN", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "INTEG_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL"]
    secret_manager_arn     = "qs-prd-ec1-etl-secret-v1"
    container_name         = "qs-prd-ec1-etl-ecs"
    container_port         = 3004
    host_port              = 3004
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-prd-ec1-etl-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-etl-ecs-iam-role"
    security_group_names   = ["qs-prd-ec1-ilb-nsg"]
  }
  integration = {
    existing_service       = true
    ecs_name               = "integration"
    family                 = "qs-prd-ec1-integration-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-integration-ilb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-prd-ec1-integration-ecs"
    ingress_port           = 3005
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "CONFLUENCE_CONNECTION_ID", "ATLASSIAN_BASE_URL", "CONFLUENCE_BASE_URL", "CONFLUENCE_AUTH_TOKEN", "S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_DB_PASSWORD", "OPENAI_API_BASE_URL", "ANTHROPIC_API_BASE_URL", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "PG_DB_HOST", "PG_DB_PORT", "PG_DB_USERNAME", "PG_DB_PASSWORD", "PG_DB_NAME", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "DHL_API_BASE_URL", "GOKARLA_BASE_URL", "VAPI_API_ENDPOINT"]
    secret_manager_arn     = "qs-prd-ec1-integration-secret-v1"
    container_name         = "qs-prd-ec1-integration-ecs"
    container_port         = 3005
    host_port              = 3005
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-prd-ec1-integration-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-integration-ecs-iam-role"
    security_group_names   = ["qs-prd-ec1-ilb-nsg"]
  }
  librarian-retrieval = {
    existing_service       = false
    ecs_name               = "librarian-retrieval"
    family                 = "qs-prd-ec1-librarian-retrieval-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-librarian-retrieval-ilb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-prd-ec1-librarian-retrieval-ecs"
    ingress_port           = 9098
    secrets                = ["COMMON_DATABASE_URL", "DATABASE_URL", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "VOYAGEAI_API_URL", "VOYAGEAI_API_KEY", "ASSETS_API_PATH", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "API_VERSION"]
    secret_manager_arn     = "qs-prd-ec1-librarian-retrieval-secret-v1"
    container_name         = "qs-prd-ec1-librarian-ecs"
    container_port         = 9098
    host_port              = 9098
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-prd-ec1-librarian-retrieval-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-librarian-retrieval-ecs-iam-role"
    security_group_names   = ["qs-prd-ec1-ilb-nsg"]
  }
  librarian-assets = {
    existing_service       = false
    ecs_name               = "librarian-assets"
    family                 = "qs-prd-ec1-librarian-assets-ecs"
    desired_count          = 0
    target_group_name      = ["qs-prd-librarian-assets-alb"]
    subnets                = ["qs-prd-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-prd-ec1-librarian-assets-ecs"
    ingress_port           = 9099
    secrets                = ["COMMON_DATABASE_URL", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "SERVICE_NAME", "VOYAGEAI_API_URL", "VOYAGE_API_KEY", "CUSTOM_ACCESS_TOKEN_SECRET_KEY", "ENCRYPTION_KEY", "AUTH_STRATEGY", "CONFIGURATION_SCHEMA_BUCKET", "CONFIGURATION_SCHEMA_PATH", "CONFIGURATION_SCHEMA_DEFAULT_VERSION", "VECTOR_DB_TYPE", "DATABASE_URL"]
    secret_manager_arn     = "qs-prd-ec1-librarian-assets-secret-v1"
    container_name         = "qs-prd-ec1-librarian-assets-ecs"
    container_port         = 9099
    host_port              = 9099
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-prd-ec1-librarian-assets-ecs-iam-role"
    task_role_name         = "qs-prd-ec1-librarian-assets-ecs-iam-role"
    security_group_names   = ["qs-prd-ec1-alb-nsg"]
  }
}

#################################
######## DB SUBNET GROUP ########
#################################

dbsubnet = {
  subnet_group_01 = {
    name        = "qs-prd-ec1-db-sne-grp"
    subnet_name = ["qs-prd-ec1-private-sne-rds-01a-v1", "qs-prd-ec1-private-sne-rds-02b-v1", "qs-prd-ec1-private-sne-rds-03c-v1"]
  }
}

#################################
########     LAMBDA   ###########
#################################

# Lamda
lambda = {
  lambda01 = {
    function_name = "qs-prd-ec1-post-signup-trigger-lambda-v1"
    role_name     = "qs-prd-ec1-trigger-lambda-iam-role"
    variables = {
      DB_DATA_MIGRATION_SQS_QUEUE_URL = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-cognito-user-sync-sqs-v1"
    }
  }
}

#################################
########     SQS     ############
#################################

sqs = {
  sqs0001 = {
    name = "qs-prd-ec1-cognito-user-partial-sync-sqs-v1"
  }
  sqs0002 = {
    name = "qs-prd-ec1-cognito-user-sync-sqs-v1"
  }
  sqs0003 = {
    name = "qs-prd-ec1-db-data-migration-sqs-v1"
  }
  sqs0004 = {
    name = "qs-prd-ec1-prompt-process-sqs-v1"
  }
  sqs005 = {
    name = "qs-prd-ec1-prompt-process-sqs-v2"
  }
  sqs006 = {
    name = "qs-prd-ec1-prompt-process-sqs-v3"
  }
  sqs007 = {
    name = "qs-prd-ec1-prompt-process-sqs-v4"
  }
  sqs008 = {
    name = "qs-prd-ec1-whg-prompt-process-sqs-v1"
  }
  sqs009 = {
    name = "qs-prd-ec1-whg-prompt-process-sqs-v2"
  }
  sqs010 = {
    name = "qs-prd-ec1-whg-prompt-process-sqs-v3"
  }
  sqs011 = {
    name = "qs-prd-ec1-whg-prompt-process-sqs-v4"
  }
  sqs012 = {
    name = "qs-prd-ec1-cr-data-loader-sqs-v1"
  }
  sqs013 = {
    name = "qs-prd-ec1-db-schema-migration-sqs-v1"
  }
}

#################################
########  schedulers ############
#################################

schedulers = [
  {
    name                         = "qs-prd-ec1-customer0001-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0001"
    job_id                       = "1"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 1
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0002-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0002 "
    job_id                       = "12"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 12
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "DISABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0003-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0003 "
    job_id                       = "3"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 3
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0004-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0004"
    job_id                       = "4"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 4
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0005-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0005"
    job_id                       = "5"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 5
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0006-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0006"
    job_id                       = "6"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 6
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0010-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0010"
    job_id                       = "7"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 7
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0015-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0015"
    job_id                       = "8"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 8
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0014-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0014"
    job_id                       = "9"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 9
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0013-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0013"
    job_id                       = "10"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 10
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0008-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0008"
    job_id                       = "11"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 11
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0022-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0022"
    job_id                       = "13"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 13
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0007-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0007"
    job_id                       = "14"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 14
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0025-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0025"
    job_id                       = "15"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 15
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "ENABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0016-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0016"
    job_id                       = "16"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 16
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "DISABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0020-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0020"
    job_id                       = "17"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 17
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "DISABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0026-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0026"
    job_id                       = "18"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 18
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "DISABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  },
  {
    name                         = "qs-prd-ec1-customer0018-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0018"
    job_id                       = "19"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 19
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-prd-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-prd-ec1-scheduler-iam-role"
    schedule_expression_timezone = "Asia/Calcutta"
    state                        = "DISABLED"
    retry_policy = {
      maximum_event_age_in_seconds = 86400
      maximum_retry_attempts       = 185
    }
    flexible_time_window = {
      maximum_window_in_minutes = 5
      mode                      = "FLEXIBLE"
    }
  }  
]

#################################
########  App Config   ##########
#################################

appconfig = {
  "qs-prd-app-01" = {
    app_name = "qs-prd-ec1-app-appconfig-v1"
    tags = {
      "Project"     = "qs"
      "Environment" = "prd"
      "Terraformed" = true
      "Version"     = "V1"
    }
    environment = {
      "prd" = {
        name        = "prd"
        description = "production environment"
        tags = {
          "Project"     = "qs"
          "Environment" = "prd"
          "Terraformed" = true
          "Version"     = "V1"
        }
      }
    }
    config = {
      "config1" = {
        name        = "qs-prd-ec1-app-appconfig-feature-v1"
        description = "Primary configuration"
        tags = {
          "Project"     = "qs"
          "Environment" = "prd"
          "Terraformed" = true
          "Version"     = "V1"
        }
      }
    }
  }
}

#################################
##########   SECRET     ############
#################################

secret = {
  "api" = {
    secret_name = "qs-prd-ec1-api-secret-v1"
    secret_keys = {
      "ENCRYPTION_KEY"              = ""
      "UNIFIED_API_KEY"             = ""
      "UNIFIED_WORKSPACE_ID"        = ""
      "DATABASE_URL"                = ""
      "DATABASE_URL_CUSTOMER"       = ""
      "AWS_LAMBDA_ENDPOINT"         = ""
      "AWS_REGION"                  = ""
      "UNIFIED_ENV"                 = ""
      "UNIFIED_ENDPOINT"            = ""
      "NODE_ENV"                    = ""
      "AWS_S3_BUCKET_NAME"          = ""
      "COGNITO_CLIENT_ID"           = ""
      "COGNITO_USER_POOL_ID"        = ""
      "APP_CONFIG_APPLICATION"      = ""
      "APP_CONFIG_ENVIRONMENT"      = ""
      "APP_CONFIG_CONFIGURATION"    = ""
      "ETL_AUTH_TOKEN"              = ""
      "INTEG_AUTH_TOKEN"            = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "dbms" = {
    secret_name = "qs-prd-ec1-dbms-secret-v1"
    secret_keys = {
      "ENCRYPTION_KEY"                    = ""
      "UNIFIED_API_KEY"                   = ""
      "UNIFIED_WORKSPACE_ID"              = ""
      "DATABASE_URL"                      = ""
      "DATABASE_URL_CUSTOMER"             = ""
      "SHADOW_DATABASE_URL"               = ""
      "SHADOW_DATABASE_URL_CUSTOMER"      = ""
      "ALLOWED_PREFIXES"                  = ""
      "DBMS_AUTH_TOKEN"                   = ""
      "DB_DATA_MIGRATION_SQS_QUEUE_URL"   = ""
      "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL" = ""
      "UNIFIED_ENDPOINT"                  = ""
      "NODE_ENV"                          = ""
      "AWS_REGION"                        = ""
      "AWS_S3_BUCKET_NAME"                = ""
      "PORT"                              = ""
      "UNIFIED_ENV"                       = ""
      "APP_CONFIG_APPLICATION"            = ""
      "APP_CONFIG_ENVIRONMENT"            = ""
      "APP_CONFIG_CONFIGURATION"          = ""
      "ETL_AUTH_TOKEN"                    = ""
      "INTEG_AUTH_TOKEN"                  = ""
      "CLUSTER_MANAGER_ETL_ENABLED"       = ""
      "DATABASE_URL_ETL"                  = ""
      "SHADOW_DATABASE_URL_ETL"           = ""
    }
  }
  "integration" = {
    secret_name = "qs-prd-ec1-integration-secret-v1"
    secret_keys = {
      "ENCRYPTION_KEY"                    = ""
      "UNIFIED_API_KEY"                   = ""
      "UNIFIED_WORKSPACE_ID"              = ""
      "DATABASE_URL"                      = ""
      "DATABASE_URL_CUSTOMER"             = ""
      "SHADOW_DATABASE_URL"               = ""
      "SHADOW_DATABASE_URL_CUSTOMER"      = ""
      "DB_DATA_MIGRATION_SQS_QUEUE_URL"   = ""
      "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL" = ""
      "UNIFIED_ENDPOINT"                  = ""
      "NODE_ENV"                          = ""
      "AWS_REGION"                        = ""
      "AWS_S3_BUCKET_NAME"                = ""
      "PORT"                              = ""
      "UNIFIED_ENV"                       = ""
      "APP_CONFIG_APPLICATION"            = ""
      "APP_CONFIG_ENVIRONMENT"            = ""
      "APP_CONFIG_CONFIGURATION"          = ""
      "ETL_AUTH_TOKEN"                    = ""
      "INTEG_AUTH_TOKEN"                  = ""
      "JIRA_CONNECTION_ID"                = ""
      "CONFLUENCE_CONNECTION_ID"          = ""
      "ATLASSIAN_BASE_URL"                = ""
      "CONFLUENCE_BASE_URL"               = ""
      "CONFLUENCE_AUTH_TOKEN"             = ""
      "S3_BUCKET_NAME"                    = ""
      "CLUSTER_MANAGER_ETL_ENABLED"       = ""
      "ETL_SERVICE_URL"                   = ""
      "SCHEDULER_SERVICE_URL"             = ""
      "INTEGRATION_SERVICE_URL"           = ""
    }
  }
  "etl" = {
    secret_name = "qs-prd-ec1-etl-secret-v1"
    secret_keys = {
      "DATABASE_URL"                = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "agentruntime" = {
    secret_name = "qs-prd-ec1-agent-runtime-secret-v1"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "scheduler" = {
    secret_name = "qs-prd-ec1-scheduler-secret-v1"
    secret_keys = {
      "NODE_ENV"                                = ""
      "AWS_REGION"                              = ""
      "DATABASE_URL"                            = ""
      "DATABASE_URL_CUSTOMER"                   = ""
      "SHADOW_DATABASE_URL"                     = ""
      "SHADOW_DATABASE_URL_CUSTOMER"            = ""
      "COGNITO_WORKER_SQS_QUEUE_URL"            = ""
      "ALLOWED_PREFIXES"                        = ""
      "SCH_AUTH_TOKEN"                          = ""
      "COGNITO_USER_SYNC_SQS_QUEUE_URL"         = ""
      "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL" = ""
      "DEFAULT_SCHEDULER_ROLE_ARN"              = ""
      "APP_CONFIG_APPLICATION"                  = ""
      "APP_CONFIG_ENVIRONMENT"                  = ""
      "APP_CONFIG_CONFIGURATION"                = ""
      "ETL_AUTH_TOKEN"                          = ""
      "INTEG_AUTH_TOKEN"                        = ""
      "CLUSTER_MANAGER_ETL_ENABLED"             = ""
    }
  }
  "app" = {
    secret_name = "qs-prd-ec1-app-secret-v2"
    secret_keys = {
      "NEXT_PUBLIC_DOMAIN"        = "octonomy"
      "NEXT_PUBLIC_SOCKET_DOMAIN" = "wss.octonomy"
    }
  }
  "ai-agent" = {
    secret_name = "qs-prd-ec1-ai-agent-secret-v2"
    secret_keys = {
      "RETRIVAL_AUTH_TOKEN" = ""
      "VOYAGE_API_KEY"      = ""
      "VOYAGE_RERANK_MODEL" = ""
    }
  }
  "librarian-retrieval" = {
    secret_name = "qs-prd-ec1-librarian-retrieval-secret-v1"
    secret_keys = {
      "COMMON_DATABASE_URL"  = ""
      "DATABASE_URL"         = ""
      "ENV"                  = ""
      "LIBRARIAN_AUTH_TOKEN" = ""
      "OPENAI_API_KEY"       = ""
      "VOYAGEAI_API_URL"     = ""
      "VOYAGE_API_KEY"       = ""
      "ASSETS_API_PATH"      = ""
      "ETL_AUTH_TOKEN"       = ""
      "ETL_SERVICE_URL"      = ""
      "API_VERSION"          = ""
    }
  }
  "librarian-assets" = {
    secret_name = "qs-prd-ec1-librarian-assets-secret-v1"
    secret_keys = {
      "COMMON_DATABASE_URL"                  = ""
      "ENV"                                  = ""
      "LIBRARIAN_AUTH_TOKEN"                 = ""
      "OPENAI_API_KEY"                       = ""
      "SERVICE_NAME"                         = ""
      "VOYAGEAI_API_URL"                     = ""
      "VOYAGE_API_KEY"                       = ""
      "CUSTOM_ACCESS_TOKEN_SECRET_KEY"       = ""
      "ENCRYPTION_KEY"                       = ""
      "AUTH_STRATEGY"                        = ""
      "CONFIGURATION_SCHEMA_BUCKET"          = ""
      "CONFIGURATION_SCHEMA_PATH"            = ""
      "CONFIGURATION_SCHEMA_DEFAULT_VERSION" = ""
      "VECTOR_DB_TYPE"                       = ""
      "DATABASE_URL"                         = ""
    }
  }
  "agent-runtime" = {
    secret_name = "qs-prd-ec1-agent-runtime-secret-v3"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "whg-agent-runtime" = {
    secret_name = "qs-prd-ec1-whg-agent-runtime-secret-v1"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "librarian-migration" = {
    secret_name = "qs-prd-ec1-librarian-migration-secret-v1"
    secret_keys = {
      "COMMON_DATABASE_URL" = ""
      "DATABASE_URL"        = ""
    }
  }
  "whg-api" = {
    secret_name = "qs-prd-ec1-whg-api-secret-v1"
    secret_keys = {
      "ENCRYPTION_KEY"              = ""
      "INTEG_AUTH_TOKEN"            = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "stage-processor" = {
    secret_name = "qs-prd-ec1-stage-processor-secret-v1"
    secret_keys = {
      "SENTRY_DSN" = ""
      "ENV_MODE"   = ""
      "ETL_API_TOKEN" = ""
    }
  }
}

iam_policies = {
  "iam_001" = {
    name        = "AwsKms_v1"
    description = "AwsKms"
    statements = [{
      Action = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:kms:eu-central-1:597088029926:key/*"]
    }]
  }
  "iam_002" = {
    name        = "Amazon-EventBridge-Scheduler-Execution-Policy-v1"
    description = "Amazon-EventBridge-Scheduler-Execution-Policy"
    statements = [{
      Action = [
        "sqs:SendMessage"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:sqs:eu-central-1:597088029926:*"]
    }]
  }
  "iam_003" = {
    name        = "AmazonSSM-Policy-v1"
    description = "AmazonSSM-Policy-v1"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DescribeLogGroups",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "ssm:AddTagsToResource",
        "ssm:ExecuteAPI",
        "ssm:GetCalendar",
        "ssm:GetManifest",
        "ssm:ListTagsForResource",
        "ssm:PutCalendar",
        "ssm:PutConfigurePackageResult",
        "ssm:RemoveTagsFromResource",
        "ssm:StartAccessRequest",
        "ssm:StartExecutionPreview",
        "ssm:UpdateInstanceAssociationStatus"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      }
    ]
  }
}

role = {
  api = {
    name         = "qs-prd-ec1-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
    ]
  }
  app = {
    name         = "qs-prd-ec1-app-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  dbms = {
    name         = "qs-prd-ec1-dbms-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  ai-agent = {
    name         = "qs-prd-ec1-ai-agent-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  agent-runtime = {
    name         = "qs-prd-ec1-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonBedrockFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
    ]
  }
  scheduler = {
    name         = "qs-prd-ec1-scheduler-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonEventBridgeSchedulerFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  etl = {
    name         = "qs-prd-ec1-etl-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  integration = {
    name         = "qs-prd-ec1-integration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  lambda = {
    name         = "qs-prd-ec1-trigger-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::597088029926:policy/ecr-role-policy",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  eventbridge_scheduler = {
    name         = "qs-prd-ec1-scheduler-iam-role"
    type         = "Service"
    service_type = ["scheduler.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/Amazon-EventBridge-Scheduler-Execution-Policy-v1"
    ]
  }
  librarian-retrieval = {
    name         = "qs-prd-ec1-librarian-retrieval-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    ]
  }
  librarian-assets = {
    name         = "qs-prd-ec1-librarian-assets-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1"
    ]
  }
  whg-agent-runtime = {
    name         = "qs-prd-ec1-whg-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
    ]
  }
  whg-api = {
    name         = "qs-prd-ec1-whg-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
    ]
  }
  librarian-migration = {
    name         = "qs-prd-ec1-librarian-migration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1"
    ]
  }
  lambda02 = {
    name         = "qs-prd-ec1-queue-handler-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::597088029926:policy/AmazonSSM-Policy-v1"
    ]
  }
  
  ingestion-queue-orchestrator = {
    name         = "qs-prd-ec1-ingestion-queue-orchestrator-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-llm = {
    name         = "qs-prd-ec1-ingestion-worker-llm-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-generic = {
    name         = "qs-prd-ec1-ingestion-worker-generic-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-pgvector-loader = {
    name         = "qs-prd-ec1-ingestion-worker-pgvector-loader-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
}

#################################
######## REDIS ########
#################################

redis_subnet = {
  subnet_group_01 = {
    name        = "qs-prd-ec1-redis-sne-grp"
    subnet_name = ["qs-prd-ec1-private-sne-redis-01a-v1"]
  }
}

# Redis Parameter Group
redis_params = {
  "param001" = {
    redis_pg_name   = "qs-prd-ec1-redis-pubsub-pg-v1"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "AKE"
    }]
  }
  "param002" = {
    redis_pg_name   = "qs-prd-ec1-redis-cache-pg-v1"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "Ex"
    }]
  }
  "param003" = {
    redis_pg_name   = "qs-prd-ec1-whg-redis-cache-pg-v1"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "Ex"
    }]
  }
}

redis = {
  "redis01" = {
    name                 = "qs-prd-ec1-redis-cache-v1"
    sneGroupName         = "qs-prd-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-prd-ec1-main-vpc-v1"
    parameter_group_name = "qs-prd-ec1-redis-cache-pg-v1"
    environment          = "prd"
  }
  "redis02" = {
    name                 = "qs-prd-ec1-redis-pubsub-v1"
    sneGroupName         = "qs-prd-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-prd-ec1-main-vpc-v1"
    parameter_group_name = "qs-prd-ec1-redis-pubsub-pg-v1"
    environment          = "prd"
  }
  "redis03" = {
    name                 = "qs-prd-ec1-whg-redis-cache-v1"
    sneGroupName         = "qs-prd-ec1-redis-sne-grp"
    size                 = "cache.t2.medium"
    vpc_name             = "qs-prd-ec1-main-vpc-v1"
    parameter_group_name = "qs-prd-ec1-whg-redis-cache-pg-v1"
    environment          = "prd"
  }
}

s3 = {
  "s30001" = {
    bucket_name             = "qs-prd-ec1-logos-s3-v1"
    block_all_public_access = true
  }
  "s30002" = {
    bucket_name             = "qs-prd-ec1-customer0001-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0001"
    tags = {
      "TenantID" = "Customer0001"
    }
  }
  "s30003" = {
    bucket_name             = "qs-prd-ec1-customer0002-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0002"
    tags = {
      "TenantID" = "Customer0002"
    }
  }
  "s30004" = {
    bucket_name             = "qs-prd-ec1-customer0003-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0003"
    tags = {
      "TenantID" = "Customer0003"
    }
  }
  "s30005" = {
    bucket_name             = "qs-prd-ec1-customer0004-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0004"
    tags = {
      "TenantID" = "Customer0004"
    }
  }
  "s30006" = {
    bucket_name             = "qs-prd-ec1-gluescript-s3-v1"
    block_all_public_access = true
  }
  "s30007" = {
    bucket_name             = "qs-prd-ec1-glue-library-dependency-s3-v1"
    block_all_public_access = true
  }
  "s30008" = {
    bucket_name             = "qs-prd-ec1-chatwidget-s3-v1"
    block_all_public_access = true
  }
  "s3009" = {
    bucket_name             = "qs-prd-ec1-query-result-athena-s3-v1"
    block_all_public_access = true
  }
  "s30010" = {
    bucket_name             = "qs-prd-ec1-customer0005-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0005"
    tags = {
      "TenantID" = "Customer0005"
    }
  }
  "s30011" = {
    bucket_name             = "qs-prd-ec1-customer0006-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0006"
    tags = {
      "TenantID" = "Customer0006"
    }
  }
  "s30012" = {
    bucket_name             = "qs-prd-ec1-fission-deployment-s3-v1"
    block_all_public_access = true
  }
  "s30013" = {
    bucket_name             = "qs-prd-ec1-customer0010-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0010"
    tags = {
      "TenantID" = "Customer0010"
    }
  }
  "s30014" = {
    bucket_name             = "qs-prd-ec1-customer0015-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0015"
    tags = {
      "TenantID" = "Customer0015"
    }
  }
  "s30015" = {
    bucket_name             = "qs-prd-ec1-cost-report-s3-v1"
    block_all_public_access = true
  }
  "s30016" = {
    bucket_name             = "qs-prd-ec1-customer0014-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0014"
    tags = {
      "TenantID" = "Customer0014"
    }
  }
  "s30017" = {
    bucket_name             = "qs-prd-ec1-customer0013-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0013"
    tags = {
      "TenantID" = "Customer0013"
    }
  }
  "s30018" = {
    bucket_name             = "qs-prd-ec1-customer0008-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0008"
    tags = {
      "TenantID" = "Customer0008"
    }
  }
  "s30019" = {
    bucket_name             = "qs-prd-ec1-shared-s3-v1"
    block_all_public_access = true
  }
  "s30020" = {
    bucket_name             = "qs-prd-ec1-customer0022-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0022"
    tags = {
      "TenantID" = "Customer0022"
    }
  }
  "s30021" = {
    bucket_name             = "qs-prd-ec1-customer0007-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0007"
    tags = {
      "TenantID" = "Customer0007"
    }
  }
  "s30022" = {
    bucket_name             = "qs-prd-ec1-customer0025-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0025"
    tags = {
      "TenantID" = "Customer0025"
    }
  }
  "s30023" = {
    bucket_name             = "qs-prd-ec1-customer0016-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0016"
    tags = {
      "TenantID" = "Customer0016"
    }
  }
  "s30024" = {
    bucket_name             = "qs-prd-ec1-customer0020-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0020"
    tags = {
      "TenantID" = "Customer0020"
    }
  }
  "s30025" = {
    bucket_name             = "qs-prd-ec1-customer0026-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0026"
    tags = {
      "TenantID" = "Customer0026"
    }
  }
  "s30026" = {
    bucket_name             = "qs-prd-ec1-customer0018-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0018"
    tags = {
      "TenantID" = "Customer0018"
    }
  }
}

# This is for custom policy
buckets = ["qs-prd-ec1-logos-s3-v1"]

s3_bucket_policy = {
  "qs-prd-ec1-logos-s3-v1" = {
    bucket_id = "qs-prd-ec1-logos-s3-v1"
    bucket_policy = {
      "Version" : "2008-10-17",
      "Id" : "PolicyForCloudFrontPrivateContent",
      "Statement" : [
        {
          "Sid" : "AllowCloudFrontServicePrincipal",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "cloudfront.amazonaws.com"
          },
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::qs-prd-ec1-logos-s3-v1/*",
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : "arn:aws:cloudfront::597088029926:distribution/E18QS1P9NC9S6I"
            }
          }
        }
      ]
    }
  }
}

#################################
########  KMS NEW    ############
#################################

kms-new = {
  "customer0001" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0001-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0001",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0001"
    }
  }
  "customer0003" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0003-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0003",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0003"
    }
  }
  "customer0004" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0004-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0004",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0004"
    }
  }
  "customer0002" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0002-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0002",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0002"
    }
  }
  "common" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-common-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "common",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
  }
  "customer0005" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0005-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0005",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0005"
    }
  }
  "customer0006" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0006-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0006",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0006"
    }
  }
  "customer0010" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0010-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0010",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0010"
    }
  }
  "customer0015" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0015-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0015",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0015"
    }
  }
  "customer0014" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0014-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0014",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0014"
    }
  }
  "customer0013" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0013-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0013",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0013"
    }
  }
  "customer0008" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0008-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0008",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0008"
    }
  }
  "customer0022" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0022-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0022",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0022"
    }
  }
  "customer0007" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0007-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0007",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0007"
    }
  }
  "customer0025" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0025-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0025",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0025"
    }
  }
  "customer0016" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0016-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0016",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0016"
    }
  }
  "customer0020" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0020-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0020",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0020"
    }
  }
  "customer0026" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0026-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0026",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0026"
    }
  }
  "customer0018" = {
    environment = "prd"
    key_name    = "qs-prd-ec1-customer0018-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0018",
      "Statement" : [
        {
          "Sid" : "Allow access through RDS for all principals in the account that are authorized to use RDS",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:DescribeKey"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "kms:CallerAccount" : "597088029926",
              "kms:ViaService" : [
                "rds.eu-central-1.amazonaws.com",
                "s3.eu-central-1.amazonaws.com"
              ]
            }
          }
        },
        {
          "Sid" : "Allow direct access to key metadata to the account",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::597088029926:root",
              "arn:aws:iam::597088029926:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-PROD-ETL_0713b2186be3f666"
            ]
          },
          "Action" : [
            "kms:*"
          ],
          "Resource" : "*"
        }
      ]
    }
    tags = {
      "TenantID" = "Customer0018"
    }
  }
}

#################################
########     RDS     ############
#################################

# RDS Parameter Group
rds_pg_name   = "qs-prd-ec1-rds-pg-v1"
rds_pg_family = "postgres16"
rds_pg_parameters = [
  {
    name  = "rds.force_ssl"
    value = "0"
  }
]

rds-new = {
  rds01 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "common"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "common"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
  }
  rds02 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0001"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.10"
    kms_key_arn              = "customer0001"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0001"
    }
  }
  rds03 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0002"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.10"
    kms_key_arn              = "customer0002"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0002"
    }
  }
  rds04 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0003"
    engine_version           = "16.10"
    instance_type            = "db.t4g.large"
    kms_key_arn              = "customer0003"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0003"
    }
  }
  rds05 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0004"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0004"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0004"
    }
  }
  rds06 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0005"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0005"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0005"
    }
  }
  rds07 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0006"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0006"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0006"
    }
  }
  rds08 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0010"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0010"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0010"
    }
  }
  rds09 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0015"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0015"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0015"
    }
  }
  rds10 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0014"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0014"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0014"
    }
  }
  rds11 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0013"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0013"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0013"
    }
  }
  rds12 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0008"
    engine_version           = "16.10"
    instance_type            = "db.t4g.large"
    kms_key_arn              = "customer0008"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0008"
    }
  }
  rds13 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0022"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0022"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0022"
    }
  }
  rds14 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0007"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0007"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0007"
    }
  }
  rds15 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0025"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0025"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0025"
    }
  }
  rds16 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0016"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0016"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0016"
    }
  }
  rds17 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0020"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0020"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0020"
    }
  }
  rds18 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0026"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0026"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0026"
    }
  }
  rds19 = {
    vpc_name                 = "qs-prd-ec1-main-vpc-v1"
    subnet_group_name        = "qs-prd-ec1-db-sne-grp"
    instance_name            = "customer0018"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0018"
    environment              = "prd"
    parameter_group_name     = "qs-prd-ec1-rds-pg-v1"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0018"
    }
  }
}

sns_topics = {
  sns01 = {
    name = "qs-prd-ec1-sns-alert-v1"
  }
}
alarms = {
  "alarm0002" = {
    alarm_name                = "qs-prd-ec1-alarm-runner-cpu-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Maximum"
    threshold                 = 80
    alarm_description         = "Alarm for EC2 instance CPU utilization"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    ec2_key                   = "Bastion_Host"
    actions_enabled           = true
    dimensions = {
      InstanceId = "" // keep it empty and use ec2_key to get the instance Id, only applicable for namespace AWS/EC2
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-prd-ec1-alarm-bastion-status-v1"
    comparison_operator       = "GreaterThanThreshold"
    evaluation_periods        = 1
    metric_name               = "StatusCheckFailed"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Minimum"
    threshold                 = 0
    alarm_description         = "Alarm for EC2 instance Status check"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    ec2_key                   = "Bastion_Host"
    actions_enabled           = true
    dimensions = {
      InstanceId = "" // keep it empty and use ec2_key to get the instance Id, only applicable for namespace AWS/EC2
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-api-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "api"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-agent-runtime-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "agent-runtime"
    }
  }
  "alarm0007" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-app-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "app"
    }
  }
  "alarm0008" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-dbms-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "dbms"
    }
  }
  "alarm0009" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-etl-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "etl"
    }
  }
  "alarm0010" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-integration-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "integration"
    }
  }
  "alarm0011" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-scheduler-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "scheduler"
    }
  }
  "alarm0012" = {
    alarm_name                = "qs-prd-ec1-alarm-ecs-ai-agent-taskcount-v1"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 60
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-prd-ec1-main-ecs-v1"
      ServiceName = "ai-agent"
    }
  }
  "alarm0026" = {
    alarm_name                = "qs-prd-ec1-alarm-alb-main-502-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "HTTPCode_ELB_502_Count"
    namespace                 = "AWS/ApplicationELB"
    period                    = 60
    statistic                 = "Sum"
    threshold                 = 2
    alarm_description         = "Alarm for 502 errors in alb"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0027" = {
    alarm_name                = "qs-prd-ec1-alarm-alb-main-503-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "HTTPCode_ELB_503_Count"
    namespace                 = "AWS/ApplicationELB"
    period                    = 60
    statistic                 = "Sum"
    threshold                 = 2
    alarm_description         = "Alarm for 503 errors in alb"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
}
sns_topic_subscription = {
  snss01 = {
    sns_name = "qs-prd-ec1-sns-alert-v1"
    protocol = "email"
    endpoint = "octonomy.notification@talentship.io"
  }
}
rds_instance_id = "qs-prd-ec1-customer0001-rds-v1,qs-prd-ec1-customer0002-rds-v1,qs-prd-ec1-customer0003-rds-v1,qs-prd-ec1-customer0004-rds-v1,qs-prd-ec1-common-rds-v1,qs-prd-ec1-customer0005-rds-v1,qs-prd-ec1-customer0006-rds-v1,qs-prd-ec1-customer0010-rds-v1,qs-prd-ec1-customer0015-rds-v1,qs-prd-ec1-customer0014-rds-v1,qs-prd-ec1-customer0013-rds-v1,qs-prd-ec1-customer0008-rds-v1,qs-prd-ec1-customer0022-rds-v1,qs-prd-ec1-customer0007-rds-v1,qs-prd-ec1-customer0025-rds-v1,qs-prd-ec1-customer0016-rds-v1,qs-prd-ec1-customer0020-rds-v1,qs-prd-ec1-customer0026-rds-v1,qs-prd-ec1-customer0018-rds-v1"

## Cloudfront ###
cf_origin_0001 = "qs-prd-ec1-logos-s3-v1.s3.eu-central-1.amazonaws.com"

## Cloudfront_0002 ##
cf_origin_0002 = "qs-prd-ec1-main-alb-v1-573303132.eu-central-1.elb.amazonaws.com"
ordered_cache_behavior_0002 = [
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.js"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.jpg"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.jpeg"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.gif"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.css"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.png"
    response_headers_policy_id = null
  }
]

## Cloudfront_0003 ##

cf_origin_0003           = "qs-prd-ec1-wss-alb-v1-1202577746.eu-central-1.elb.amazonaws.com"
acm_certificate_arn_0003 = "arn:aws:acm:us-east-1:597088029926:certificate/b8593a7b-0dcf-4143-a776-18f77a56a2a9"
ordered_cache_behavior_0003 = [
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.js"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.jpg"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.jpeg"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.gif"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.css"
    response_headers_policy_id = null
  },
  {
    cache_policy_id            = "Managed-CachingOptimized"
    origin_request_policy_id   = "Managed-AllViewer"
    path_pattern               = "/*.png"
    response_headers_policy_id = null
  }
]

# Resource Groups
resource_groups = {
  "customer0001" = {
    resource_group_name = "qs-prd-ec1-rg-customer0001"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0001"]
        }
      ]
    }
    EOT
  }
  "customer0002" = {
    resource_group_name = "qs-prd-ec1-rg-customer0002"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["customer0002"]
        }
      ]
    }
    EOT
  }
  "customer0003" = {
    resource_group_name = "qs-prd-ec1-rg-customer0003"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["customer0003"]
        }
      ]
    }
    EOT
  }
  "customer0004" = {
    resource_group_name = "qs-prd-ec1-rg-customer0004"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["customer0004"]
        }
      ]
    }
    EOT
  }
  "customer0005" = {
    resource_group_name = "qs-prd-ec1-rg-customer0005"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["customer0005"]
        }
      ]
    }
    EOT
  }
  "customer0006" = {
    resource_group_name = "qs-prd-ec1-rg-customer0006"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0006"]
        }
      ]
    }
    EOT
  }
}
DBInstanceIdentifier = ["qs-prd-ec1-customer0001-rds-v1", "qs-prd-ec1-customer0002-rds-v1", "qs-prd-ec1-customer0003-rds-v1", "qs-prd-ec1-customer0004-rds-v1", "qs-prd-ec1-common-rds-v1"]
#################################
########   COGNITO  #############
#################################

tenants = {
  hepster = {
    user_pool_name               = "qs-prd-ec1-customer0005-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0005"
    callbackUrls                 = ["https://hepster.octonomy.ai/api/appconnect/auth/callback", "https://hepster.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://hepster.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      hepster = {
        idp_name    = "hepster"
        metadataUrl = "https://login.microsoftonline.com/81c9a15e-89c4-4e60-8457-018906375e75/federationmetadata/2007-06/federationmetadata.xml?appid=4049208a-ef3c-4de4-a501-ad52eef96d2a"
        idp_attributes = {
          email              = "emailaddress"
          given_name         = "givenname"
          name               = "name"
          family_name        = "surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0005"
    }
  }
  anwr = {
    user_pool_name               = "qs-prd-ec1-customer0006-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0006"
    callbackUrls                 = ["https://anwr.octonomy.ai/api/appconnect/auth/callback", "https://anwr.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://anwr.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      anwr = {
        idp_name    = "anwr"
        metadataUrl = "https://login.anwr-group.com/app/exkmk1c2hlD8ZL8Vc417/sso/saml/metadata"
        idp_attributes = {
          email              = "emailaddress"
          given_name         = "givenname"
          name               = "name"
          family_name        = "surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0006"
    }
  }
  havi = {
    user_pool_name               = "qs-prd-ec1-customer0010-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0010"
    callbackUrls                 = ["https://havi.octonomy.ai/api/appconnect/auth/callback", "https://havi.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://havi.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      havi = {
        idp_name    = "havi"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=bbf24def-fe15-4e84-9c54-32388d790265"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0010"
    }
  }
  prokon = {
    user_pool_name               = "qs-prd-ec1-customer0015-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0015"
    callbackUrls                 = ["https://prokon.octonomy.ai/api/appconnect/auth/callback", "https://prokon.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://prokon.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      prokon = {
        idp_name    = "prokon"
        metadataUrl = "https://login.microsoftonline.com/a027810b-2d71-4af2-8a4a-7673bfb05422/federationmetadata/2007-06/federationmetadata.xml?appid=92ad52cb-228a-4db1-a980-d7716dcf6b14"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0015"
    }
  }
  kartenmacherei = {
    user_pool_name               = "qs-prd-ec1-customer0014-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0014"
    callbackUrls                 = ["https://kartenmacherei.octonomy.ai/api/appconnect/auth/callback", "https://kartenmacherei.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://kartenmacherei.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      kartenmacherei = {
        idp_name    = "kartenmacherei"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=bbf24def-fe15-4e84-9c54-32388d790265"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0014"
    }
  }
  bora = {
    user_pool_name               = "qs-prd-ec1-customer0013-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0013"
    callbackUrls                 = ["https://bora.octonomy.ai/api/appconnect/auth/callback", "https://bora.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://bora.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      bora = {
        idp_name    = "bora"
        metadataUrl = "https://login.microsoftonline.com/ec187d5e-d331-4cda-a1dc-cf8219fce6b0/federationmetadata/2007-06/federationmetadata.xml?appid=036f640a-6648-497a-a604-d466b9997440"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0013"
    }
  }
  berner = {
    user_pool_name               = "qs-prd-ec1-customer0008-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0008"
    callbackUrls                 = ["https://berner.octonomy.ai/api/appconnect/auth/callback", "https://berner.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://berner.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      berner = {
        idp_name    = "berner"
        metadataUrl = "https://login.microsoftonline.com/b1d0ad62-5a50-48d5-8f4f-bd7fcf84ef3a/federationmetadata/2007-06/federationmetadata.xml?appid=cae8539c-5009-4c2f-9fa7-edd02fccea16"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0008"
    }
  }
  emons = {
    user_pool_name               = "qs-prd-ec1-customer0022-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0022"
    callbackUrls                 = ["https://emons.octonomy.ai/api/appconnect/auth/callback", "https://emons.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://emons.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      emons = {
        idp_name    = "emons"
        metadataUrl = "https://login.microsoftonline.com/67ad4a61-32e2-49c4-bd95-75526f04a726/federationmetadata/2007-06/federationmetadata.xml?appid=d78d7fce-2bfc-40c3-90ad-3566c85434db"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0022"
    }
  }
  pfalzkom = {
    user_pool_name               = "qs-prd-ec1-customer0007-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0007"
    callbackUrls                 = ["https://pfalzkom.octonomy.ai/api/appconnect/auth/callback", "https://pfalzkom.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://pfalzkom.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      pfalzkom = {
        idp_name    = "pfalzkom"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=bbf24def-fe15-4e84-9c54-32388d790265"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0007"
    }
  }
  octogrow = {
    user_pool_name               = "qs-prd-ec1-customer0025-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0025"
    callbackUrls                 = ["https://octogrow.octonomy.ai/api/appconnect/auth/callback", "https://octogrow.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://octogrow.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      octogrow = {
        idp_name    = "octogrow"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=bbf24def-fe15-4e84-9c54-32388d790265"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0025"
    }
  }
  toptica = {
    user_pool_name               = "qs-prd-ec1-customer0016-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0016"
    callbackUrls                 = ["https://toptica.octonomy.ai/api/appconnect/auth/callback", "https://toptica.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://toptica.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      toptica = {
        idp_name    = "toptica"
        metadataUrl = "https://login.microsoftonline.com/ea364ec4-cc1c-44f8-b405-5a04bd123da7/federationmetadata/2007-06/federationmetadata.xml?appid=c90b1c5d-235b-47c5-9de5-192367aa005c"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0016"
    }
  }
  aluca = {
    user_pool_name               = "qs-prd-ec1-customer0020-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0020"
    callbackUrls                 = ["https://aluca.octonomy.ai/api/appconnect/auth/callback", "https://aluca.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://aluca.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      aluca = {
        idp_name    = "aluca"
        metadataUrl = "https://login.microsoftonline.com/0ff7f29b-272e-4969-970a-9e9947b8b3e9/federationmetadata/2007-06/federationmetadata.xml?appid=98d778c5-5574-40e2-a507-357b5429708a"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0020"
    }
  }
  tre = {
    user_pool_name               = "qs-prd-ec1-customer0026-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0026"
    callbackUrls                 = ["https://tre.octonomy.ai/api/appconnect/auth/callback", "https://tre.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://tre.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      tre = {
        idp_name    = "tre"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=bbf24def-fe15-4e84-9c54-32388d790265"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0026"
    }
  }
  aekwl = {
    user_pool_name               = "qs-prd-ec1-customer0018-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0018"
    callbackUrls                 = ["https://aekwl.octonomy.ai/api/appconnect/auth/callback", "https://aekwl.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://aekwl.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      aekwl = {
        idp_name    = "aekwl"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=bbf24def-fe15-4e84-9c54-32388d790265"
        idp_attributes = {
          email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
          given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
          name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
          family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
          "custom:object_id" = "objectid"
        }
      }
    }
    user_pool_schemas = [
      {
        attribute_data_type = "String"
        name                = "object_id"
        required            = false
        mutable             = true
        string_attribute_constraints = {
          min_length = 0
          max_length = 2048
        }
      }
    ]
    tags = {
      "TenantID" = "Customer0018"
    }
  }
}

#################################
########      WAF    ############
#################################

addresses = [
  "14.97.127.46/32"
]

waf_acls = {
  cloudfront_main = {
    name            = "qs-prd-ec1-waf-cf-v1"
    scope           = "CLOUDFRONT"
    description     = "qs-prd-ec1-waf-cf-v1"
    waf_metric_name = "qs-prd-ec1-waf-cf-v1"
    log_group_name  = "aws-waf-logs-qs-v1"
    waf_rules = [
      {
        name                  = "qs-prd-ec1-rate-limiting-v1"
        priority              = 0
        statement_type        = "rate_based"
        rate_limit            = 1000
        evaluation_window_sec = 300
        aggregate_key_type    = "IP" # Fixed typo from 'aggregate_key_type'
        action                = "count"
        metric_name           = "qs-prd-ec1-rate-limiting-v1"
      },
      {
        name            = "F5-OWASP_Managed"
        priority        = 1
        statement_type  = "managed"
        vendor_name     = "F5"
        rule_group_name = "OWASP_Managed"
        rule_action_overrides = [ # Fixed to match module expectation
          "rule_SSRF_attempt_AllQueryArguments_Body",
          "rule_chmod_execution_attempt__Parameter__AllQueryArguments_Body",
          "rule_XSS_script_tag__Parameter__AllQueryArguments_Body",
          "rule_SQL_INJ_end_quote_UNION__Parameter__AllQueryArguments_Body",
          "rule_SQL_INJ_alter_column_AllQueryArguments_Body",
          "rule_SQLINJ___NoSQL_db_find____Parameter__AllQueryArguments_Body",
          "rule_document_cookie__Parameter__AllQueryArguments_Body",
          "rule_SQL_INJ_DROP_SCHEMA__Parameter__AllQueryArguments_Body",
          "rule_XML_External_Entity__XXE__injection_attempt__Content__AllQueryArguments_Body",
          "rule_Java_code_injection_java_lang_ClassLoader__Parameter__AllQueryArguments_Body",
          "rule_PHP_short_object_serialization_injection_attempt__Parameter__AllQueryArguments_Body",
          "rule_SQL_INJ_expressions_like__or_1_1__AllQueryArguments_Body",
          "rule_SQL_INJ_SELECT_DATABASE____Parameter__AllQueryArguments_Body",
          "rule_src_http___Parameter__AllQueryArguments_Body",
          "rule_SQL_INJ_UNION_SELECT_1_1__Parameter__AllQueryArguments_Body",
          "rule_valueOf__Parameter__AllQueryArguments_Body",
          "rule_div_tag__behavior__Parameter__AllQueryArguments_Body",
          "rule_Java_code_injection___org_apache_commons_collections_AllQueryArguments_Body"
        ]
        override_action = "none" # Changed from 'action' to 'override_action'
        metric_name     = "F5-OWASP_Managed"
      },
      {
        name                     = "qs-prd-ec1-url-block-waf-rule"
        priority                 = 2
        statement_type           = "custom"
        statement_nested_type    = "and"
        byte_match_search_string = "/api/appconnect/docs"
        text_transformation_type = "NONE"
        country_codes            = ["IN"]
        action                   = "block"
        response_code            = 403
        custom_response_body_key = "403-response-page"
        metric_name              = "qs-prd-ec1-url-block-waf-rule"
        statement = {
          and_statement = {
            statements = [
              {
                byte_match_statement = {
                  search_string         = "/api/appconnect/docs"
                  positional_constraint = "CONTAINS"
                  text_transformations = [
                    {
                      priority = 0
                      type     = "NONE"
                    }
                  ]
                }
              },
              {
                not_statement = {
                }
              }
            ]
          }
        }

      },
      {
        name           = "qs-prd-ec1-country-restrictions-allow-waf-rule"
        priority       = 3
        statement_type = "geo"
        country_codes = [
          "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
          "VA", "HU", "IS", "IN", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT", "MD", "MC", "ME", "NL",
          "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "UA", "GB", "US"
        ]
        action      = "allow"
        metric_name = "qs-prd-ec1-country-restrictions-allow-waf-rule"
      },
      {
        name           = "qs-prd-ec1-country-restrictions-block-waf-rule"
        priority       = 4
        statement_type = "geo"
        country_codes = [
          "AF", "DZ", "AS", "AD", "AO", "AI", "AQ", "AG", "AR", "AM", "AW", "AU", "AZ", "BS", "BH", "BD",
          "BB", "BY", "BZ", "BJ", "BM", "BT", "BO", "BQ", "BA", "BW", "BV", "BR", "IO", "BN", "KH", "CM",
          "CA", "CV", "KY", "CF", "TD", "CL", "CN", "CX", "CC", "CO", "KM", "CG", "CD", "CK", "CR", "CI",
          "CU", "CW"
        ]
        action                   = "block"
        response_code            = 403
        custom_response_body_key = "403-response-page"
        metric_name              = "qs-prd-ec1-country-restrictions-block-waf-rule"
      },
      {
        name           = "qs-prd-ec1-country-restrictions-block-waf-rule-2"
        priority       = 5
        statement_type = "geo"
        country_codes = [
          "DJ", "DM", "DO", "EC", "EG", "SV", "GQ", "ER", "ET", "FK", "FO", "FJ", "GA", "GM", "GH", "GI",
          "GP", "GU", "GT", "GG", "GN", "GW", "GY", "HT", "HM", "VA", "HN", "HK", "IS", "ID", "IR", "IQ",
          "JP", "JE", "JO", "KZ", "KE", "KI", "KP", "KR", "KW", "GL", "GD", "IL", "JM", "LB", "LR", "RU",
          "KG", "LA"
        ]
        action                   = "block"
        response_code            = 403
        custom_response_body_key = "403-response-page"
        metric_name              = "qs-prd-ec1-country-restrictions-block-waf-rule-2"
      }
    ]
  }
}
alarm_period                    = 60
lb_5xx_errors_period            = 60
sqs_old_message_period          = 60
sqs_messages_not_visible_period = 60
ecs_mem_utilization_period      = 60
ecs_desired_task_count_period   = 60
redis_cpu_alarm_period          = 60
schedulers_period               = 60

cloudwatch_log_group = {
  cloudwatch0001 = {
    log_group_name    = "qs-prd-ec1-observability-agent-runtime"
    retention_in_days = 90
  }
  cloudwatch0002 = {
    log_group_name    = "qs-prd-ec1-observability-api"
    retention_in_days = 90
  }
}

private_buckets = ["qs-prd-ec1-customer0001-s3-v1", "qs-prd-ec1-customer0002-s3-v1", "qs-prd-ec1-customer0003-s3-v1", "qs-prd-ec1-customer0004-s3-v1", "qs-prd-ec1-customer0005-s3-v1", "qs-prd-ec1-customer0006-s3-v1", "qs-prd-ec1-customer0010-s3-v1", "qs-prd-ec1-customer0015-s3-v1", "qs-prd-ec1-customer0007-s3-v1", "qs-prd-ec1-customer0008-s3-v1", "qs-prd-ec1-customer0013-s3-v1", "qs-prd-ec1-customer0014-s3-v1", "qs-prd-ec1-customer0022-s3-v1", "qs-prd-ec1-customer0025-s3-v1", "qs-prd-ec1-customer0016-s3-v1", "qs-prd-ec1-customer0020-s3-v1", "qs-prd-ec1-customer0026-s3-v1", "qs-prd-ec1-customer0018-s3-v1"]

public_alb_subnet_ids = ["subnet-0638f5f9098c40286", "subnet-05d565c67ef08308c", "subnet-01a0cc5a47dd2e886"]

private_alb_subnet_ids = ["subnet-045de43d03fd12b59", "subnet-08321790eb3ea1631", "subnet-0bd494e534e6bd68e"]

ecs_subnet_id = ["subnet-04e30d7d29044da2c"]

task_definitions = {
  "agent-runtime" = {
    task_definition_name   = "agent-runtime"
    container_name         = "agent-runtime"
    ecr_repository_name    = "agent-runtime"
    cpu                    = 2048
    memory                 = 4096
    container_port         = 3006
    host_port              = 3006
    service_log_group_name = "agent-runtime"
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "AWS_SQS_BASE_URL", "DATABASE_URL", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "OPENAI_API_KEY", "PROMPT_PROCESS_CLUSTER_QUEUE", "PROMPT_PROCESS_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "REDIS_HOST", "REDIS_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "VOYAGE_BASE_URL"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "AWS_CDN_URL", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "AWS_S3_BUCKET_NAME", "AWS_SQS_BASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DEEPGRAM_API_KEY", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "NEO4J_URL_CUSTOMER", "NODE_ENV", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID", "VAPI_API_ENDPOINT", "WEBHOOK_WORKER_SQS_QUEUE_URL", "CR_DATA_LOAD_QUEUE_URL"]
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
    secret_keys            = ["NEXT_PUBLIC_DOMAIN", "NEXT_PUBLIC_SOCKET_DOMAIN"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_PREFIXES", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "AWS_REGION", "AWS_S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DATABASE_URL_ETL", "DBMS_AUTH_TOKEN", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "NEO4J_URL_CUSTOMER", "NODE_ENV", "PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL_ETL", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_PREFIXES", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_PREFIXES", "ANTHROPIC_API_BASE_URL", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "ATLASSIAN_BASE_URL", "AWS_REGION", "AWS_S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "CONFLUENCE_AUTH_TOKEN", "CONFLUENCE_BASE_URL", "CONFLUENCE_CONNECTION_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "DHL_API_BASE_URL", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "GOKARLA_BASE_URL", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "NEO4J_DB_PASSWORD", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_URL_CUSTOMER", "NODE_ENV", "OPENAI_API_BASE_URL", "PG_DB_HOST", "PG_DB_NAME", "PG_DB_PASSWORD", "PG_DB_PORT", "PG_DB_USERNAME", "PORT", "S3_BUCKET_NAME", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID", "VAPI_API_ENDPOINT"]
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
    secret_keys            = ["AUTH_STRATEGY", "COMMON_DATABASE_URL", "CONFIGURATION_SCHEMA_BUCKET", "CONFIGURATION_SCHEMA_DEFAULT_VERSION", "CONFIGURATION_SCHEMA_PATH", "CUSTOM_ACCESS_TOKEN_SECRET_KEY", "DATABASE_URL", "ENCRYPTION_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "SERVICE_NAME", "VECTOR_DB_TYPE", "VOYAGEAI_API_URL", "VOYAGE_API_KEY"]
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
    secret_keys            = ["API_VERSION", "ASSETS_API_PATH", "COMMON_DATABASE_URL", "DATABASE_URL", "ENV", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "VOYAGEAI_API_URL", "VOYAGE_API_KEY"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_PREFIXES", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "AWS_REGION", "CLUSTER_MANAGER_ETL_ENABLED", "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL", "COGNITO_USER_SYNC_SQS_QUEUE_URL", "COGNITO_WORKER_SQS_QUEUE_URL", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DEFAULT_SCHEDULER_ROLE_ARN", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "EVALUATION_SQS_QUEUE_URL", "FISSION_STATUS_QUEUE_URL", "FULL_LOAD_SQS_QUEUE_URL", "INCREMENTAL_LOAD_SQS_QUEUE_URL", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "NEO4J_URL_CUSTOMER", "NODE_ENV", "SCH_AUTH_TOKEN", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "WEBHOOK_WORKER_SQS_QUEUE_URL", "CR_DATA_LOAD_QUEUE_URL"]
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
    desired_count          = 0
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "AWS_CDN_URL", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "AWS_S3_BUCKET_NAME", "AWS_SQS_BASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DEEPGRAM_API_KEY", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "NEO4J_URL_CUSTOMER", "NODE_ENV", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID", "VAPI_API_ENDPOINT", "WEBHOOK_WORKER_SQS_QUEUE_URL"]
    autoscaling            = true
    desired_count          = 0
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "AWS_SQS_BASE_URL", "DATABASE_URL", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "OPENAI_API_KEY", "PROMPT_PROCESS_CLUSTER_QUEUE", "PROMPT_PROCESS_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "REDIS_HOST", "REDIS_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "VOYAGE_BASE_URL"]
    autoscaling            = true
  }
}

target_groups = {
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
    path = "/librarian/openapi.json"
  }
  "scheduler" = {
    path = "/scheduler/api/v1/health-check"
  }
  "librarian-migration" = {}
  "whg-api" = {
    path = "/api/appconnect/health-check"
  }
}
ecs_cpu_utilization_period = 60

# PowerBI

ec2_subnet_id = "subnet-0114061506b685099"
