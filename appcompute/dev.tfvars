key = "dev/terraform.tfstate"

app_version = "v2"

#################################
########     ROLE     ###########
#################################

role_arn = "arn:aws:iam::905418116080:role/terraform-role"

#################################
########     TAG     ############
#################################

tags = {
  "Project"     = "qs"
  "Environment" = "dev"
  "Terraformed" = true
  "Owner"       = "Octonomy.devops@talentship.io"
  "Version"     = "V2"
}


#################################
########     VPC     ############
#################################
vpc_name = "qs-dev-ec1-main-vpc-v2"

cidr_block = "10.0.0.0/16"

public_subnets = [
  { cidr = "10.0.0.0/28", az = "eu-central-1a", Name = "qs-dev-ec1-public-sne-nat-01a-v2", key = "subnet1" },      #NAT
  { cidr = "10.0.0.32/27", az = "eu-central-1a", Name = "qs-dev-ec1-public-sne-alb-01a-v2", key = "subnet2" },     #ALB
  { cidr = "10.0.0.64/27", az = "eu-central-1b", Name = "qs-dev-ec1-public-sne-alb-02b-v2", key = "subnet3" },     #ALB
  { cidr = "10.0.0.96/27", az = "eu-central-1c", Name = "qs-dev-ec1-public-sne-alb-03c-v2", key = "subnet4" },     #ALB
  { cidr = "10.0.0.128/27", az = "eu-central-1a", Name = "qs-dev-ec1-public-sne-nlb-01a-v2", key = "subnet5" },    #NLB
  { cidr = "10.0.0.160/27", az = "eu-central-1b", Name = "qs-dev-ec1-public-sne-nlb-02b-v2", key = "subnet6" },    #NLB
  { cidr = "10.0.0.192/27", az = "eu-central-1c", Name = "qs-dev-ec1-public-sne-nlb-03c-v2", key = "subnet7" },    #NLB
  { cidr = "10.0.0.224/28", az = "eu-central-1a", Name = "qs-dev-ec1-public-sne-bastion-01a-v2", key = "subnet8" } #Bastion Host
]

# Indicates index of the public subnet
nat_subnet_index = 0

# NAT Name
nat_name = "qs-dev-ec1-nat-v2"

# Private Subnets
private_subnets = [
  { cidr = "10.0.1.0/24", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-ecs-01a-v2", key = "subnet1" },     #ECS
  { cidr = "10.0.2.0/24", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-rds-01a-v2", key = "subnet2" },     #RDS
  { cidr = "10.0.3.0/27", az = "eu-central-1b", Name = "qs-dev-ec1-private-sne-rds-02b-v2", key = "subnet3" },     #RDS
  { cidr = "10.0.4.0/24", az = "eu-central-1c", Name = "qs-dev-ec1-private-sne-rds-03c-v2", key = "subnet4" },     #RDS
  { cidr = "10.0.5.0/27", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-lambda-01a-v2", key = "subnet5" },  #Lambda
  { cidr = "10.0.6.0/24", az = "eu-central-1b", Name = "qs-dev-ec1-private-sne-neo4j-01b-v2", key = "subnet6" },   #Neo4j
  { cidr = "10.0.7.0/27", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-ilb-01a-v2", key = "subnet7" },     #ILB
  { cidr = "10.0.7.32/27", az = "eu-central-1b", Name = "qs-dev-ec1-private-sne-ilb-02b-v2", key = "subnet8" },    #ILB
  { cidr = "10.0.7.64/27", az = "eu-central-1c", Name = "qs-dev-ec1-private-sne-ilb-03c-v2", key = "subnet9" },    #ILB
  { cidr = "10.0.7.96/28", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-redis-01a-v2", key = "subnet10" }, #Redis
  { cidr = "10.0.7.112/28", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-glue-01a-v2", key = "subnet11" }, #Glue
  { cidr = "10.0.8.0/28", az = "eu-central-1a", Name = "qs-dev-ec1-private-sne-dms-01a-v2", key = "subnet15" },    #DMS
  { cidr = "10.0.8.16/28", az = "eu-central-1b", Name = "qs-dev-ec1-private-sne-dms-01b-v2", key = "subnet16" }    #DMS
]
vpc_tags = {
  "Name"        = "qs-dev-ec1-main-vpc-v2"
  "Project"     = "qs"
  "Environment" = "dev"
  "Terraformed" = true
  "Owner"       = "Octonomy.devops@talentship.io"
  "Version"     = "V2"
}

#################################
########     EC2     ############
#################################

# Define the environment (e.g., "production", "dev", "test")
environment = "dev"

# Define EC2 instances
instances = {
  Bastion_Host = {
    ami               = "ami-0e04bcbe83a83792e"
    ssh_pub_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDX6OzNSX/h2gjAaVybaCA6WjzFn6UIjC9S8GesDl9TcnzG55XZ3Ct0xHodPoVY/spbbuX3rSAt2lQm5NB2tvsS1mzTHBrN14QOE0gogf7KTuMfBRGrm1Q3oYrt79mEaAKY2gjLdHQsnWFeIbepuw24iCIDb3B4PeFLzUIxZESjus0Y2wGVNKW5ORDDr/pcDWP05ZdvVAt10/1VmXOjlfMKBRAEW4uKXFOAg1HF2d0n5INlHSnK7rK/xpL7ht91Osb51NffqPVp0kzJT2NrHOp1iy3kyUTeOo7O4A14xYbwqhrKHxjNGXmnkMzafNkrdEOe4ZyJ+MQPoaclBlDxd5tFBDjH8Y4FYjly+5i2gaRnj09l8PeKnXKdXZTsM9Xf0Udx7hFaOySQXsMGpDOrfg4RrfFGuFPTjzN6+OwZwJNnMpU5Po4Kajx4adRPHUgZsy24lAJFJ8syWOE3woNlgcruoAzOQ9XwKU1muAzg2pDLI4epxJHKPRjoNfhkGfbQUuOnEIdt1vfwSmAeW+8vzsipweGCoVxit3IIQASi9pcFy6F5raDeDUlHKoPeKryhNJstDw2zcOAScLDBtCxfzKW8y1X/Vy2xZvdq2KgceuOM1cmPVuOcwAaRXo6PiSyk9TIwFcnPbPjQIWE5+X0VBjvJ9Si2UJKS7FbDsPfyTyZGfQ=="
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
    vpc_name          = "qs-dev-ec1-main-vpc-v2"
    eip               = true
    ebs               = false
    secret            = false
    ingress = {
      sshoffice = {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["14.194.184.67/32"] # Example of a specific IP range
        security_groups = []
        description     = "office ssh"
      }
      sshtemp = {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["3.120.181.40/29"] # Example of a specific IP range
        security_groups = []
        description     = "EC2 instance connect"
      }
    }
  }
}

#################################
### APPLICATION LOAD BALANCER ###
#################################

ecs_cluster_name          = "qs-dev-ec1-main-ecs-v2"
enable_container_insights = true

alb_security_group     = "qs-dev-ec1-alb-nsg"
ilb_security_group     = "qs-dev-ec1-ilb-nsg"
wss_alb_security_group = "dev-qs-nsg-wss-alb-01"

lb = {
  "alb" = {
    lb_enable_deletion_protection = false
    lb_name                       = "qs-dev-ec1-main-alb-v2"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-dev-ec1-main-vpc-v2"
    lb_subnets_name               = ["qs-dev-ec1-public-sne-alb-01a-v2", "qs-dev-ec1-public-sne-alb-02b-v2", "qs-dev-ec1-public-sne-alb-03c-v2"]
    security_group_name           = "qs-dev-ec1-alb-nsg"
    lb_idle_timeout               = 60
    lb_client_keep_alive          = 3600
    is_internal_lb                = false
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-dev-ec1-main-alb-logs"

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
        certificate_domain = "*.dev.octonomy.ai"
        hosted_zone        = "dev.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          Api = {
            tags         = { "Name" = "API" }
            priority     = 20
            action_type  = "forward"
            host_header  = ["*.dev.octonomy.ai", "*.dev.assets.octonomy.ai"]
            path_pattern = ["/api/appconnect/*"]
            forward = {
              target_group_name = "qs-dev-api-alb"
            }
          }
          App = {
            tags        = { "Name" = "APP" }
            priority    = 21
            action_type = "forward"
            host_header = ["*.dev.octonomy.ai"]
            forward = {
              target_group_name = "qs-dev-app-alb"
            }
          }
          AI-Agent = {
            tags        = { "Name" = "AI-Agent" }
            priority    = 10
            action_type = "forward"
            host_header = ["ai-agent.dev.octonomy.ai"]
            forward = {
              target_group_name = "qs-dev-ai-agent-alb"
            }
          }
          librarian-assets = {
            tags         = { "Name" = "Librarian-assets" }
            priority     = 11
            action_type  = "forward"
            host_header  = ["*.dev.octonomy.ai"]
            path_pattern = ["/assets/*"]
            forward = {
              target_group_name = "qs-dev-librarian-assets-alb"
            }
          }
        }
      }
    }
    target_groups = {
      ai-agent = {
        name                 = "qs-dev-ai-agent-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-api-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-app-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-librarian-assets-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
        health_check = {
          path                = "/"
          interval            = 50
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
    lb_name                       = "qs-dev-ec1-main-ilb-v2"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-dev-ec1-main-vpc-v2"
    lb_subnets_name               = ["qs-dev-ec1-private-sne-ilb-01a-v2", "qs-dev-ec1-private-sne-ilb-02b-v2", "qs-dev-ec1-private-sne-ilb-03c-v2"]
    security_group_name           = "qs-dev-ec1-ilb-nsg"
    is_internal_lb                = true
    lb_idle_timeout               = 300
    lb_client_keep_alive          = 3600
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-dev-ec1-main-ilb-alb-logs"
    listeners = {
      internallistener80 = {
        port           = 80
        protocol       = "HTTP"
        default_action = "forward"
        forward = {
          target_group_name = "qs-dev-scheduler-ilb"
        }
      }
      internallistener443 = {
        port               = 443
        protocol           = "HTTPS"
        ssl_policy         = "ELBSecurityPolicy-2016-08"
        certificate_domain = "*.internal.dev.octonomy.ai"
        hosted_zone        = "dev.octonomy.ai"
        is_private_zone    = false
        default_action     = "forward"
        forward = {
          target_group_name = "qs-dev-scheduler-ilb"
        }
        rules = {
          internal-scheduler = {
            tags         = { "Name" = "scheduler" }
            priority     = 2
            action_type  = "forward"
            path_pattern = ["/scheduler/*"]
            forward = {
              target_group_name = "qs-dev-scheduler-ilb"
            }
          }
          internal-dbms = {
            tags         = { "Name" = "dbms" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/dbms/*"]
            forward = {
              target_group_name = "qs-dev-dbms-ilb"
            }
          }
          internal-etl = {
            tags         = { "Name" = "etl" }
            priority     = 3
            action_type  = "forward"
            path_pattern = ["/etl/*"]
            forward = {
              target_group_name = "qs-dev-etl-ilb"
            }
          }
          internal-integration = {
            tags         = { "Name" = "integration" }
            priority     = 4
            action_type  = "forward"
            path_pattern = ["/integration/*"]
            forward = {
              target_group_name = "qs-dev-integration-ilb"
            }
          }
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 5
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*"]
            forward = {
              target_group_name = "qs-dev-agent-runtime-ilb"
            }
          }
          librarian-retrieval = {
            tags         = { "Name" = "Librarian-Retrieval" }
            priority     = 6
            action_type  = "forward"
            path_pattern = ["/librarian/*"]
            forward = {
              target_group_name = "qs-dev-librarian-retrieval-ilb"
            }
          }
        }
      }
    }
    target_groups = {
      internal-dbms = {
        name                 = "qs-dev-dbms-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-scheduler-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-etl-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-integration-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-agent-runtime-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
        name                 = "qs-dev-librarian-retrieval-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
        health_check = {
          path                = "/"
          interval            = 50
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
    lb_name                       = "qs-dev-ec1-wss-alb-v2"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-dev-ec1-main-vpc-v2"
    lb_subnets_name               = ["qs-dev-ec1-public-sne-alb-01a-v2", "qs-dev-ec1-public-sne-alb-02b-v2", "qs-dev-ec1-public-sne-alb-03c-v2"]
    security_group_name           = "dev-qs-nsg-wss-alb-01"
    is_internal_lb                = false
    lb_idle_timeout               = 1800
    lb_client_keep_alive          = 1800
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-dev-ec1-wss-alb-logs"
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
        certificate_domain = "*.dev.wss.octonomy.ai"
        hosted_zone        = "dev.wss.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*", "/socket.io/*"]
            host_header  = ["*.dev.wss.octonomy.ai"]
            forward = {
              target_group_name = "dev-qs-tg-alb-agent-runtime-v2"
            }
          }
          # x-agent-runtime = {
          #   tags        = { "Name" = "2-agent-runtime" }
          #   priority    = 2
          #   action_type = "forward"
          #   path_pattern = ["/agent-runtime/*", "/socket.io/*"]
          #   host_header = ["*.dev.wss.octonomy.ai"]
          #   http_header = ["widget"]
          #   forward = {
          #     target_group_name = "dev-qs-tg-alb-agent-runtime-2-v2"
          #   }
          # }
        }
      }
    }
    target_groups = {
      agent-runtime = {
        name                 = "dev-qs-tg-alb-agent-runtime-v2"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-dev-ec1-main-vpc-v2"
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
      # x-agent-runtime = {
      #   name                 = "dev-qs-tg-alb-agent-runtime-2-v2"
      #   target_type          = "ip"
      #   protocol             = "HTTP"
      #   port                 = 80
      #   deregistration_delay = 5
      #   vpc_name             = "qs-dev-ec1-main-vpc-v2"
      #   health_check = {
      #     path                = "/"
      #     interval            = 50
      #     timeout             = 30
      #     healthy_threshold   = 2
      #     unhealthy_threshold = 3
      #     matcher             = "200-499"
      #     port                = 3006
      #   }
      # }
    }
  }
}

#################################
########     ECS     ############
#################################

ecs = {
  api = {
    ecs_name               = "api"
    family                 = "qs-dev-ec1-api-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-api-alb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-api-ecs"
    ingress_port           = 3001
    secret_manager_name    = "qs-dev-api"
    secrets                = ["DATABASE_URL"]
    execution_role_name    = "qs-dev-ec1-api-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-api-ecs-iam-role"
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "VAPI_API_KEY", "VAPI_API_ENDPOINT", "VAPI_CUSTOMER_KEY", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT"]
    secret_manager_arn     = "qs-dev-ec1-api-secret-v2"
    logs_stream_prefix     = "qs-dev-ec1-api-ecs"
    container_name         = "qs-dev-ec1-api-ecs"
    container_port         = 3001
    host_port              = 3001
    cpu                    = 256
    memory                 = 512
    security_group_names   = ["qs-dev-ec1-alb-nsg"]
  }
  app = {
    ecs_name               = "app"
    family                 = "qs-dev-ec1-app-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-app-alb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = false
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-app-ecs"
    execution_role_name    = "qs-dev-ec1-app-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-app-ecs-iam-role"
    ingress_port           = 3000
    secrets                = ["NEXT_PUBLIC_DOMAIN", "NEXT_PUBLIC_SOCKET_DOMAIN", "NEXT_PUBLIC_ASSETS_BASE_URL"]
    secret_manager_arn     = "qs-dev-ec1-app-secret-v2"
    container_name         = "qs-dev-ec1-app-ecs"
    container_port         = 3000
    host_port              = 3000
    cpu                    = 256
    memory                 = 512
    security_group_names   = ["qs-dev-ec1-alb-nsg"]
  }
  dbms = {
    ecs_name               = "dbms"
    family                 = "qs-dev-ec1-dbms-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-dbms-ilb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-dev-ec1-dbms-ecs"
    ingress_port           = 3002
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "ALLOWED_PREFIXES", "DBMS_AUTH_TOKEN", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL_ETL", "SHADOW_DATABASE_URL_ETL", "AGENT_RUNTIME_SERVICE_URL", "INTEGRATION_SERVICE_URL", "SCH_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "AI_AGENT_AUTH_TOKEN"]
    secret_manager_arn     = "qs-dev-ec1-dbms-secret-v2"
    container_name         = "qs-dev-ec1-dbms-ecs"
    secret_manager_name    = "qs-dev-dbms"
    # secrets             = ["PORT"]
    container_port       = 3002
    host_port            = 3002
    cpu                  = 2048
    memory               = 4096
    execution_role_name  = "qs-dev-ec1-dbms-ecs-iam-role"
    task_role_name       = "qs-dev-ec1-dbms-ecs-iam-role"
    security_group_names = ["qs-dev-ec1-ilb-nsg"]
  }
  ai-agent = {
    ecs_name               = "ai-agent"
    family                 = "qs-dev-ec1-ai-agent-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-ai-agent-alb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 512
    memory_task_definition = 1024
    log_group_name         = "qs-dev-ec1-ai-agent-ecs"
    ingress_port           = 80
    secrets                = ["RETRIVAL_AUTH_TOKEN", "VOYAGE_API_KEY", "VOYAGE_RERANK_MODEL"]
    secret_manager_arn     = "qs-dev-ec1-ai-agent-secret-v2"
    container_name         = "qs-dev-ec1-ai-agent-ecs"
    container_port         = 80
    host_port              = 80
    cpu                    = 512
    memory                 = 1024
    execution_role_name    = "qs-dev-ec1-ai-agent-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-ai-agent-ecs-iam-role"
    security_group_names   = ["qs-dev-ec1-alb-nsg"]
  }
  scheduler = {
    ecs_name               = "scheduler"
    family                 = "qs-dev-ec1-scheduler-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-scheduler-ilb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 512
    memory_task_definition = 1024
    log_group_name         = "qs-dev-ec1-scheduler-ecs"
    ingress_port           = 3003
    secrets                = ["NODE_ENV", "AWS_REGION", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "COGNITO_WORKER_SQS_QUEUE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "COGNITO_USER_SYNC_SQS_QUEUE_URL", "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL", "DEFAULT_SCHEDULER_ROLE_ARN", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "FULL_LOAD_SQS_QUEUE_URL", "INCREMENTAL_LOAD_SQS_QUEUE_URL", "DBMS_SERVICE_URL", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "EVALUATION_SQS_QUEUE_URL", "WEBHOOK_WORKER_SQS_QUEUE_URL", "FISSION_STATUS_QUEUE_URL"]
    secret_manager_arn     = "qs-dev-ec1-scheduler-secret-v2"
    container_name         = "qs-dev-ec1-scheduler-ecs"
    container_port         = 3003
    host_port              = 3003
    cpu                    = 512
    memory                 = 1024
    execution_role_name    = "qs-dev-ec1-scheduler-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-scheduler-ecs-iam-role"
    security_group_names   = ["qs-dev-ec1-ilb-nsg"]
  }
  agent-runtime = {
    ecs_name               = "agent-runtime"
    family                 = "qs-dev-ec1-agent-runtime-ecs"
    desired_count          = 0
    target_group_name      = ["dev-qs-tg-alb-agent-runtime-v2", "qs-dev-agent-runtime-ilb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-agent-runtime-ecs"
    ingress_port           = 3006
    secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER"]
    secret_manager_arn     = "qs-dev-ec1-agent-runtime-secret-v2"
    container_name         = "qs-dev-ec1-agent-runtime-ecs"
    container_port         = 3006
    host_port              = 3006
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-dev-ec1-agent-runtime-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-agent-runtime-ecs-iam-role"
    security_group_names   = ["dev-qs-nsg-wss-alb-01", "qs-dev-ec1-ilb-nsg"]
  }
  etl = {
    ecs_name               = "etl"
    family                 = "qs-dev-ec1-etl-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-etl-ilb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-etl-ecs"
    ingress_port           = 3004
    secrets                = ["DATABASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "PORT", "ETL_AUTH_TOKEN", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "INTEG_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL"]
    secret_manager_arn     = "qs-dev-ec1-etl-secret-v2"
    container_name         = "qs-dev-ec1-etl-ecs"
    container_port         = 3004
    host_port              = 3004
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-dev-ec1-etl-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-etl-ecs-iam-role"
    security_group_names   = ["qs-dev-ec1-ilb-nsg"]
  }
  integration = {
    ecs_name               = "integration"
    family                 = "qs-dev-ec1-integration-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-integration-ilb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-integration-ecs"
    ingress_port           = 3005
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "CONFLUENCE_CONNECTION_ID", "ATLASSIAN_BASE_URL", "CONFLUENCE_BASE_URL", "CONFLUENCE_AUTH_TOKEN", "S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_DB_PASSWORD", "OPENAI_API_BASE_URL", "ANTHROPIC_API_BASE_URL", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "PG_DB_HOST", "PG_DB_PORT", "PG_DB_USERNAME", "PG_DB_PASSWORD", "PG_DB_NAME", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "DHL_API_BASE_URL", "GOKARLA_BASE_URL", "VAPI_API_ENDPOINT", "REDIS_CACHE_PORT", "REDIS_CACHE_HOST"]
    secret_manager_arn     = "qs-dev-ec1-integration-secret-v2"
    container_name         = "qs-dev-ec1-integration-ecs"
    container_port         = 3005
    host_port              = 3005
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-dev-ec1-integration-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-integration-ecs-iam-role"
    security_group_names   = ["qs-dev-ec1-ilb-nsg"]
  }
  librarian-retrieval = {
    ecs_name               = "librarian-retrieval"
    family                 = "qs-dev-ec1-librarian-retrieval-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-librarian-retrieval-ilb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-librarian-retrieval-ecs"
    ingress_port           = 9098
    secrets                = ["DATABASE_URL", "OPENAI_API_KEY", "VOYAGE_API_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "COMMON_DATABASE_URL", "VOYAGEAI_API_URL"]
    secret_manager_arn     = "qs-dev-ec1-librarian-retrieval-secret-v2"
    container_name         = "qs-dev-ec1-librarian-ecs"
    container_port         = 9098
    host_port              = 9098
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-dev-ec1-librarian-retrieval-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-librarian-retrieval-ecs-iam-role"
    security_group_names   = ["qs-dev-ec1-ilb-nsg"]
  }
  librarian-assets = {
    ecs_name               = "librarian-assets"
    family                 = "qs-dev-ec1-librarian-assets-ecs"
    desired_count          = 0
    target_group_name      = ["qs-dev-librarian-assets-alb"]
    subnets                = ["qs-dev-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-dev-ec1-librarian-assets-ecs"
    ingress_port           = 9099
    secrets                = ["DATABASE_URL", "OPENAI_API_KEY", "VOYAGE_API_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "COMMON_DATABASE_URL", "VOYAGEAI_API_URL", "SERVICE_NAME", "CUSTOM_ACCESS_TOKEN_SECRET_KEY"]
    secret_manager_arn     = "qs-dev-ec1-librarian-assets-secret-v2"
    container_name         = "qs-dev-ec1-librarian-assets-ecs"
    container_port         = 9099
    host_port              = 9099
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-dev-ec1-librarian-assets-ecs-iam-role"
    task_role_name         = "qs-dev-ec1-librarian-assets-ecs-iam-role"
    security_group_names   = ["qs-dev-ec1-alb-nsg"]
  }
}

#################################
######## DB SUBNET GROUP ########
#################################

dbsubnet = {
  subnet_group_01 = {
    name        = "qs-dev-ec1-db-sne-grp"
    subnet_name = ["qs-dev-ec1-private-sne-rds-01a-v2", "qs-dev-ec1-private-sne-rds-02b-v2", "qs-dev-ec1-private-sne-rds-03c-v2"]
  }
}

#################################
########   COGNITO  #############
#################################

tenants = {
  hepster = {
    user_pool_name               = "qs-dev-ec1-customer0005-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0005"
    callbackUrls                 = ["https://hepster.dev.octonomy.ai/api/appconnect/auth/callback", "https://hepster.dev.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://hepster.dev.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      hepster = {
        idp_name    = "hepster"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=96347ed3-12e0-422b-bcbc-0847b2a01548"
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
      "TenantID"    = "Customer0005"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  # anwr = {
  #   user_pool_name               = "qs-dev-ec1-customer0006-cgnto-v1"
  #   post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-post-signup-trigger-lambda-v1"
  #   app_client_name              = "customer0006"
  #   callbackUrls                 = ["https://anwr.dev.octonomy.ai/api/appconnect/auth/callback", "https://anwr.dev.octonomy.ai/api/appconnect/chat/callback"]
  #   logout_urls                  = ["https://anwr.dev.octonomy.ai/api/appconnect/auth/signout"]
  #   idp = {
  #     anwr = {
  #       idp_name    = "anwr"
  #       metadataUrl = "https://dev-13821971.okta.com/app/exkngybnvayqCNHsR5d7/sso/saml/metadata"
  #       idp_attributes = {
  #         email       = "emailaddress"
  #         given_name  = "givenname"
  #         name        = "name"
  #         family_name = "surname"
  #         "custom:object_id" = "objectid"
  #       }
  #     }
  #   }
  #   user_pool_schemas = [
  #     {
  #       attribute_data_type = "String"
  #       name                = "object_id"
  #       required            = false
  #       mutable             = true
  #       string_attribute_constraints = {
  #         min_length = 0
  #         max_length = 2048
  #       }
  #     }
  #   ]
  #   tags = {
  #     "TenantID" = "Customer0006" 
  #   }
  # }
  worldhost-group = {
    user_pool_name               = "qs-dev-ec1-customer0012-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0012"
    callbackUrls                 = ["https://worldhost-group.dev.octonomy.ai/api/appconnect/auth/callback", "https://worldhost-group.dev.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://worldhost-group.dev.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      worldhost-group = {
        idp_name    = "worldhost-group"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=96347ed3-12e0-422b-bcbc-0847b2a01548"
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
      "TenantID"    = "Customer0012"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
}

#################################
########     LAMBDA   ###########
#################################

# Lamda
lambda = {
  lambda01 = {
    function_name = "qs-dev-ec1-post-signup-trigger-lambda-v2"
    role_name     = "qs-dev-ec1-trigger-lambda-iam-role"
    variables = {
      DB_DATA_MIGRATION_SQS_QUEUE_URL = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-cognito-user-sync-sqs-v2"
    }
  }
}

#################################
########     SQS     ############
#################################

sqs = {
  sqs0001 = {
    name = "qs-dev-ec1-cognito-user-partial-sync-sqs-v2"
  }
  sqs0002 = {
    name = "qs-dev-ec1-cognito-user-sync-sqs-v2"
  }
  sqs0003 = {
    name = "qs-dev-ec1-db-data-migration-sqs-v2"
  }
  sqs0004 = {
    name = "qs-dev-ec1-prompt-process-sqs-v2"
  }
  sqs0005 = {
    name = "qs-dev-ec1-prompt-process-sqs-v1"
  }
  sqs0006 = {
    name = "qs-dev-ec1-prompt-process-sqs-v3"
  }
  sqs0007 = {
    name = "qs-dev-ec1-prompt-process-sqs-v4"
  }
  sqs0008 = {
    name = "qs-dev-ec1-cr-data-loader-sqs-v2"
  }
  sqs0009 = {
    name = "qs-dev-ec1-whg-prompt-process-sqs-v1"
  }
  sqs0010 = {
    name = "qs-dev-ec1-whg-prompt-process-sqs-v2"
  }
  sqs0011 = {
    name = "qs-dev-ec1-whg-prompt-process-sqs-v3"
  }
  sqs0012 = {
    name = "qs-dev-ec1-whg-prompt-process-sqs-v4"
  }
  sqs0013 = {
    name = "qs-dev-ec1-whg-webhook-process-sqs-v1"
  }
  sqs0014 = {
    name = "qs-dev-ec1-db-schema-migration-sqs-v2"
  }
  sqs0015 = {
    name = "qs-dev-ec1-librarian-kb-migrations-sqs-v2"
  }
  sqs0016 = {
    name = "qs-dev-ec1-conversation-timeout-sqs-v1"
  }
}

#################################
########  schedulers ############
#################################

schedulers = [
  {
    name                         = "qs-dev-ec1-customer0001-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0001"
    job_id                       = "1"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 1
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
    name                         = "qs-dev-ec1-customer0002-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0002 "
    job_id                       = "2"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 2
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
    name                         = "qs-dev-ec1-customer0003-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0003 "
    job_id                       = "3"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 3
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
    name                         = "qs-dev-ec1-customer0004-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0004"
    job_id                       = "4"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 4
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
    name                         = "qs-dev-ec1-customer0005-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0005"
    job_id                       = "5"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 5
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
    name                         = "qs-dev-ec1-customer0006-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0006"
    job_id                       = "6"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 6
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
    name                         = "qs-dev-ec1-customer0012-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0012"
    job_id                       = "8"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 8
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-dev-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-dev-ec1-scheduler-iam-role"
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
  }
]

#################################
########  App Config   ##########
#################################

appconfig = {
  "qs-dev-app-01" = {
    app_name = "qs-dev-ec1-app-appconfig-v2"
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
    environment = {
      "dev" = {
        name        = "dev"
        description = "Development environment"
        tags = {
          "Project"     = "qs"
          "Environment" = "dev"
          "Terraformed" = true
          "Owner"       = "Octonomy.devops@talentship.io"
          "Version"     = "V2"
        }
      }
    }
    config = {
      "config1" = {
        name        = "qs-dev-ec1-app-appconfig-feature-v2"
        description = "Primary configuration"
        tags = {
          "Project"     = "qs"
          "Environment" = "dev"
          "Terraformed" = true
          "Owner"       = "Octonomy.devops@talentship.io"
          "Version"     = "V2"
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
    secret_name = "qs-dev-ec1-api-secret-v2"
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
      "NEO4J_URL_CUSTOMER"          = ""
      "ETL_AUTH_TOKEN"              = ""
      "INTEG_AUTH_TOKEN"            = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "dbms" = {
    secret_name = "qs-dev-ec1-dbms-secret-v2"
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
      "NEO4J_URL_CUSTOMER"                = ""
      "ETL_AUTH_TOKEN"                    = ""
      "INTEG_AUTH_TOKEN"                  = ""
      "CLUSTER_MANAGER_ETL_ENABLED"       = ""
      "DATABASE_URL_ETL"                  = ""
      "SHADOW_DATABASE_URL_ETL"           = ""
    }
  }
  "integration" = {
    secret_name = "qs-dev-ec1-integration-secret-v2"
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
      "NEO4J_URI_CUSTOMER"                = ""
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
    secret_name = "qs-dev-ec1-etl-secret-v2"
    secret_keys = {
      "DATABASE_URL"                = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "agentruntime" = {
    secret_name = "qs-dev-ec1-agent-runtime-secret-v2"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "scheduler" = {
    secret_name = "qs-dev-ec1-scheduler-secret-v2"
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
      "NEO4J_URL_CUSTOMER"                      = ""
      "ETL_AUTH_TOKEN"                          = ""
      "INTEG_AUTH_TOKEN"                        = ""
      "CLUSTER_MANAGER_ETL_ENABLED"             = ""
    }
  }
  "app" = {
    secret_name = "qs-dev-ec1-app-secret-v2"
    secret_keys = {
      "NEXT_PUBLIC_DOMAIN"        = "octonomy"
      "NEXT_PUBLIC_SOCKET_DOMAIN" = "wss.octonomy"
    }
  }
  "ai-agent" = {
    secret_name = "qs-dev-ec1-ai-agent-secret-v2"
    secret_keys = {
      "RETRIVAL_AUTH_TOKEN" = ""
      "VOYAGE_API_KEY"      = ""
      "VOYAGE_RERANK_MODEL" = ""
    }
  }
  "librarian-assets" = {
    secret_name = "qs-dev-ec1-librarian-assets-secret-v2"
    secret_keys = {
      "DATABASE_URL"         = ""
      "OPENAI_API_KEY"       = ""
      "VOYAGE_API_KEY"       = ""
      "ENV"                  = ""
      "LIBRARIAN_AUTH_TOKEN" = ""
      "COMMON_DATABASE_URL"  = ""
      "VOYAGEAI_API_URL"     = ""
      "SERVICE_NAME"         = ""
    }
  }
  "librarian-retrieval" = {
    secret_name = "qs-dev-ec1-librarian-retrieval-secret-v2"
    secret_keys = {
      "DATABASE_URL"         = ""
      "OPENAI_API_KEY"       = ""
      "VOYAGE_API_KEY"       = ""
      "ENV"                  = ""
      "LIBRARIAN_AUTH_TOKEN" = ""
      "COMMON_DATABASE_URL"  = ""
      "VOYAGEAI_API_URL"     = ""
    }
  }
  "agent-runtime" = {
    secret_name = "qs-dev-ec1-agent-runtime-secret-v3"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "librarian-migration" = {
    secret_name = "qs-dev-ec1-librarian-migration-secret-v3"
    secret_keys = {
      "COMMON_DATABASE_URL"                  = ""
      "DATABASE_URL"                         = ""
      "ENV"                                  = ""
      "LIBRARIAN_AUTH_TOKEN"                 = ""
      "OPENAI_API_KEY"                       = ""
      "SERVICE_NAME"                         = ""
      "VOYAGE_API_KEY"                       = ""
      "VOYAGEAI_API_URL"                     = ""
      "ENCRYPTION_KEY"                       = ""
      "AUTH_STRATEGY"                        = ""
      "CONFIGURATION_SCHEMA_BUCKET"          = ""
      "CONFIGURATION_SCHEMA_PATH"            = ""
      "CONFIGURATION_SCHEMA_DEFAULT_VERSION" = ""
      "VECTOR_DB_TYPE"                       = ""
    }
  }
  "whg-agent-runtime" = {
    secret_name = "qs-dev-ec1-whg-agent-runtime-secret-v2"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "whg-api" = {
    secret_name = "qs-dev-ec1-whg-api-secret-v2"
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
      "NEO4J_URL_CUSTOMER"          = ""
      "ETL_AUTH_TOKEN"              = ""
      "INTEG_AUTH_TOKEN"            = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "stage-processor" = {
    secret_name = "qs-dev-ec1-stage-processor-secret-v2"
    secret_keys = {
      "SENTRY_DSN" = ""
      "ENV_MODE"   = ""
    }
  }
}

iam_policies = {
  "iam_001" = {
    name        = "AwsKms_v2"
    description = "AwsKms"
    statements = [{
      Action = [
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:kms:eu-central-1:905418116080:key/*"]
    }]
  }
  "iam_002" = {
    name        = "Amazon-EventBridge-Scheduler-Execution-Policy-v2"
    description = "Amazon-EventBridge-Scheduler-Execution-Policy"
    statements = [{
      Action = [
        "sqs:SendMessage"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:sqs:eu-central-1:905418116080:*"]
    }]
  }
  "iam_003" = {
    name        = "AmazonECSTaskExecutionRolePolicy-Policy-v2"
    description = "AmazonECSTaskExecutionRolePolicy-Policy-v2"
    statements = [{
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_004" = {
    name        = "AmazonSQS-Policy-v2"
    description = "AmazonSQS-Policy-v2"
    statements = [{
      Action = [
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessage",
        "sqs:Get*",
        "sqs:List*",
        "sqs:ReceiveMessage",
        "sqs:SendMessage",
        "sqs:StartMessageMoveTask",
        "sqs:TagQueue",
        "sqs:UntagQueue"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_005" = {
    name        = "AmazonSSM-api-Policy-v2"
    description = "AmazonSSM-api-Policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
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
        "logs:UpdateLogDelivery"
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
  "iam_006" = {
    name        = "AmazonCognito-Policy-v2"
    description = "AmazonCognito-Policy-v2"
    statements = [{
      Action = [
        "cognito-idp:AdminAddUserToGroup",
        "cognito-idp:AdminDisableUser",
        "cognito-idp:AdminEnableUser",
        "cognito-idp:AdminGetUser",
        "cognito-idp:AdminListGroupsForUser",
        "cognito-idp:AdminRemoveUserFromGroup",
        "cognito-idp:AdminUserGlobalSignOut",
        "cognito-idp:AssociateWebACL",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:DescribeUserPoolClient",
        "cognito-idp:DescribeUserPool",
        "cognito-idp:ListUserPoolClients",
        "cognito-idp:ListUsers"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_007" = {
    name        = "AmazonS3-Policy-v2"
    description = "AmazonS3-Policy-v2"
    statements = [{
      Action = [
        "s3:AbortMultipartUpload",
        "s3:BypassGovernanceRetention",
        "s3:CreateStorageLensGroup",
        "s3:DeleteJobTagging",
        "s3:DeleteObject*",
        "s3:DeleteStorageLensConfigurationTagging",
        "s3:DeleteStorageLensGroup",
        "s3:GetBucketMetadataTableConfiguration",
        "s3:GetBucketTagging",
        "s3:GetJobTagging",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:GetObjectLegalHold",
        "s3:GetObjectRetention",
        "s3:GetObjectTagging",
        "s3:GetObjectTorrent",
        "s3:GetObjectVersion*",
        "s3:GetStorageLensConfigurationTagging",
        "s3:GetStorageLensGroup",
        "s3:InitiateReplication",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:ListMultipartUploadParts",
        "s3:ListStorageLensGroups",
        "s3:ListTagsForResource",
        "s3:ObjectOwnerOverrideToBucketOwner",
        "s3:PauseReplication",
        "s3:PutAccessPointPublicAccessBlock",
        "s3:PutBucketTagging",
        "s3:PutJobTagging",
        "s3:PutObject*",
        "s3:PutStorageLensConfigurationTagging",
        "s3:Replicate*",
        "s3:RestoreObject",
        "s3:TagResource",
        "s3:UntagResource",
        "s3:UpdateBucket*",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_008" = {
    name        = "SecretsManagerReadWrite-api-Policy-v2"
    description = "SecretsManagerReadWrite-api-Policy-v2"
    statements = [{
      Action = [
        "secretsmanager:BatchGetSecretValue",
        "secretsmanager:GetSecretValue",
        "secretsmanager:TagResource",
        "secretsmanager:UntagResource",
        "secretsmanager:UpdateSecretVersionStage"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = ["s3:GetObject"],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
      }
    ]
  }
  "iam_009" = {
    name        = "SecretsManagerReadWrite-Policy-v2"
    description = "SecretsManagerReadWrite-Policy-v2"
    statements = [{
      Action = [
        "secretsmanager:BatchGetSecretValue",
        "secretsmanager:GetSecretValue",
        "secretsmanager:TagResource",
        "secretsmanager:UntagResource",
        "secretsmanager:UpdateSecretVersionStage"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_010" = {
    name        = "AmazonSSM-Policy-v2"
    description = "AmazonSSM-Policy-v2"
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
  "iam_011" = {
    name        = "AmazonSES-Policy-v2"
    description = "AmazonSES-Policy-v2"
    statements = [{
      Action = [
        "ses:AllowVendedLogDeliveryForResource",
        "ses:CancelExportJob",
        "ses:CreateExportJob",
        "ses:CreateTenant*",
        "ses:DeleteTenant*",
        "ses:GetAddressListImportJob",
        "ses:GetExportJob",
        "ses:GetReputationEntity",
        "ses:GetTenant",
        "ses:ListReputationEntities",
        "ses:ListResourceTenants",
        "ses:ListTagsForResource",
        "ses:ListTenantResources",
        "ses:ListTenants",
        "ses:ReplicateEmailIdentityDkimSigningKey",
        "ses:SendBulk*",
        "ses:SendEmail",
        "ses:SendRawEmail",
        "ses:SendTemplatedEmail",
        "ses:StartAddressListImportJob",
        "ses:StopAddressListImportJob",
        "ses:TagResource",
        "ses:UntagResource",
        "ses:UpdateReputation*"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_012" = {
    name        = "ecr-role-policy-v2"
    description = "ecr-role-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:logs:*:*:*"]
    }]
  }
}

role = {
  api = {
    name         = "qs-dev-ec1-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-api-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonCognito-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonS3-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSQS-Policy-v2"
    ]
  }
  app = {
    name         = "qs-dev-ec1-app-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-Policy-v2"
    ]
  }
  dbms = {
    name         = "qs-dev-ec1-dbms-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSQS-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonCognito-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-Policy-v2"
    ]
  }
  ai-agent = {
    name         = "qs-dev-ec1-ai-agent-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  agent-runtime = {
    name         = "qs-dev-ec1-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-api-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSQS-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonS3-Policy-v2",
      "arn:aws:iam::aws:policy/AmazonBedrockFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
    ]
  }
  scheduler = {
    name         = "qs-dev-ec1-scheduler-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-api-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSQS-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonCognito-Policy-v2",
      "arn:aws:iam::aws:policy/AmazonEventBridgeSchedulerFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  etl = {
    name         = "qs-dev-ec1-etl-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  integration = {
    name         = "qs-dev-ec1-integration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonECSTaskExecutionRolePolicy-Policy-v2",
      "arn:aws:iam::905418116080:policy/SecretsManagerReadWrite-api-Policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/AmazonS3-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSES-Policy-v2"
    ]
  }
  lambda = {
    name         = "qs-dev-ec1-trigger-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/AmazonCognito-Policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSQS-Policy-v2",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::905418116080:policy/ecr-role-policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  eventbridge_scheduler = {
    name         = "qs-dev-ec1-scheduler-iam-role"
    type         = "Service"
    service_type = ["scheduler.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/Amazon-EventBridge-Scheduler-Execution-Policy-QS"
    ]
  }
  # x-agent-runtime = {
  #   name         = "qs-dev-ec1-2-agent-runtime-ecs-iam-role"
  #   type         = "Service"
  #   service_type = ["ecs-tasks.amazonaws.com"]
  #   permission_arn = [
  #     "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
  #     "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
  #     "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
  #     "arn:aws:iam::905418116080:policy/AwsKms_v2",
  #     "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  #   ]
  # }
  librarian-retrieval = {
    name         = "qs-dev-ec1-librarian-retrieval-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    ]
  }
  librarian-assets = {
    name         = "qs-dev-ec1-librarian-assets-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2"
    ]
  }
  librarian-migration = {
    name         = "qs-dev-ec1-librarian-migration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2"
    ]
  }
  whg-agent-runtime = {
    name         = "qs-dev-ec1-whg-agent-runtime-ecs-iam-role-v2"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
    ]
  }
  whg-api = {
    name         = "qs-dev-ec1-whg-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
    ]
  }
  lambda02 = {
    name         = "qs-dev-ec1-queue-handler-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  ingestion-queue-orchestrator = {
    name         = "qs-dev-ec1-ingestion-queue-orchestrator-ecs-iam-role"
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
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-llm = {
    name         = "qs-dev-ec1-ingestion-worker-llm-ecs-iam-role"
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
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-generic = {
    name         = "qs-dev-ec1-ingestion-worker-generic-ecs-iam-role"
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
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-pgvector-loader = {
    name         = "qs-dev-ec1-ingestion-worker-pgvector-loader-ecs-iam-role"
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
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
}

#################################
######## REDIS ########
#################################

redis_subnet = {
  subnet_group_01 = {
    name        = "qs-dev-ec1-redis-sne-grp"
    subnet_name = ["qs-dev-ec1-private-sne-redis-01a-v2"]
  }
}

# Redis Parameter Group
redis_params = {
  "param001" = {
    redis_pg_name   = "qs-dev-ec1-redis-pubsub-pg-v2"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "AKE"
      }
    ]
  }
  "param002" = {
    redis_pg_name   = "qs-dev-ec1-redis-cache-pg-v2"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "Ex"
    }]
  }
  "param003" = {
    redis_pg_name   = "qs-dev-ec1-redis-whg-pubsub-pg-v2"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "AKE"
    }]
  }
}

redis = {
  "redis01" = {
    name                 = "qs-dev-ec1-redis-cache-v2"
    sneGroupName         = "qs-dev-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-dev-ec1-main-vpc-v2"
    parameter_group_name = "qs-dev-ec1-redis-cache-pg-v2"
    num_cache_clusters   = 1
    environment          = "dev"
  }
  "redis02" = {
    name                 = "qs-dev-ec1-redis-pubsub-v2"
    sneGroupName         = "qs-dev-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-dev-ec1-main-vpc-v2"
    parameter_group_name = "qs-dev-ec1-redis-pubsub-pg-v2"
    num_cache_clusters   = 1
    environment          = "dev"
  }
  "redis03" = {
    name                 = "qs-dev-ec1-redis-whg-pubsub-v2"
    sneGroupName         = "qs-dev-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-dev-ec1-main-vpc-v2"
    num_cache_clusters   = 1
    parameter_group_name = "qs-dev-ec1-redis-whg-pubsub-pg-v2"
    environment          = "dev"
  }
}

s3 = {
  "s30001" = {
    bucket_name             = "qs-dev-ec1-logos-s3-v2"
    block_all_public_access = true
  }
  "s30002" = {
    bucket_name             = "qs-dev-ec1-customer0001-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0001"
    tags = {
      "TenantID"    = "Customer0001"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30003" = {
    bucket_name             = "qs-dev-ec1-customer0002-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0002"
    tags = {
      "TenantID"    = "Customer0002"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30004" = {
    bucket_name             = "qs-dev-ec1-customer0003-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0003"
    tags = {
      "TenantID"    = "Customer0003"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30005" = {
    bucket_name             = "qs-dev-ec1-customer0004-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0004"
    tags = {
      "TenantID"    = "Customer0004"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30006" = {
    bucket_name             = "qs-dev-ec1-gluescript-s3-v2"
    block_all_public_access = true
  }
  "s30007" = {
    bucket_name             = "qs-dev-ec1-glue-library-dependency-s3-v2"
    block_all_public_access = true
  }
  "s30008" = {
    bucket_name             = "qs-dev-ec1-chatwidget-s3-v2"
    block_all_public_access = true
  }
  "s30009" = {
    bucket_name             = "qs-dev-ec1-customer0005-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0005"
    tags = {
      "TenantID"    = "Customer0005"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30010" = {
    bucket_name             = "qs-dev-ec1-customer0006-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0006"
    tags = {
      "TenantID"    = "Customer0006"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30011" = {
    bucket_name             = "qs-dev-ec1-query-result-athena-s3-v2"
    block_all_public_access = true
  }
  "s30012" = {
    bucket_name             = "qs-dev-ec1-customer0012-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0012"
    tags = {
      "TenantID"    = "Customer0012"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "s30013" = {
    bucket_name             = "qs-dev-ec1-fission-deployment-s3-v1"
    block_all_public_access = true
  }
  "s30014" = {
    bucket_name             = "qs-dev-ec1-cost-report-s3-v1"
    block_all_public_access = true
  }
  "s30015" = {
    bucket_name             = "qs-dev-ec1-shared-s3-v2"
    block_all_public_access = true
    tags = {
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
}

# This is for custom policy
buckets = ["qs-dev-ec1-logos-s3-v2"]

s3_bucket_policy = {
  "qs-dev-ec1-logos-s3-v2" = {
    bucket_id = "qs-dev-ec1-logos-s3-v2"
    bucket_policy = {
      "Version" : "2012-10-17",
      "Id" : "PolicyForCloudFrontAndVPCEndpointAccess",
      "Statement" : [
        {
          "Sid" : "AllowCloudFrontServicePrincipal",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : ["cloudfront.amazonaws.com"]
          },
          "Action" : ["s3:GetObject"],
          "Resource" : ["arn:aws:s3:::qs-dev-ec1-logos-s3-v2/*"],
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : "arn:aws:cloudfront::905418116080:distribution/E2GUTO8CVRT7RI"
            }
          }
        },
        {
          "Sid" : "Access-to-specific-VPCE-only",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : ["s3:GetObject"],
          "Resource" : ["arn:aws:s3:::qs-dev-ec1-logos-s3-v2/*"],
          "Condition" : {
            "StringEquals" : {
              "aws:sourceVpce" : "vpce-0629f6b9f1b7d53bc"
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
  "dev" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-rds-dev-kms-v2"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "dev",
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
  "customer0001" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0001-kms-v2"
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0001"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "customer0003" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0003-kms-v2"
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0003"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "customer0004" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0004-kms-v2"
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0004"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "customer0002" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0002-kms-v2"
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0002"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "customer0005" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0005-kms-v2"
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0005"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "customer0006" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0006-kms-v2"
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0006"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "customer0012" = {
    environment = "dev"
    key_name    = "qs-dev-ec1-customer0012-kms-v2"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0012",
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
              "kms:CallerAccount" : "905418116080",
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
              "arn:aws:iam::905418116080:root",
              "arn:aws:iam::905418116080:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-DEV-QA_f5e44d1bf53f99d4"
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
      "TenantID"    = "Customer0012"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
}

#################################
########     RDS     ############
#################################

# RDS Parameter Group
rds_pg_name   = "qs-dev-ec1-rds-pg-v2"
rds_pg_family = "postgres16"
rds_pg_parameters = [
  {
    name  = "rds.force_ssl"
    value = "0"
  }
]

rds-new = {
  rds01 = {
    vpc_name                 = "qs-dev-ec1-main-vpc-v2"
    subnet_group_name        = "qs-dev-ec1-db-sne-grp"
    instance_name            = "dev"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.10"
    kms_key_arn              = "dev"
    environment              = "dev"
    parameter_group_name     = "qs-dev-ec1-rds-pg-v2"
    skip_final_snapshot      = true
    backup_retention_period  = 7
    deletion_protection      = true
    delete_automated_backups = false
    storage                  = 150
    max_storage              = 250
  }
}

sns_topics = {
  sns01 = {
    name = "qs-dev-ec1-sns-alert-v2"
  }
}
alarms = {
  "alarm0001" = {
    alarm_name                = "qs-dev-ec1-alarm-bastion-cpu-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 2
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Maximum"
    threshold                 = 90
    alarm_description         = "Alarm for EC2 instance CPU utilization"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    ec2_key                   = "Bastion_Host"
    dimensions = {
      InstanceId = "" // keep it empty and use ec2_key to get the instance Id, only applicable for namespace AWS/EC2
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-dev-ec1-alarm-bastion-status-v2"
    comparison_operator       = "GreaterThanThreshold"
    evaluation_periods        = 2
    metric_name               = "StatusCheckFailed"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Minimum"
    threshold                 = 0
    alarm_description         = "Alarm for EC2 instance Status check"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    actions_enabled           = true
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    ec2_key                   = "Bastion_Host"
    dimensions = {
      InstanceId = "" // keep it empty and use ec2_key to get the instance Id, only applicable for namespace AWS/EC2
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-api-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "api"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-agent-runtime-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "agent-runtime"
    }
  }
  "alarm0007" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-app-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "app"
    }
  }
  "alarm0008" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-dbms-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "dbms"
    }
  }
  "alarm0009" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-etl-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "etl"
    }
  }
  "alarm0010" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-integration-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "integration"
    }
  }
  "alarm0011" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-scheduler-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "scheduler"
    }
  }
  "alarm0012" = {
    alarm_name                = "qs-dev-ec1-alarm-ecs-ai-agent-taskcount-v2"
    comparison_operator       = "LessThanThreshold"
    evaluation_periods        = 1
    metric_name               = "RunningTaskCount"
    namespace                 = "ECS/ContainerInsights"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 1
    alarm_description         = "Alarm for ECS service task count"
    treat_missing_data        = "breaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-dev-ec1-main-ecs-v2"
      ServiceName = "ai-agent"
    }
  }
  "alarm0027" = {
    alarm_name                = "qs-dev-ec1-alarm-alb-main-503-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "HTTPCode_ELB_503_Count"
    namespace                 = "AWS/ApplicationELB"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 20
    alarm_description         = "Alarm for 503 errors in alb"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0027" = {
    alarm_name                = "qs-dev-ec1-alarm-alb-main-502-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "HTTPCode_ELB_502_Count"
    namespace                 = "AWS/ApplicationELB"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 20
    alarm_description         = "Alarm for 503 errors in alb"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0001-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-dev-ec1-customer0001-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0001"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "alarm0032" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0002-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-dev-ec1-customer0002-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0002"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "alarm0033" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0003-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-dev-ec1-customer0003-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0003"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "alarm0035" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0004-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      KeyId = "qs-dev-ec1-customer0004-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0004"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "alarm0036" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0005-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      KeyId = "qs-dev-ec1-customer0005-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0005"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "alarm0037" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0006-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-dev-ec1-customer0006-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0006"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
  "alarm0038" = {
    alarm_name                = "qs-dev-ec1-alarm-customer0012-kms-DisabledKey-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "DisabledKey"
    namespace                 = "AWS/KMS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 1
    alarm_description         = "Alarm triggers when a request fails due to a disabled KMS key"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-dev-ec1-customer0012-kms-v2"
    }
    tags = {
      "TenantID"    = "Customer0012"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
    }
  }
}
sns_topic_subscription = {
  snss01 = {
    sns_name = "qs-dev-ec1-sns-alert-v2"
    protocol = "email"
    endpoint = "rizwana.parveen@talentship.io"
  }
  snss02 = {
    sns_name = "qs-dev-ec1-sns-alert-v2"
    protocol = "email"
    endpoint = "Rajeshwar.rajakumar@talentship.io"
  }
  snss03 = {
    sns_name = "qs-dev-ec1-sns-alert-v2"
    protocol = "email"
    endpoint = "darwin.wilmut@talentship.io"
  }
}

lb_5xx_errors_threshold = 20

## Cloudfront ###

cf_origin_0001 = "qs-dev-ec1-logos-s3-v2.s3.eu-central-1.amazonaws.com"

## Cloudfront_0002 ##
cf_origin_0002 = "qs-dev-ec1-chatwidget-s3-v1.s3.eu-central-1.amazonaws.com"

rds_instance_id = "qs-dev-ec1-dev-rds-v2"

# Resource Groups
resource_groups = {
  "customer0001" = {
    resource_group_name = "qs-dev-ec1-rg-customer0001"
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
    resource_group_name = "qs-dev-ec1-rg-customer0002"
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
    resource_group_name = "qs-dev-ec1-rg-customer0003"
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
    resource_group_name = "qs-dev-ec1-rg-customer0004"
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
    resource_group_name = "qs-dev-ec1-rg-customer0005"
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
    resource_group_name = "qs-dev-ec1-rg-customer0006"
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
  "customer0012" = {
    resource_group_name = "qs-dev-ec1-rg-customer0012"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["customer0012"]
        }
      ]
    }
    EOT
  }
}
schedulers_threshold = 20
DBInstanceIdentifier = ["qs-dev-ec1-dev-rds-v2"]

#################################
########      WAF    ############
#################################

addresses = [
  "14.194.143.34/32"
]


waf_acls = {
  cloudfront_main = {
    name            = "qs-dev-ec1-waf-cf-v2"
    scope           = "CLOUDFRONT"
    description     = "qs-dev-ec1-waf-cf-v2"
    waf_metric_name = "qs-dev-ec1-waf-cf-v2"
    log_group_name  = "aws-waf-logs-qs-v2"
    waf_rules = [
      {
        name                  = "qs-dev-ec1-rate-limiting-v2"
        priority              = 0
        statement_type        = "rate_based"
        rate_limit            = 1000
        evaluation_window_sec = 300
        aggregate_key_type    = "IP"
        action                = "count"
        metric_name           = "qs-dev-ec1-rate-limiting-v2"
      },
      {
        name            = "F5-OWASP_Managed"
        priority        = 1
        statement_type  = "managed"
        vendor_name     = "F5"
        rule_group_name = "OWASP_Managed"
        rule_action_overrides = [
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
        name                     = "qs-dev-ec1-url-block-waf-rule"
        priority                 = 2
        statement_type           = "custom"
        statement_nested_type    = "and"
        byte_match_search_string = "/api/appconnect/docs"
        text_transformation_type = "NONE"
        country_codes            = ["IN"]
        action                   = "block"
        response_code            = 403
        custom_response_body_key = "403-response-page"
        metric_name              = "qs-dev-ec1-url-block-waf-rule"
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
        name           = "qs-dev-ec1-country-restrictions-allow-waf-rule"
        priority       = 3
        statement_type = "geo"
        country_codes = [
          "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
          "VA", "HU", "IS", "IN", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT", "MD", "MC", "ME", "NL",
          "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "UA", "GB", "US"
        ]
        action      = "allow"
        metric_name = "qs-dev-ec1-country-restrictions-allow-waf-rule"
      },
      {
        name           = "qs-dev-ec1-country-restrictions-block-waf-rule"
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
        metric_name              = "qs-dev-ec1-country-restrictions-block-waf-rule"
      },
      {
        name           = "qs-dev-ec1-country-restrictions-block-waf-rule-2"
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
        metric_name              = "qs-dev-ec1-country-restrictions-block-waf-rule-2"
      }
    ]
  }
}
sqs_actions_enabled = false

cloudwatch_log_group = {
  cloudwatch0001 = {
    log_group_name    = "qs-dev-ec1-observability-agent-runtime"
    retention_in_days = 90
  }
  cloudwatch0002 = {
    log_group_name    = "qs-dev-ec1-observability-api"
    retention_in_days = 90
  }
}

private_buckets = ["qs-dev-ec1-customer0001-s3-v2", "qs-dev-ec1-customer0002-s3-v2", "qs-dev-ec1-customer0003-s3-v2", "qs-dev-ec1-customer0004-s3-v2", "qs-dev-ec1-customer0005-s3-v2", "qs-dev-ec1-customer0006-s3-v2", "qs-dev-ec1-customer0012-s3-v2"]

public_alb_subnet_ids = ["subnet-07686e13487a5b3b5", "subnet-00b74f48981530d10", "subnet-0b87f68316a6cc8a1"]

private_alb_subnet_ids = ["subnet-0151fb821b2ad27b0", "subnet-02b81ce40eaafb0a8", "subnet-0ccd24e9891bd7c99"]

ecs_subnet_id = ["subnet-06994f804fe7d69ea"]

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
    secret_keys            = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
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
    secret_keys            = ["DATABASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "PORT", "ETL_AUTH_TOKEN", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "INTEG_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL"]
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
    secret_keys            = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "CONFLUENCE_CONNECTION_ID", "ATLASSIAN_BASE_URL", "CONFLUENCE_BASE_URL", "CONFLUENCE_AUTH_TOKEN", "S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_DB_PASSWORD", "OPENAI_API_BASE_URL", "ANTHROPIC_API_BASE_URL", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "PG_DB_HOST", "PG_DB_PORT", "PG_DB_USERNAME", "PG_DB_PASSWORD", "PG_DB_NAME", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "DHL_API_BASE_URL", "DHL_TEST_TRACKING_NUMBER", "GOKARLA_BASE_URL", "VAPI_API_ENDPOINT"]
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
    secret_keys            = ["COMMON_DATABASE_URL", "DATABASE_URL", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "SERVICE_NAME", "VOYAGEAI_API_URL", "VOYAGE_API_KEY", "ENCRYPTION_KEY", "AUTH_STRATEGY", "CONFIGURATION_SCHEMA_BUCKET", "CONFIGURATION_SCHEMA_PATH", "CONFIGURATION_SCHEMA_DEFAULT_VERSION", "VECTOR_DB_TYPE"]
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
  "librarian-migration" = {
    path = "/health-check"
  }
  "whg-api" = {
    path = "/api/appconnect/health-check"
  }
}

public_alb = {
  "ai-agent" = {
    container_port = 80
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

# Ingestion worker commands are now auto-generated from SQS URLs
