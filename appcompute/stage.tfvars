key = "stage/terraform.tfstate"

app_version = "v1"

#################################
########     ROLE     ###########
#################################

role_arn = "arn:aws:iam::180294192430:role/terraform-role"

#################################
########     TAG     ############
#################################

tags = {
  "Project"     = "qs"
  "Environment" = "stg"
  "Terraformed" = true
  "Version"     = "V1"
}


#################################
########     VPC     ############
#################################
vpc_name = "qs-stg-ec1-main-vpc-v1"
vpc_id   = "vpc-00be10ccfe0dfe1ef"

cidr_block = "10.2.0.0/16"

public_subnets = [
  { cidr = "10.2.0.0/28", az = "eu-central-1a", Name = "qs-stg-ec1-public-sne-nat-01a-v1", key = "subnet1" },      #NAT
  { cidr = "10.2.0.32/27", az = "eu-central-1a", Name = "qs-stg-ec1-public-sne-alb-01a-v1", key = "subnet2" },     #ALB
  { cidr = "10.2.0.64/27", az = "eu-central-1b", Name = "qs-stg-ec1-public-sne-alb-02b-v1", key = "subnet3" },     #ALB
  { cidr = "10.2.0.96/27", az = "eu-central-1c", Name = "qs-stg-ec1-public-sne-alb-03c-v1", key = "subnet4" },     #ALB
  { cidr = "10.2.0.128/27", az = "eu-central-1a", Name = "qs-stg-ec1-public-sne-nlb-01a-v1", key = "subnet5" },    #NLB
  { cidr = "10.2.0.160/27", az = "eu-central-1b", Name = "qs-stg-ec1-public-sne-nlb-02b-v1", key = "subnet6" },    #NLB
  { cidr = "10.2.0.192/27", az = "eu-central-1c", Name = "qs-stg-ec1-public-sne-nlb-03c-v1", key = "subnet7" },    #NLB
  { cidr = "10.2.0.224/28", az = "eu-central-1a", Name = "qs-stg-ec1-public-sne-bastion-01a-v1", key = "subnet8" } #Bastion Host 

]

# Indicates index of the public subnet
nat_subnet_index = 0

# NAT Name
nat_name = "qs-stg-ec1-nat-v1"

# Private Subnets
private_subnets = [
  { cidr = "10.2.1.0/24", az = "eu-central-1a", Name = "qs-stg-ec1-private-sne-ecs-01a-v1", key = "subnet1" },     #ECS
  { cidr = "10.2.2.0/24", az = "eu-central-1a", Name = "qs-stg-ec1-private-sne-rds-01a-v1", key = "subnet2" },     #RDS
  { cidr = "10.2.3.0/24", az = "eu-central-1b", Name = "qs-stg-ec1-private-sne-rds-02b-v1", key = "subnet3" },     #RDS
  { cidr = "10.2.4.0/24", az = "eu-central-1c", Name = "qs-stg-ec1-private-sne-rds-03c-v1", key = "subnet4" },     #RDS
  { cidr = "10.2.5.0/27", az = "eu-central-1a", Name = "qs-stg-ec1-private-sne-lambda-01a-v1", key = "subnet5" },  #Lambda
  { cidr = "10.2.6.0/24", az = "eu-central-1b", Name = "qs-stg-ec1-private-sne-neo4j-01b-v1", key = "subnet6" },   #Neo4j
  { cidr = "10.2.7.0/27", az = "eu-central-1a", Name = "qs-stg-ec1-private-sne-ilb-01a-v1", key = "subnet7" },     #ILB
  { cidr = "10.2.7.32/27", az = "eu-central-1b", Name = "qs-stg-ec1-private-sne-ilb-02b-v1", key = "subnet8" },    #ILB
  { cidr = "10.2.7.64/27", az = "eu-central-1c", Name = "qs-stg-ec1-private-sne-ilb-03c-v1", key = "subnet9" },    #ILB
  { cidr = "10.2.7.96/28", az = "eu-central-1a", Name = "qs-stg-ec1-private-sne-redis-01a-v1", key = "subnet10" }, #Redis
  { cidr = "10.2.8.0/24", az = "eu-central-1a", Name = "qs-stg-ec1-private-sne-glue-01a-v1", key = "subnet10" }    #Glue
]

vpc_tags = {
  "Name"        = "qs-stg-ec1-main-vpc-v1"
  "Project"     = "qs"
  "Environment" = "stg"
  "Terraformed" = true
  "Version"     = "V1"
}

#################################
########     EC2     ############
#################################

# Define the environment (e.g., "production", "stg", "test")
environment = "stg"

# Define EC2 instances
instances = {
  Bastion_Host = {
    ami               = "ami-0e04bcbe83a83792e"
    ssh_pub_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIxFVkOSnfld54CJ6PiwgfE58D5UamNld+nyEkjJnuA17WVJGZVHPjHVwMdrDmTgRqg7fb90eRiuaDANomD0MlCgqze4ajbYWdg2XCfjCNtWo/K9OZUXOGalvzIuLVLjiegQ/HrYBkVcFKHtWmdnmH+anzIRob508B0QDVsSGiIXP+GkqT7mBj+9jubet1luB+H7NKyDhDKtN2ib8XHDIEAsliQXe7Co7+IsUPyzE75pTVP8mM9w0sUv3StQwtVUrnM5pMYcqbjTOKT//ugeSGSXQgdFdHrE/G7picerAOFNIEXDh+5USQZScSlN6d6E6nEIN/ncSUaUTzseJ65JgzOzzZQsmnIK3hceT6D32gJp6fvzUPUhtK6B32rAU0jmvsE+jP1aC0hVOSDFYi6AWbOfKFlN8I0OYEabTTBFFRVwVW26fwD2p1G7JGPC4nBpdoToHOu7raJgC58yGee8kL100CU2G0NyQ+oiFdzfYOpfvvSOm6T4CpQNiox9BpyTFavc3puBMeJILjMiMpZQuLHXpIC7Ogk9lYeXE/33ckoqiPjDi+tJ3kwgtlmLMOhEpU9dBEg5X0fQEeoUpTilwjK1FWH/sEIcPicbwkTBvW0eFv3lvOqlbNATyE78rSZKldO3GbyxPsbkjv0t58fwEqAruBC7PFFthFOHzIHlEvaQ=="
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
    vpc_name          = "qs-stg-ec1-main-vpc-v1"
    eip               = false
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
        description     = "AWS Static IP EC2 instance connect"
      }
    }
  }
}

#################################
### APPLICATION LOAD BALANCER ###
#################################

ecs_cluster_name          = "qs-stg-ec1-main-ecs-v1"
enable_container_insights = true

alb_security_group     = "qs-stg-ec1-alb-nsg"
ilb_security_group     = "qs-stg-ec1-ilb-nsg"
wss_alb_security_group = "qs-stg-ec1-wss-alb-nsg"

lb = {
  "alb" = {
    lb_enable_deletion_protection = false
    lb_name                       = "qs-stg-ec1-main-alb-v1"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-stg-ec1-main-vpc-v1"
    lb_subnets_name               = ["qs-stg-ec1-public-sne-alb-01a-v1", "qs-stg-ec1-public-sne-alb-02b-v1", "qs-stg-ec1-public-sne-alb-03c-v1"]
    security_group_name           = "qs-stg-ec1-alb-nsg"
    lb_idle_timeout               = 60
    lb_client_keep_alive          = 3600
    is_internal_lb                = false
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-stg-ec1-main-alb-logs"
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
        certificate_domain = "*.stg.octonomy.ai"
        hosted_zone        = "stg.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          Talentship_Api = {
            tags         = { "Name" = "API" }
            priority     = 21
            action_type  = "forward"
            host_header  = ["*.stg.octonomy.ai", "demo.octonomy.ai"]
            path_pattern = ["/api/appconnect/*"]
            forward = {
              target_group_name = "qs-stg-api-alb"
            }
          }
          Talentship_App = {
            tags        = { "Name" = "APP" }
            priority    = 22
            action_type = "forward"
            host_header = ["*.stg.octonomy.ai", "demo.octonomy.ai"]
            forward = {
              target_group_name = "qs-stg-app-alb"
            }
          }
          AI-Agent = {
            tags        = { "Name" = "AI-Agent" }
            priority    = 10
            action_type = "forward"
            host_header = ["ai-agent.stg.octonomy.ai"]
            forward = {
              target_group_name = "qs-stg-ai-agent-alb"
            }
          }
          whg_Api = {
            tags         = { "Name" = "Whg-API" }
            priority     = 23
            action_type  = "forward"
            host_header  = ["worldhost-group.stg.octonomy.ai"]
            path_pattern = ["/api/appconnect/*"]
            forward = {
              target_group_name = "qs-stg-whg-api-alb"
            }
          }
          librarian-assets = {
            tags         = { "Name" = "Librarian-assets" }
            priority     = 20
            action_type  = "forward"
            host_header  = ["*.stg.octonomy.ai"]
            path_pattern = ["/assets/*"]
            forward = {
              target_group_name = "qs-stg-librarian-assets-alb"
            }
          }
        }
      }
    }
    target_groups = {
      ai-agent = {
        name                 = "qs-stg-ai-agent-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-api-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-app-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
      whg-api = {
        name                 = "qs-stg-whg-api-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
      librarian-assets = {
        name                 = "qs-stg-librarian-assets-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
    lb_name                       = "qs-stg-ec1-main-ilb-v1"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-stg-ec1-main-vpc-v1"
    lb_subnets_name               = ["qs-stg-ec1-private-sne-ilb-01a-v1", "qs-stg-ec1-private-sne-ilb-02b-v1", "qs-stg-ec1-private-sne-ilb-03c-v1"]
    security_group_name           = "qs-stg-ec1-ilb-nsg"
    is_internal_lb                = true
    lb_idle_timeout               = 300
    lb_client_keep_alive          = 3600
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-stg-ec1-main-ilb-alb-logs"
    listeners = {
      internallistener80 = {
        port           = 80
        protocol       = "HTTP"
        default_action = "forward"
        forward = {
          target_group_name = "qs-stg-scheduler-ilb"
        }
      }
      internallistener443 = {
        port               = 443
        protocol           = "HTTPS"
        ssl_policy         = "ELBSecurityPolicy-2016-08"
        certificate_domain = "*.internal.stg.octonomy.ai"
        hosted_zone        = "internal.stg.octonomy.ai"
        is_private_zone    = false
        default_action     = "forward"
        forward = {
          target_group_name = "qs-stg-scheduler-ilb"
        }
        rules = {
          internal-scheduler = {
            tags         = { "Name" = "scheduler" }
            priority     = 2
            action_type  = "forward"
            path_pattern = ["/scheduler/*"]
            forward = {
              target_group_name = "qs-stg-scheduler-ilb"
            }
          }
          internal-dbms = {
            tags         = { "Name" = "dbms" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/dbms/*"]
            forward = {
              target_group_name = "qs-stg-dbms-ilb"
            }
          }
          internal-etl = {
            tags         = { "Name" = "etl" }
            priority     = 3
            action_type  = "forward"
            path_pattern = ["/etl/*"]
            forward = {
              target_group_name = "qs-stg-etl-ilb"
            }
          }
          internal-integration = {
            tags         = { "Name" = "integration" }
            priority     = 4
            action_type  = "forward"
            path_pattern = ["/integration/*"]
            forward = {
              target_group_name = "qs-stg-integration-ilb"
            }
          }
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 5
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*"]
            forward = {
              target_group_name = "qs-stg-agent-runtime-ilb"
            }
          }
          internal-whg-agent-runtime = {
            tags         = { "Name" = "Whg-agent-runtime" }
            priority     = 6
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*"]
            forward = {
              target_group_name = "qs-stg-whg-agent-runtime-ilb"
            }
          }
          librarian-retrieval = {
            tags         = { "Name" = "Librarian-Retrieval" }
            priority     = 7
            action_type  = "forward"
            path_pattern = ["/librarian/*"]
            forward = {
              target_group_name = "qs-stg-librarian-retrieval-ilb"
            }
          }
        }
      }
    }
    target_groups = {
      internal-dbms = {
        name                 = "qs-stg-dbms-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-scheduler-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-etl-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-integration-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-agent-runtime-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
      whg-internal-agent-runtime = {
        name                 = "qs-stg-whg-agent-runtime-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
        name                 = "qs-stg-librarian-retrieval-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
    lb_name                       = "qs-stg-ec1-wss-alb-v1"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-stg-ec1-main-vpc-v1"
    lb_subnets_name               = ["qs-stg-ec1-public-sne-alb-01a-v1", "qs-stg-ec1-public-sne-alb-02b-v1", "qs-stg-ec1-public-sne-alb-03c-v1"]
    security_group_name           = "qs-stg-ec1-wss-alb-nsg"
    is_internal_lb                = false
    lb_idle_timeout               = 1800
    lb_client_keep_alive          = 1800
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-stg-ec1-wss-alb-logs"
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
        certificate_domain = "*.stg.wss.octonomy.ai"
        hosted_zone        = "stg.wss.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*", "/socket.io/*"]
            host_header  = ["*.stg.wss.octonomy.ai", "demo.wss.octonomy.ai"]
            forward = {
              target_group_name = "stg-qs-tg-alb-agent-runtime-v1"
            }
          }
          whg-agent-runtime = {
            tags         = { "Name" = "Whg-agent-runtime" }
            priority     = 2
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*", "/socket.io/*"]
            host_header  = ["worldhost-group.stg.wss.octonomy.ai"]
            forward = {
              target_group_name = "stg-qs-tg-alb-whg-A-runtime-v1"
            }
          }
          # x-agent-runtime = {
          #   tags        = { "Name" = "2-agent-runtime" }
          #   priority    = 2
          #   action_type = "forward"
          #   path_pattern = ["/agent-runtime/*", "/socket.io/*"]
          #   host_header = ["*.stg.wss.octonomy.ai", "demo.wss.octonomy.ai"]
          #   http_header = ["widget"]
          #   forward = {
          #     target_group_name = "stg-qs-tg-alb-agent-runtime-2-v1"
          #   }
          # }
        }
      }
    }
    target_groups = {
      agent-runtime = {
        name                 = "stg-qs-tg-alb-agent-runtime-v1"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
      whg-agent-runtime = {
        name                 = "stg-qs-tg-alb-whg-A-runtime-v1"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
      #   name                 = "stg-qs-tg-alb-agent-runtime-2-v1"
      #   target_type          = "ip"
      #   protocol             = "HTTP"
      #   port                 = 80
      #   deregistration_delay = 5
      #   vpc_name             = "qs-stg-ec1-main-vpc-v1"
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
    existing_service       = true
    ecs_name               = "api"
    family                 = "qs-stg-ec1-api-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-api-alb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-api-ecs"
    ingress_port           = 3001
    secret_manager_name    = "qs-stg-api"
    secrets                = ["DATABASE_URL"]
    execution_role_name    = "qs-stg-ec1-api-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-api-ecs-iam-role"
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "VAPI_API_ENDPOINT", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
    secret_manager_arn     = "qs-stg-ec1-api-secret-v1"
    logs_stream_prefix     = "qs-stg-ec1-api-ecs"
    container_name         = "qs-stg-ec1-api-ecs"
    container_port         = 3001
    host_port              = 3001
    cpu                    = 2048
    memory                 = 4096
    security_group_names   = ["qs-stg-ec1-alb-nsg"]
  }
  app = {
    existing_service       = true
    ecs_name               = "app"
    family                 = "qs-stg-ec1-app-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-app-alb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-app-ecs"
    execution_role_name    = "qs-stg-ec1-app-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-app-ecs-iam-role"
    ingress_port           = 3000

    container_name = "qs-stg-ec1-app-ecs"

    container_port       = 3000
    host_port            = 3000
    cpu                  = 2048
    memory               = 4096
    security_group_names = ["qs-stg-ec1-alb-nsg"]
  }
  dbms = {
    existing_service       = true
    ecs_name               = "dbms"
    family                 = "qs-stg-ec1-dbms-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-dbms-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-dbms-ecs"
    ingress_port           = 3002
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "ALLOWED_PREFIXES", "DBMS_AUTH_TOKEN", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL_ETL", "SHADOW_DATABASE_URL_ETL", "AGENT_RUNTIME_SERVICE_URL", "INTEGRATION_SERVICE_URL", "SCH_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "AI_AGENT_AUTH_TOKEN"]
    secret_manager_arn     = "qs-stg-ec1-dbms-secret-v1"
    container_name         = "qs-stg-ec1-dbms-ecs"
    secret_manager_name    = "qs-stg-dbms"
    # secrets             = ["PORT"]
    container_port       = 3002
    host_port            = 3002
    cpu                  = 2048
    memory               = 4096
    execution_role_name  = "qs-stg-ec1-dbms-ecs-iam-role"
    task_role_name       = "qs-stg-ec1-dbms-ecs-iam-role"
    security_group_names = ["qs-stg-ec1-ilb-nsg"]
  }
  ai-agent = {
    existing_service       = true
    ecs_name               = "ai-agent"
    family                 = "qs-stg-ec1-ai-agent-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-ai-agent-alb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-ai-agent-ecs"
    ingress_port           = 80
    secrets                = ["RETRIVAL_AUTH_TOKEN", "VOYAGE_API_KEY", "VOYAGE_RERANK_MODEL"]
    secret_manager_arn     = "qs-stg-ec1-ai-agent-secret-v2"

    container_name       = "qs-stg-ec1-ai-agent-ecs"
    container_port       = 80
    host_port            = 80
    cpu                  = 2048
    memory               = 4096
    execution_role_name  = "qs-stg-ec1-ai-agent-ecs-iam-role"
    task_role_name       = "qs-stg-ec1-ai-agent-ecs-iam-role"
    security_group_names = ["qs-stg-ec1-alb-nsg"]
  }
  scheduler = {
    existing_service       = true
    ecs_name               = "scheduler"
    family                 = "qs-stg-ec1-scheduler-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-scheduler-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-scheduler-ecs"
    ingress_port           = 3003
    secrets                = ["NODE_ENV", "AWS_REGION", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "COGNITO_WORKER_SQS_QUEUE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "COGNITO_USER_SYNC_SQS_QUEUE_URL", "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL", "DEFAULT_SCHEDULER_ROLE_ARN", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "FULL_LOAD_SQS_QUEUE_URL", "INCREMENTAL_LOAD_SQS_QUEUE_URL", "DBMS_SERVICE_URL", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "EVALUATION_SQS_QUEUE_URL", "WEBHOOK_WORKER_SQS_QUEUE_URL", "FISSION_STATUS_QUEUE_URL"]
    secret_manager_arn     = "qs-stg-ec1-scheduler-secret-v1"
    container_name         = "qs-stg-ec1-scheduler-ecs"
    container_port         = 3003
    host_port              = 3003
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-stg-ec1-scheduler-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-scheduler-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-ilb-nsg"]
  }
  agent-runtime = {
    existing_service       = true
    ecs_name               = "agent-runtime"
    family                 = "qs-stg-ec1-agent-runtime-ecs"
    desired_count          = 0
    target_group_name      = ["stg-qs-tg-alb-agent-runtime-v1", "qs-stg-agent-runtime-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-agent-runtime-ecs"
    ingress_port           = 3006
    secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL"]
    secret_manager_arn     = "qs-stg-ec1-agent-runtime-secret-v1"
    container_name         = "qs-stg-ec1-agent-runtime-ecs"
    container_port         = 3006
    host_port              = 3006
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-stg-ec1-agent-runtime-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-agent-runtime-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-wss-alb-nsg", "qs-stg-ec1-ilb-nsg"]
    # Autoscaling policies
    autoscaling_enabled = true
    autoscaling_policies = [
      {
        name                   = "qs-stg-ec1-ecs-agent-runtime-cpu-v1"
        policy_type            = "TargetTrackingScaling"
        predefined_metric_type = "ECSServiceAverageCPUUtilization"
        target_value           = 70
        scale_in_cooldown      = 300
        scale_out_cooldown     = 120
        scalable_dimension     = "ecs:service:DesiredCount"
        service_namespace      = "ecs"
        max_capacity           = 2
        min_capacity           = 1
      },
      {
        name                   = "qs-stg-ec1-ecs-agent-runtime-memory-v1"
        policy_type            = "TargetTrackingScaling"
        predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        target_value           = 70
        scale_in_cooldown      = 300
        scale_out_cooldown     = 120
        scalable_dimension     = "ecs:service:DesiredCount"
        service_namespace      = "ecs"
        max_capacity           = 2
        min_capacity           = 1
      }
    ]
  }
  etl = {
    existing_service       = true
    ecs_name               = "etl"
    family                 = "qs-stg-ec1-etl-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-etl-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-etl-ecs"
    ingress_port           = 3004
    secrets                = ["DATABASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "PORT", "ETL_AUTH_TOKEN", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "INTEG_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL"]
    secret_manager_arn     = "qs-stg-ec1-etl-secret-v1"
    container_name         = "qs-stg-ec1-etl-ecs"
    container_port         = 3004
    host_port              = 3004
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-stg-ec1-etl-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-etl-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-ilb-nsg"]
  }
  integration = {
    existing_service       = true
    ecs_name               = "integration"
    family                 = "qs-stg-ec1-integration-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-integration-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-integration-ecs"
    ingress_port           = 3005
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "CONFLUENCE_CONNECTION_ID", "ATLASSIAN_BASE_URL", "CONFLUENCE_BASE_URL", "CONFLUENCE_AUTH_TOKEN", "S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_DB_PASSWORD", "OPENAI_API_BASE_URL", "ANTHROPIC_API_BASE_URL", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "PG_DB_HOST", "PG_DB_PORT", "PG_DB_USERNAME", "PG_DB_PASSWORD", "PG_DB_NAME", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "DHL_API_BASE_URL", "GOKARLA_BASE_URL", "VAPI_API_ENDPOINT"]
    secret_manager_arn     = "qs-stg-ec1-integration-secret-v1"
    container_name         = "qs-stg-ec1-integration-ecs"
    container_port         = 3005
    host_port              = 3005
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-stg-ec1-integration-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-integration-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-ilb-nsg"]

  }
  whg-api = {
    existing_service       = true
    ecs_name               = "whg-api"
    family                 = "qs-stg-ec1-whg-api-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-whg-api-alb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-whg-api-ecs"
    ingress_port           = 3001
    secret_manager_name    = "qs-stg-api"
    secrets                = ["DATABASE_URL"]
    execution_role_name    = "qs-stg-ec1-api-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-api-ecs-iam-role"
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "VAPI_API_ENDPOINT", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL"]
    secret_manager_arn     = "qs-stg-ec1-api-secret-v1"
    logs_stream_prefix     = "qs-stg-ec1-whg-api-ecs"
    container_name         = "qs-stg-ec1-whg-api-ecs"
    container_port         = 3001
    host_port              = 3001
    cpu                    = 2048
    memory                 = 4096
    security_group_names   = ["qs-stg-ec1-alb-nsg"]
  }
  whg-agent-runtime = {
    existing_service       = true
    ecs_name               = "whg-agent-runtime"
    family                 = "qs-stg-ec1-whg-agent-runtime-ecs"
    desired_count          = 0
    target_group_name      = ["stg-qs-tg-alb-whg-A-runtime-v1", "qs-stg-whg-agent-runtime-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-stg-ec1-whg-agent-runtime-ecs"
    ingress_port           = 3006
    secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER"]
    secret_manager_arn     = "qs-stg-ec1-agent-runtime-secret-v1"
    container_name         = "qs-stg-ec1-whg-agent-runtime-ecs"
    container_port         = 3006
    host_port              = 3006
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-stg-ec1-agent-runtime-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-agent-runtime-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-wss-alb-nsg", "qs-stg-ec1-ilb-nsg"]
    # Autoscaling policies
    autoscaling_enabled = true
    autoscaling_policies = [
      {
        name                   = "qs-stg-ec1-ecs-whg-agent-runtime-cpu-v1"
        policy_type            = "TargetTrackingScaling"
        predefined_metric_type = "ECSServiceAverageCPUUtilization"
        target_value           = 70
        scale_in_cooldown      = 300
        scale_out_cooldown     = 120
        scalable_dimension     = "ecs:service:DesiredCount"
        service_namespace      = "ecs"
        max_capacity           = 2
        min_capacity           = 1
      },
      {
        name                   = "qs-stg-ec1-ecs-whg-agent-runtime-memory-v1"
        policy_type            = "TargetTrackingScaling"
        predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        target_value           = 70
        scale_in_cooldown      = 300
        scale_out_cooldown     = 120
        scalable_dimension     = "ecs:service:DesiredCount"
        service_namespace      = "ecs"
        max_capacity           = 2
        min_capacity           = 1
      }
    ]
  }
  librarian-retrieval = {
    existing_service       = true
    ecs_name               = "librarian-retrieval"
    family                 = "qs-stg-ec1-librarian-retrieval-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-librarian-retrieval-ilb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-stg-ec1-librarian-retrieval-ecs"
    ingress_port           = 9098
    secrets                = ["DATABASE_URL", "OPENAI_API_KEY", "VOYAGE_API_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "COMMON_DATABASE_URL", "VOYAGEAI_API_URL"]
    secret_manager_arn     = "qs-stg-ec1-librarian-retrieval-secret-v1"
    container_name         = "qs-stg-ec1-librarian-ecs"
    container_port         = 9098
    host_port              = 9098
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-stg-ec1-librarian-retrieval-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-librarian-retrieval-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-ilb-nsg"]
  }
  librarian-assets = {
    existing_service       = true
    ecs_name               = "librarian-assets"
    family                 = "qs-stg-ec1-librarian-assets-ecs"
    desired_count          = 0
    target_group_name      = ["qs-stg-librarian-assets-alb"]
    subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-stg-ec1-librarian-assets-ecs"
    ingress_port           = 9099
    secrets                = ["DATABASE_URL", "OPENAI_API_KEY", "VOYAGE_API_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "COMMON_DATABASE_URL", "VOYAGEAI_API_URL", "SERVICE_NAME", "CUSTOM_ACCESS_TOKEN_SECRET_KEY"]
    secret_manager_arn     = "qs-stg-ec1-librarian-assets-secret-v1"
    container_name         = "qs-stg-ec1-librarian-assets-ecs"
    container_port         = 9099
    host_port              = 9099
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-stg-ec1-librarian-assets-ecs-iam-role"
    task_role_name         = "qs-stg-ec1-librarian-assets-ecs-iam-role"
    security_group_names   = ["qs-stg-ec1-alb-nsg"]
  }
  #  x-agent-runtime = {
  #     ecs_name               = "2-agent-runtime"
  #     family                 = "qs-stg-ec1-agent-runtime-ecs"
  #     desired_count          = 0
  #     target_group_name      = ["stg-qs-tg-alb-agent-runtime-2-v1"]
  #     subnets                = ["qs-stg-ec1-private-sne-ecs-01a-v1"]
  #     enable_execute_command = true
  #     cpu_task_definition    = 2048
  #     memory_task_definition = 4096
  #     log_group_name         = "qs-stg-ec1-2-agent-runtime-ecs"
  #     ingress_port           = 3006
  #     secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL"]
  #     secret_manager_arn     = "qs-stg-ec1-2-agent-runtime-secret-v1"
  #     container_name         = "qs-stg-ec1-agent-runtime-ecs"
  #     container_port         = 3006
  #     host_port              = 3006
  #     cpu                    = 2048
  #     memory                 = 4096
  #     execution_role_name    = "qs-stg-ec1-2-agent-runtime-ecs-iam-role"
  #     task_role_name         = "qs-stg-ec1-2-agent-runtime-ecs-iam-role"
  #     security_group_names   = ["qs-stg-ec1-wss-alb-nsg"]
  #   }
}

#################################
######## DB SUBNET GROUP ########
#################################

dbsubnet = {
  subnet_group_01 = {
    name        = "qs-stg-ec1-db-sne-grp"
    subnet_name = ["qs-stg-ec1-private-sne-rds-01a-v1", "qs-stg-ec1-private-sne-rds-02b-v1", "qs-stg-ec1-private-sne-rds-03c-v1"]
  }
}

#################################
########   COGNITO  #############
#################################

tenants = {
  aofoundation = {
    user_pool_name               = "qs-stg-ec1-customer0003-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0003"
    callbackUrls                 = ["https://aofoundation.stg.octonomy.ai/api/appconnect/auth/callback", "https://aofoundation.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://aofoundation.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      talentship = {
        idp_name    = "aofoundation"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "Customer0003"
    }
  }
  burnhard = {
    user_pool_name               = "qs-stg-ec1-customer0004-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0004"
    callbackUrls                 = ["https://burnhard.stg.octonomy.ai/api/appconnect/auth/callback", "https://burnhard.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://burnhard.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      talentship = {
        idp_name    = "burnhard"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "Customer0004"
    }
  }
  deichmann = {
    user_pool_name               = "qs-stg-ec1-customer0002-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0002"
    callbackUrls                 = ["https://deichmann.stg.octonomy.ai/api/appconnect/auth/callback", "https://deichmann.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://deichmann.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      talentship = {
        idp_name    = "deichmann"
        metadataUrl = "https://login.microsoftonline.com/577d96da-adf0-4fa5-a756-7b3cd3e267fd/federationmetadata/2007-06/federationmetadata.xml?appid=7838bf16-d0d6-4914-ad94-0d923912eeed"
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
      "TenantID" = "Customer0002"
    }
  }
  talentship = {
    user_pool_name               = "qs-stg-ec1-customer0001-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0001"
    callbackUrls                 = ["https://talentship.stg.octonomy.ai/api/appconnect/auth/callback", "https://talentship.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://talentship.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      talentship = {
        idp_name    = "talentship"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "Customer0001"
    }
  }
  anwr = {
    user_pool_name               = "qs-stg-ec1-customer0006-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0006"
    callbackUrls                 = ["https://anwr.stg.octonomy.ai/api/appconnect/auth/callback", "https://anwr.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://anwr.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      anwr = {
        idp_name    = "anwr"
        metadataUrl = "https://login.anwr-group.com/app/exklron91bOIxcrgo417/sso/saml/metadata"
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
  demo = {
    user_pool_name               = "qs-stg-ec1-demo-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "demo"
    callbackUrls                 = ["https://demo.octonomy.ai/api/appconnect/auth/callback", "https://demo.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://demo.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      talentship = {
        idp_name    = "demo"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "Demo"
    }
  }
  hepster = {
    user_pool_name               = "qs-stg-ec1-customer0005-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0005"
    callbackUrls                 = ["https://hepster.stg.octonomy.ai/api/appconnect/auth/callback", "https://hepster.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://hepster.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      hepster = {
        idp_name    = "hepster"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
  pfalzkom = {
    user_pool_name               = "qs-stg-ec1-customer0007-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0007"
    callbackUrls                 = ["https://pfalzkom.stg.octonomy.ai/api/appconnect/auth/callback", "https://pfalzkom.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://pfalzkom.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      pfalzkom = {
        idp_name    = "pfalzkom"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "Customer0007"
    }
  }
  berner = {
    user_pool_name               = "qs-stg-ec1-customer0008-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0008"
    callbackUrls                 = ["https://berner.stg.octonomy.ai/api/appconnect/auth/callback", "https://berner.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://berner.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      berner = {
        idp_name    = "berner"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0008"
    }
  }
  thyssen-gas = {
    user_pool_name               = "qs-stg-ec1-customer0009-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0009"
    callbackUrls                 = ["https://thyssen-gas.stg.octonomy.ai/api/appconnect/auth/callback", "https://thyssen-gas.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://thyssen-gas.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      thyssen-gas = {
        idp_name    = "thyssen-gas"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0009"
    }
  }
  havi = {
    user_pool_name               = "qs-stg-ec1-customer0010-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0010"
    callbackUrls                 = ["https://havi.stg.octonomy.ai/api/appconnect/auth/callback", "https://havi.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://havi.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      havi = {
        idp_name    = "havi"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0010"
    }
  }
  deutsche-windtechnik = {
    user_pool_name               = "qs-stg-ec1-customer0011-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0011"
    callbackUrls                 = ["https://deutsche-windtechnik.stg.octonomy.ai/api/appconnect/auth/callback", "https://deutsche-windtechnik.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://deutsche-windtechnik.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      deutsche-windtechnik = {
        idp_name    = "deutsche-windtechnik"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0011"
    }
  }
  bora = {
    user_pool_name               = "qs-stg-ec1-customer0013-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0013"
    callbackUrls                 = ["https://bora.stg.octonomy.ai/api/appconnect/auth/callback", "https://bora.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://bora.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      bora = {
        idp_name    = "bora"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0013"
    }
  }
  kartenmacherei = {
    user_pool_name               = "qs-stg-ec1-customer0014-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0014"
    callbackUrls                 = ["https://kartenmacherei.stg.octonomy.ai/api/appconnect/auth/callback", "https://kartenmacherei.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://kartenmacherei.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      kartenmacherei = {
        idp_name    = "kartenmacherei"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0014"
    }
  }
  worldhost-group = {
    user_pool_name               = "qs-stg-ec1-customer0012-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0012"
    callbackUrls                 = ["https://worldhost-group.stg.octonomy.ai/api/appconnect/auth/callback", "https://worldhost-group.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://worldhost-group.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      worldhost-group = {
        idp_name    = "worldhost-group"
        metadataUrl = "https://login.microsoftonline.com/ea8e08e3-9c7a-40c0-95ef-6ec0a852a961/federationmetadata/2007-06/federationmetadata.xml?appid=5e98f81f-a987-4db3-bf48-2df8359d62f2"
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
      "TenantID" = "customer0012"
    }
  }
  toptica = {
    user_pool_name               = "qs-stg-ec1-customer0016-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0016"
    callbackUrls                 = ["https://toptica.stg.octonomy.ai/api/appconnect/auth/callback", "https://toptica.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://toptica.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      toptica = {
        idp_name    = "toptica"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0016"
    }
  }
  securiton = {
    user_pool_name               = "qs-stg-ec1-customer0017-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0017"
    callbackUrls                 = ["https://securiton.stg.octonomy.ai/api/appconnect/auth/callback", "https://securiton.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://securiton.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      toptica = {
        idp_name    = "securiton"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0017"
    }
  }
  aekwl = {
    user_pool_name               = "qs-stg-ec1-customer0018-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0018"
    callbackUrls                 = ["https://aekwl.stg.octonomy.ai/api/appconnect/auth/callback", "https://aekwl.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://aekwl.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      aekwl = {
        idp_name    = "aekwl"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0018"
    }
  }
  dfmg = {
    user_pool_name               = "qs-stg-ec1-customer0019-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0019"
    callbackUrls                 = ["https://dfmg.stg.octonomy.ai/api/appconnect/auth/callback", "https://dfmg.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://dfmg.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      dfmg = {
        idp_name    = "dfmg"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0019"
    }
  }
  aluca = {
    user_pool_name               = "qs-stg-ec1-customer0020-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0020"
    callbackUrls                 = ["https://aluca.stg.octonomy.ai/api/appconnect/auth/callback", "https://aluca.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://aluca.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      aluca = {
        idp_name    = "aluca"
        metadataUrl = "https://login.microsoftonline.com/0ff7f29b-272e-4969-970a-9e9947b8b3e9/federationmetadata/2007-06/federationmetadata.xml?appid=3be9dd67-60ff-4f6e-89de-f495c6088060"
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
      "TenantID" = "customer0020"
    }
  }
  edl = {
    user_pool_name               = "qs-stg-ec1-customer0021-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0021"
    callbackUrls                 = ["https://edl.stg.octonomy.ai/api/appconnect/auth/callback", "https://edl.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://edl.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      edl = {
        idp_name    = "edl"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0021"
    }
  }
  emons = {
    user_pool_name               = "qs-stg-ec1-customer0022-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0022"
    callbackUrls                 = ["https://emons.stg.octonomy.ai/api/appconnect/auth/callback", "https://emons.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://emons.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      emons = {
        idp_name    = "emons"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0022"
    }
  }
  wenko = {
    user_pool_name               = "qs-stg-ec1-customer0023-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0023"
    callbackUrls                 = ["https://wenko.stg.octonomy.ai/api/appconnect/auth/callback", "https://wenko.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://wenko.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      wenko = {
        idp_name    = "wenko"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0023"
    }
  }
  liebherr = {
    user_pool_name               = "qs-stg-ec1-customer0024-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0024"
    callbackUrls                 = ["https://liebherr.stg.octonomy.ai/api/appconnect/auth/callback", "https://liebherr.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://liebherr.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      liebherr = {
        idp_name    = "liebherr"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0024"
    }
  }
  tre = {
    user_pool_name               = "qs-stg-ec1-customer0026-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0026"
    callbackUrls                 = ["https://tre.stg.octonomy.ai/api/appconnect/auth/callback", "https://tre.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://tre.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      tre = {
        idp_name    = "tre"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0026"
    }
  }
  ofb = {
    user_pool_name               = "qs-stg-ec1-customer0027-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:180294192430:function:qs-stg-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0027"
    callbackUrls                 = ["https://ofb.stg.octonomy.ai/api/appconnect/auth/callback", "https://ofb.stg.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://ofb.stg.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      ofb = {
        idp_name    = "ofb"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=e91db490-26ed-4ce5-9204-fd73964ca3ae"
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
      "TenantID" = "customer0027"
    }
  }
}

#################################
########     LAMBDA   ###########
#################################

# Lamda
lambda = {
  lambda01 = {
    function_name = "qs-stg-ec1-post-signup-trigger-lambda-v1"
    role_name     = "qs-stg-ec1-trigger-lambda-iam-role"
    variables = {
      DB_DATA_MIGRATION_SQS_QUEUE_URL = "https://sqs.eu-central-1.amazonaws.com/180294192430/qs-stg-ec1-cognito-user-sync-sqs-v1"
    }
  }
}

#################################
########     SQS     ############
#################################

sqs = {
  sqs0001 = {
    name = "qs-stg-ec1-cognito-user-partial-sync-sqs-v1"
  }
  sqs0002 = {
    name = "qs-stg-ec1-cognito-user-sync-sqs-v1"
  }
  sqs0003 = {
    name = "qs-stg-ec1-db-data-migration-sqs-v1"
  }
  sqs0004 = {
    name = "qs-stg-ec1-prompt-process-sqs-v1"
  }
  sqs005 = {
    name = "qs-stg-ec1-prompt-process-sqs-v2"
  }
  sqs006 = {
    name = "qs-stg-ec1-prompt-process-sqs-v3"
  }
  sqs007 = {
    name = "qs-stg-ec1-prompt-process-sqs-v4"
  }
  sqs008 = {
    name = "qs-stg-ec1-whg-prompt-process-sqs-v1"
  }
  sqs009 = {
    name = "qs-stg-ec1-whg-prompt-process-sqs-v2"
  }
  sqs010 = {
    name = "qs-stg-ec1-whg-prompt-process-sqs-v3"
  }
  sqs011 = {
    name = "qs-stg-ec1-whg-prompt-process-sqs-v4"
  }
  sqs012 = {
    name = "qs-stg-ec1-cr-data-loader-sqs-v1"
  }
  sqs013 = {
    name = "qs-stg-ec1-db-schema-migration-sqs-v1"
  }
}

#################################
########  schedulers ############
#################################

schedulers = [
  {
    name                         = "qs-stg-ec1-customer0001-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0001"
    job_id                       = "1"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 1
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0002-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0002 "
    job_id                       = "2"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 2
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0003-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0003 "
    job_id                       = "3"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 3
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0004-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0004"
    job_id                       = "4"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 4
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-demo-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for demo"
    job_id                       = "7"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 7
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0006-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0006"
    job_id                       = "8"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 8
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0005-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0005"
    job_id                       = "9"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 9
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0007-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0007"
    job_id                       = "10"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 10
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0008-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0008"
    job_id                       = "11"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 11
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0009-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0009"
    job_id                       = "12"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 12
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0010-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0010"
    job_id                       = "13"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 13
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0011-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0011"
    job_id                       = "14"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 14
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0013-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0013"
    job_id                       = "15"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 15
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0014-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0014"
    job_id                       = "16"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 16
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0012-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0012"
    job_id                       = "17"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 17
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0016-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0016"
    job_id                       = "18"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 18
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0017-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0017"
    job_id                       = "19"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 19
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0018-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0018"
    job_id                       = "20"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 20
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0019-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0019"
    job_id                       = "21"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 21
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0020-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0020"
    job_id                       = "22"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 22
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0021-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0021"
    job_id                       = "23"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 23
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0022-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0022"
    job_id                       = "24"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 24
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0023-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0023"
    job_id                       = "25"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 25
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0024-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0024"
    job_id                       = "26"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 26
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0026-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0026"
    job_id                       = "28"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 28
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
    name                         = "qs-stg-ec1-customer0027-cognito-user-sync-job-schedule-v1"
    description                  = "Sync job for customer0027"
    job_id                       = "29"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 29
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-stg-ec1-cognito-user-sync-sqs-v1"
    execution_role               = "qs-stg-ec1-scheduler-iam-role"
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
  "qs-stg-app-01" = {
    app_name = "qs-stg-ec1-app-appconfig-v1"
    tags = {
      "Project"     = "qs"
      "Environment" = "stg"
      "Terraformed" = true
      "Version"     = "V1"
    }
    environment = {
      "stg" = {
        name        = "stg"
        description = "stgelopment environment"
        tags = {
          "Project"     = "qs"
          "Environment" = "stg"
          "Terraformed" = true
          "Version"     = "V1"
        }
      }
    }
    config = {
      "config1" = {
        name        = "qs-stg-ec1-app-appconfig-feature-v1"
        description = "Primary configuration"
        tags = {
          "Project"     = "qs"
          "Environment" = "stg"
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
    secret_name = "qs-stg-ec1-api-secret-v1"
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
    secret_name = "qs-stg-ec1-dbms-secret-v1"
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
    secret_name = "qs-stg-ec1-integration-secret-v1"
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
    secret_name = "qs-stg-ec1-etl-secret-v1"
    secret_keys = {
      "DATABASE_URL"                = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "agentruntime" = {
    secret_name = "qs-stg-ec1-agent-runtime-secret-v1"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "scheduler" = {
    secret_name = "qs-stg-ec1-scheduler-secret-v1"
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
    secret_name = "qs-stg-ec1-app-secret-v2"
    secret_keys = {
      "NEXT_PUBLIC_DOMAIN"        = "octonomy"
      "NEXT_PUBLIC_SOCKET_DOMAIN" = "wss.octonomy"
    }
  }
  "ai-agent" = {
    secret_name = "qs-stg-ec1-ai-agent-secret-v2"
    secret_keys = {
      "RETRIVAL_AUTH_TOKEN" = ""
      "VOYAGE_API_KEY"      = ""
      "VOYAGE_RERANK_MODEL" = ""
    }
  }
  "librarian-assets" = {
    secret_name = "qs-stg-ec1-librarian-assets-secret-v1"
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
    secret_name = "qs-stg-ec1-librarian-retrieval-secret-v1"
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
    secret_name = "qs-stg-ec1-agent-runtime-secret-v3"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "librarian-migration" = {
    secret_name = "qs-stg-ec1-librarian-migration-secret-v1"
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
  "whg-api" = {
    secret_name = "qs-stg-ec1-whg-api-secret-v1"
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
  "whg-agent-runtime" = {
    secret_name = "qs-stg-ec1-whg-agent-runtime-secret-v3"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "stage-processor" = {
    secret_name = "qs-stg-ec1-stage-processor-secret-v3"
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
      Resource = ["arn:aws:kms:eu-central-1:180294192430:key/*"]
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
      Resource = ["arn:aws:sqs:eu-central-1:180294192430:*"]
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
    name         = "qs-stg-ec1-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
    ]
  }
  app = {
    name         = "qs-stg-ec1-app-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  dbms = {
    name         = "qs-stg-ec1-dbms-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  ai-agent = {
    name         = "qs-stg-ec1-ai-agent-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  agent-runtime = {
    name         = "qs-stg-ec1-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonBedrockFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
    ]
  }
  scheduler = {
    name         = "qs-stg-ec1-scheduler-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonEventBridgeSchedulerFullAccess",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  etl = {
    name         = "qs-stg-ec1-etl-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    ]
  }
  integration = {
    name         = "qs-stg-ec1-integration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonSESFullAccess"
    ]
  }
  lambda = {
    name         = "qs-stg-ec1-trigger-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::180294192430:policy/ecr-role-policy",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  eventbridge_scheduler = {
    name         = "qs-stg-ec1-scheduler-iam-role"
    type         = "Service"
    service_type = ["scheduler.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::180294192430:policy/Amazon-EventBridge-Scheduler-Execution-Policy-v1"
    ]
  }
  librarian-assets = {
    name         = "qs-stg-ec1-librarian-assets-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::180294192430:policy/AwsKms_v1"
    ]
  }
  librarian-retrieval = {
    name         = "qs-stg-ec1-librarian-retrieval-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    ]
  }
  whg-api = {
    name         = "qs-stg-ec1-whg-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
    ]
  }
  whg-agent-runtime = {
    name         = "qs-stg-ec1-whg-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
    ]
  }
  librarian-migration = {
    name         = "qs-stg-ec1-librarian-migration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
      "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
      "arn:aws:iam::180294192430:policy/AwsKms_v1"
    ]
  }
  lambda02 = {
    name         = "qs-stg-ec1-queue-handler-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::180294192430:policy/AmazonSSM-Policy-v1"
    ]
  }
  
  ingestion-queue-orchestrator = {
    name         = "qs-stg-ec1-ingestion-queue-orchestrator-ecs-iam-role"
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
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-llm = {
    name         = "qs-stg-ec1-ingestion-worker-llm-ecs-iam-role"
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
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-generic = {
    name         = "qs-stg-ec1-ingestion-worker-generic-ecs-iam-role"
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
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-pgvector-loader = {
    name         = "qs-stg-ec1-ingestion-worker-pgvector-loader-ecs-iam-role"
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
      "arn:aws:iam::180294192430:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
}

#################################
######## REDIS ########
#################################

redis_subnet = {
  subnet_group_01 = {
    name        = "qs-stg-ec1-redis-sne-grp"
    subnet_name = ["qs-stg-ec1-private-sne-redis-01a-v1"]
  }
}

# Redis Parameter Group
redis_params = {
  "param001" = {
    redis_pg_name   = "qs-stg-ec1-redis-pubsub-pg-v1"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "AKE"
    }]
  }
  "param002" = {
    redis_pg_name   = "qs-stg-ec1-redis-cache-pg-v1"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "Ex"
    }]
  }
  "param003" = {
    redis_pg_name   = "qs-stg-ec1-whg-redis-cache-pg-v1"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "Ex"
    }]
  }
}

redis = {
  "redis01" = {
    name                 = "qs-stg-ec1-redis-cache-v1"
    sneGroupName         = "qs-stg-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-stg-ec1-main-vpc-v1"
    parameter_group_name = "qs-stg-ec1-redis-cache-pg-v1"
    num_cache_clusters   = 1
    environment          = "stg"
  }
  "redis02" = {
    name                 = "qs-stg-ec1-redis-pubsub-v1"
    sneGroupName         = "qs-stg-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-stg-ec1-main-vpc-v1"
    parameter_group_name = "qs-stg-ec1-redis-pubsub-pg-v1"
    num_cache_clusters   = 1
    environment          = "stg"
  }
  "redis03" = {
    name                 = "qs-stg-ec1-whg-redis-cache-v1"
    sneGroupName         = "qs-stg-ec1-redis-sne-grp"
    size                 = "cache.t2.medium"
    vpc_name             = "qs-stg-ec1-main-vpc-v1"
    parameter_group_name = "qs-stg-ec1-whg-redis-cache-pg-v1"
    environment          = "stg"
  }
}

s3 = {
  "s30001" = {
    bucket_name             = "qs-stg-ec1-logos-s3-v1"
    block_all_public_access = true
  }
  "s30002" = {
    bucket_name             = "qs-stg-ec1-customer0001-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0001"
    tags = {
      "TenantID" = "Customer0001"
    }
  }
  "s30003" = {
    bucket_name             = "qs-stg-ec1-customer0002-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0002"
    tags = {
      "TenantID" = "Customer0002"
    }
  }
  "s30004" = {
    bucket_name             = "qs-stg-ec1-customer0003-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0003"
    tags = {
      "TenantID" = "Customer0003"
    }
  }
  "s30005" = {
    bucket_name             = "qs-stg-ec1-customer0004-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0004"
    tags = {
      "TenantID" = "Customer0004"
    }
  }
  "s30006" = {
    bucket_name             = "qs-stg-ec1-gluescript-s3-v1"
    block_all_public_access = true
  }
  "s30007" = {
    bucket_name             = "qs-stg-ec1-glue-library-dependency-s3-v1"
    block_all_public_access = true
  }
  "s30008" = {
    bucket_name             = "qs-stg-ec1-chatwidget-s3-v1"
    block_all_public_access = true
  }
  "s30009" = {
    bucket_name             = "qs-stg-ec1-demo-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "demo"
    tags = {
      "TenantID" = "Demo"
    }
  }
  "s30011" = {
    bucket_name             = "qs-stg-ec1-customer0006-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0006"
    tags = {
      "TenantID" = "Customer0006"
    }
  }
  "s30012" = {
    bucket_name             = "qs-stg-ec1-query-result-athena-s3-v1"
    block_all_public_access = true
  }
  "s30010" = {
    bucket_name             = "qs-stg-ec1-customer0005-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0005"
    tags = {
      "TenantID" = "Customer0005"
    }
  }
  "s30013" = {
    bucket_name             = "qs-stg-ec1-customer0007-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0007"
    tags = {
      "TenantID" = "Customer0007"
    }
  }
  "s30014" = {
    bucket_name             = "qs-stg-ec1-customer0008-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0008"
    tags = {
      "TenantID" = "Customer0008"
    }
  }
  "s30015" = {
    bucket_name             = "qs-stg-ec1-customer0009-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0009"
    tags = {
      "TenantID" = "customer0009"
    }
  }
  "s30017" = {
    bucket_name             = "qs-stg-ec1-cutomer0010-s3-v1"
    block_all_public_access = true
    tags = {
      "TenantID" = "Customer0010"
    }
  }
  "s30018" = {
    bucket_name             = "qs-stg-ec1-cutomer0011-s3-v1"
    block_all_public_access = true
    tags = {
      "TenantID" = "Customer0011"
    }
  }
  "s30019" = {
    bucket_name             = "qs-stg-ec1-fission-deployment-s3-v1"
    block_all_public_access = true
  }
  "s30020" = {
    bucket_name             = "qs-stg-ec1-customer0013-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0013"
    tags = {
      "TenantID" = "Customer0013"
    }
  }
  "s30021" = {
    bucket_name             = "qs-stg-ec1-customer0014-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0014"
    tags = {
      "TenantID" = "Customer0014"
    }
  }
  "s30022" = {
    bucket_name             = "qs-stg-ec1-cost-report-s3-v1"
    block_all_public_access = true
  }
  "s30023" = {
    bucket_name             = "qs-stg-ec1-customer0012-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0012"
    tags = {
      "TenantID" = "Customer0012"
    }
  }
  "s30024" = {
    bucket_name             = "qs-stg-ec1-customer0016-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0016"
    tags = {
      "TenantID" = "Customer0016"
    }
  }
  "s30025" = {
    bucket_name             = "qs-stg-ec1-customer0017-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0017"
    tags = {
      "TenantID" = "Customer0017"
    }
  }
  "s30026" = {
    bucket_name             = "qs-stg-ec1-customer0018-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0018"
    tags = {
      "TenantID" = "Customer0018"
    }
  }
  "s30027" = {
    bucket_name             = "qs-stg-ec1-customer0019-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0019"
    tags = {
      "TenantID" = "Customer0019"
    }
  }
  "s30028" = {
    bucket_name             = "qs-stg-ec1-customer0020-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0020"
    tags = {
      "TenantID" = "Customer0020"
    }
  }
  "s30029" = {
    bucket_name             = "qs-stg-ec1-shared-s3-v1"
    block_all_public_access = true
  }
  "s30030" = {
    bucket_name             = "qs-stg-ec1-customer0021-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0021"
    tags = {
      "TenantID" = "Customer0021"
    }
  }
  "s30031" = {
    bucket_name             = "qs-stg-ec1-customer0022-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0022"
    tags = {
      "TenantID" = "Customer0022"
    }
  }
  "s30032" = {
    bucket_name             = "qs-stg-ec1-customer0023-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0023"
    tags = {
      "TenantID" = "Customer0023"
    }
  }
  "s30033" = {
    bucket_name             = "qs-stg-ec1-customer0024-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0024"
    tags = {
      "TenantID" = "Customer0024"
    }
  }
  "s30034" = {
    bucket_name             = "qs-stg-ec1-customer0026-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0026"
    tags = {
      "TenantID" = "Customer0026"
    }
  }
  "s30035" = {
    bucket_name             = "qs-stg-ec1-customer0027-s3-v1"
    block_all_public_access = true
    kms_key_arn             = "customer0027"
    tags = {
      "TenantID" = "Customer0027"
    }
  }
  # Note: For next s3 bucket use s30036
}
# This is for custom policy
buckets = ["qs-stg-ec1-logos-s3-v1"]

s3_bucket_policy = {
  "qs-stg-ec1-logos-s3-v1" = {
    bucket_id = "qs-stg-ec1-logos-s3-v1"
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
          "Resource" : "arn:aws:s3:::qs-stg-ec1-logos-s3-v1/*",
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : "arn:aws:cloudfront::180294192430:distribution/E2Q9IKZB17WQ8A"
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
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0001-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0003-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0004-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0002-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
    environment = "stg"
    key_name    = "qs-stg-ec1-common-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
  "demo" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-demo-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "demo",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "Demo"
    }
  }
  "customer0006" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0006-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
  "customer0005" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0005-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
  "customer0007" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0007-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
  "customer0008" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0008-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0008"
    }
  }
  "customer0009" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0009-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0009",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0009"
    }
  }
  "customer0010" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0010-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0010"
    }
  }
  "customer0011" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0011-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0011",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0011"
    }
  }
  "customer0013" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0013-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0013"
    }
  }
  "customer0014" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0014-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0014"
    }
  }
  "customer0012" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0012-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0012"
    }
  }
  "customer0016" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0016-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0016"
    }
  }
  "customer0017" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0017-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0017",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0017"
    }
  }
  "customer0018" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0018-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0018"
    }
  }
  "customer0019" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0019-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0019",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0019"
    }
  }
  "customer0020" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0020-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0020"
    }
  }
  "customer0021" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0021-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0021",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0021"
    }
  }
  "customer0022" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0022-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0022"
    }
  }
  "customer0023" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0023-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0023",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0023"
    }
  }
  "customer0024" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0024-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0024",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0024"
    }
  }
  "customer0026" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0026-kms-v1"
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0026"
    }
  }
  "shared" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-shared-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "shared",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "shared"
    }
  }
  "customer0027" = {
    environment = "stg"
    key_name    = "qs-stg-ec1-customer0027-kms-v1"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "customer0027",
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
              "kms:CallerAccount" : "180294192430",
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
              "arn:aws:iam::180294192430:root",
              "arn:aws:iam::180294192430:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-STAGE-ETL_9579f9abd0b51102"
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
      "TenantID" = "customer0027"
    }
  }
}

#################################
########     RDS     ############
#################################

# RDS Parameter Group
rds_pg_name   = "qs-stg-ec1-rds-pg-v2"
rds_pg_family = "postgres16"
rds_pg_parameters = [
  {
    name  = "rds.force_ssl"
    value = "0"
  }
]

rds-new = {
  rds01 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "common"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.10"
    kms_key_arn              = "common"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
  }
  rds02 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0001"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0001"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0001"
    }
  }
  rds03 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0002"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0002"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0002"
    }
  }
  rds04 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0003"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0003"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0003"
    }
  }
  rds05 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0004"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0004"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0004"
    }
  }
  rds06 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "demo"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "demo"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Demo"
    }
  }
  # rds08 = {
  #   vpc_name                 = "qs-stg-ec1-main-vpc-v1"
  #   subnet_group_name        = "qs-stg-ec1-db-sne-grp"
  #   instance_name            = "customer0006"
  #   engine_version           = "16.10"
  #   instance_type            = "db.t4g.medium"
  #   kms_key_arn              = "customer0006"
  #   environment              = "stg"
  #   parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
  #   skip_final_snapshot      = true
  #   deletion_protection      = true
  #   delete_automated_backups = false
  #   tags = {
  #     "TenantID" = "Customer0006"
  #   }
  # }
  rds07 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0005"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0005"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0005"
    }
  }
  rds09 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0007"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0007"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "Customer0007"
    }
  }
  rds10 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0008"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0008"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0008"
    }
  }
  rds11 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0009"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0009"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0009"
    }
  }
  rds12 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0010"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0010"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0010"
    }
  }
  rds13 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0011"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0011"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0011"
    }
  }
  rds14 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0013"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0013"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0013"
    }
  }
  rds15 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0014"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0014"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0014"
    }
  }
  rds16 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0012"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0012"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    backup_retention_period  = 30
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0012"
    }
  }
  rds17 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0016"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0016"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0016"
    }
  }
  rds18 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0017"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0017"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0017"
    }
  }
  rds19 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0018"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0018"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0018"
    }
  }
  rds20 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0019"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0019"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0019"
    }
  }
  rds21 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0020"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0020"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0020"
    }
  }
  rds22 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0021"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    kms_key_arn              = "customer0021"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0021"
    }
  }
  rds23 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "customer0022"
    engine_version           = "16.10"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.6"
    kms_key_arn              = "customer0022"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0022"
    }
  }
  rds24 = {
    vpc_name          = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name = "qs-stg-ec1-db-sne-grp"
    instance_name     = "customer0023"
    #engine_version    = "16.10"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.6"
    kms_key_arn              = "customer0023"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0023"
    }
  }
  rds25 = {
    vpc_name          = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name = "qs-stg-ec1-db-sne-grp"
    instance_name     = "customer0024"
    #engine_version    = "16.10"
    instance_type            = "db.t4g.medium"
    engine_version           = "16.6"
    kms_key_arn              = "customer0024"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "customer0024"
    }
  }
  rds26 = {
    vpc_name                 = "qs-stg-ec1-main-vpc-v1"
    subnet_group_name        = "qs-stg-ec1-db-sne-grp"
    instance_name            = "shared"
    instance_type            = "db.t4g.2xlarge"
    engine_version           = "16.10"
    storage                  = 150
    max_storage              = 250
    kms_key_arn              = "shared"
    environment              = "stg"
    parameter_group_name     = "qs-stg-ec1-rds-pg-v2"
    skip_final_snapshot      = false
    deletion_protection      = true
    delete_automated_backups = false
    tags = {
      "TenantID" = "shared"
    }
  }
  # Note - For next RDS use rds27
}

sns_topics = {
  sns01 = {
    name = "qs-stg-ec1-sns-alert-v1"
  }
}

alarms = {
  "alarm0001" = {
    alarm_name                = "qs-stg-ec1-alarm-bastion-cpu-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Maximum"
    threshold                 = 80
    alarm_description         = "Alarm for EC2 instance CPU utilization"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    ec2_key                   = "Bastion_Host"
    dimensions = {
      InstanceId = "i-03f7b5f0c8d5e15fa"
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-stg-ec1-alarm-bastion-status-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    ec2_key                   = "Bastion_Host"
    actions_enabled           = true
    dimensions = {
      InstanceId = "i-03f7b5f0c8d5e15fa"
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-api-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "api"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-agent-runtime-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "agent-runtime"
    }
  }
  "alarm0007" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-app-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "app"
    }
  }
  "alarm0008" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-dbms-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "dbms"
    }
  }
  "alarm0009" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-etl-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "etl"
    }
  }
  "alarm0010" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-integration-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "integration"
    }
  }
  "alarm0011" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-scheduler-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "scheduler"
    }
  }
  "alarm0012" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-ai-agent-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "ai-agent"
    }
  }
  "alarm0026" = {
    alarm_name                = "qs-stg-ec1-alarm-alb-main-502-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0027" = {
    alarm_name                = "qs-stg-ec1-alarm-alb-main-503-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0028" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-librarian-assets-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "librarian-assets"
    }
  }
  "alarm0029" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-librarian-retrieval-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "librarian-retrieval"
    }
  }
  "alarm0030" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-whg-agent-runtime-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "whg-agent-runtime"
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-stg-ec1-alarm-ecs-whg-api-taskcount-v1"
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
    sns_name                  = "qs-stg-ec1-sns-alert-v1"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-stg-ec1-main-ecs-v3"
      ServiceName = "whg-api"
    }
  }
}
sns_topic_subscription = {
  snss01 = {
    sns_name = "qs-stg-ec1-sns-alert-v1"
    protocol = "email"
    endpoint = "octonomy.notification@talentship.io"
  }

}
rds_instance_id = "qs-stg-ec1-customer0001-rds-v1,qs-stg-ec1-customer0002-rds-v1,qs-stg-ec1-customer0003-rds-v1,qs-stg-ec1-customer0004-rds-v1,qs-stg-ec1-customer0005-rds-v1,qs-stg-ec1-demo-rds-v1,qs-stg-ec1-common-rds-v1,qs-stg-ec1-customer0008-rds-v1,qs-stg-ec1-customer0009-rds-v1,qs-stg-ec1-customer0010-rds-v,qs-stg-ec1-customer0011-rds-v1,qs-stg-ec1-customer0013-rds-v1,qs-stg-ec1-customer0014-rds-v1,qs-stg-ec1-customer0012-rds-v1,qs-stg-ec1-customer0016-rds-v1,qs-stg-ec1-customer0017-rds-v1,qs-stg-ec1-customer0018-rds-v1,qs-stg-ec1-customer0019-rds-v1,qs-stg-ec1-customer0020-rds-v1,qs-stg-ec1-customer0021-rds-v1,qs-stg-ec1-customer0022-rds-v1,qs-stg-ec1-customer0023-rds-v1,qs-stg-ec1-customer0024-rds-v1"

## Cloudfront ###
cf_origin_0001 = "qs-stg-ec1-logos-s3-v1.s3.eu-central-1.amazonaws.com"

# Resource Groups
resource_groups = {
  "customer0001" = {
    resource_group_name = "qs-stg-ec1-rg-customer0001"
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
    resource_group_name = "qs-stg-ec1-rg-customer0002"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0002"]
        }
      ]
    }
    EOT
  }
  "customer0003" = {
    resource_group_name = "qs-stg-ec1-rg-customer0003"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0003"]
        }
      ]
    }
    EOT
  }
  "customer0004" = {
    resource_group_name = "qs-stg-ec1-rg-customer0004"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0004"]
        }
      ]
    }
    EOT
  }
  "customer0005" = {
    resource_group_name = "qs-stg-ec1-rg-customer0005"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0005"]
        }
      ]
    }
    EOT
  }
  "customer0006" = {
    resource_group_name = "qs-stg-ec1-rg-customer0006"
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
  "demo" = {
    resource_group_name = "qs-stg-ec1-rg-demo"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Demo"]
        }
      ]
    }
    EOT
  }
  "customer0007" = {
    resource_group_name = "qs-stg-ec1-rg-customer0007"
    resource_query      = <<EOT
    {
      "ResourceTypeFilters": [
        "AWS::AllSupported"
      ],
      "TagFilters": [
        {
          "Key": "TenantID",
          "Values": ["Customer0007"]
        }
      ]
    }
    EOT
  }
}
DBInstanceIdentifier = ["qs-stg-ec1-customer0012-rds-v1", "qs-stg-ec1-shared-rds-v1"]

#################################
########      WAF    ############
#################################

addresses = [
  "14.97.127.46/32"
]

waf_acls = {
  cloudfront_main = {
    name            = "qs-stg-ec1-waf-cf-v1"
    scope           = "CLOUDFRONT"
    description     = "qs-stg-ec1-waf-cf-v2"
    waf_metric_name = "qs-stg-ec1-waf-cf-v1"
    log_group_name  = "aws-waf-logs-qs-v1"
    waf_rules = [
      {
        name                  = "qs-stg-ec1-rate-limiting-v1"
        priority              = 0
        statement_type        = "rate_based"
        rate_limit            = 1000
        evaluation_window_sec = 300
        aggregate_key_type    = "IP" # Fixed typo from 'aggregate_key_type'
        action                = "count"
        metric_name           = "qs-stg-ec1-rate-limiting-v1"
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
        name                     = "qs-stg-ec1-url-block-waf-rule"
        priority                 = 2
        statement_type           = "custom"
        statement_nested_type    = "and"
        byte_match_search_string = "/api/appconnect/docs"
        text_transformation_type = "NONE"
        country_codes            = ["IN"]
        action                   = "block"
        response_code            = 403
        custom_response_body_key = "403-response-page"
        metric_name              = "qs-stg-ec1-url-block-waf-rule"
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
        name           = "qs-stg-ec1-country-restrictions-allow-waf-rule"
        priority       = 3
        statement_type = "geo"
        country_codes = [
          "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
          "VA", "HU", "IS", "IN", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT", "MD", "MC", "ME", "NL",
          "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "UA", "GB", "US"
        ]
        action      = "allow"
        metric_name = "qs-stg-ec1-country-restrictions-allow-waf-rule"
      },
      {
        name           = "qs-stg-ec1-country-restrictions-block-waf-rule"
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
        metric_name              = "qs-stg-ec1-country-restrictions-block-waf-rule"
      },
      {
        name           = "qs-stg-ec1-country-restrictions-block-waf-rule-2"
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
        metric_name              = "qs-stg-ec1-country-restrictions-block-waf-rule-2"
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
ecs_cpu_utilization_period      = 60

cloudwatch_log_group = {
  cloudwatch0001 = {
    log_group_name    = "qs-stg-ec1-observability-agent-runtime"
    retention_in_days = 90
  }
  cloudwatch0002 = {
    log_group_name    = "qs-stg-ec1-observability-api"
    retention_in_days = 90
  }
}

private_buckets = ["qs-stg-ec1-customer0001-s3-v1", "qs-stg-ec1-customer0002-s3-v1", "qs-stg-ec1-customer0003-s3-v1", "qs-stg-ec1-customer0004-s3-v1", "qs-stg-ec1-customer0005-s3-v1", "qs-stg-ec1-customer0006-s3-v1", "qs-stg-ec1-customer0007-s3-v1", "qs-stg-ec1-customer0008-s3-v1", "qs-stg-ec1-customer0009-s3-v1", "qs-stg-ec1-cutomer0010-s3-v1", "qs-stg-ec1-cutomer0011-s3-v1", "qs-stg-ec1-customer0012-s3-v1", "qs-stg-ec1-customer0013-s3-v1", "qs-stg-ec1-customer0014-s3-v1"]

public_alb_subnet_ids = ["subnet-0e5d4f7f4d3b79142", "subnet-00ed864e77da973bc", "subnet-0b4aa48e376e3a476"]

private_alb_subnet_ids = ["subnet-0dd0e73378d08b981", "subnet-0acd07d91c1dc18c8", "subnet-000df3ba7222a5196"]

ecs_subnet_id = ["subnet-0912ba6641757d7d2"]

# PowerBI

ec2_subnet_id = "subnet-09550a5f0862ae67f"