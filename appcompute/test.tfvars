key = "test/terraform.tfstate"

app_version = "v2"

#################################
########     ROLE     ###########
#################################

role_arn = "arn:aws:iam::637423349055:role/terraform-role"

#################################
########     TAG     ############
#################################

tags = {
  "Project"     = "qs"
  "Environment" = "test"
  "Terraformed" = true
  "Version"     = "V2"
}


#################################
########     VPC     ############
#################################
vpc_name = "qs-test-ec1-main-vpc-v2"

cidr_block = "10.1.0.0/16"

public_subnets = [
  { cidr = "10.1.0.0/28", az = "eu-central-1a", Name = "qs-test-ec1-public-sne-nat-01a-v2", key = "subnet1" },      #NAT
  { cidr = "10.1.0.32/27", az = "eu-central-1a", Name = "qs-test-ec1-public-sne-alb-01a-v2", key = "subnet2" },     #ALB
  { cidr = "10.1.0.64/27", az = "eu-central-1b", Name = "qs-test-ec1-public-sne-alb-02b-v2", key = "subnet3" },     #ALB
  { cidr = "10.1.0.96/27", az = "eu-central-1c", Name = "qs-test-ec1-public-sne-alb-03c-v2", key = "subnet4" },     #ALB
  { cidr = "10.1.0.128/27", az = "eu-central-1a", Name = "qs-test-ec1-public-sne-nlb-01a-v2", key = "subnet5" },    #NLB
  { cidr = "10.1.0.160/27", az = "eu-central-1b", Name = "qs-test-ec1-public-sne-nlb-02b-v2", key = "subnet6" },    #NLB
  { cidr = "10.1.0.192/27", az = "eu-central-1c", Name = "qs-test-ec1-public-sne-nlb-03c-v2", key = "subnet7" },    #NLB
  { cidr = "10.1.0.224/28", az = "eu-central-1a", Name = "qs-test-ec1-public-sne-bastion-01a-v2", key = "subnet8" } #Bastion Host 

]

# Indicates index of the public subnet
nat_subnet_index = 0

# NAT Name
nat_name = "qs-test-ec1-nat-v2"

# Private Subnets
private_subnets = [
  { cidr = "10.1.1.0/24", az = "eu-central-1a", Name = "qs-test-ec1-private-sne-ecs-01a-v2", key = "subnet1" },     #ECS
  { cidr = "10.1.2.0/24", az = "eu-central-1a", Name = "qs-test-ec1-private-sne-rds-01a-v2", key = "subnet2" },     #RDS
  { cidr = "10.1.3.0/24", az = "eu-central-1b", Name = "qs-test-ec1-private-sne-rds-02b-v2", key = "subnet3" },     #RDS
  { cidr = "10.1.4.0/24", az = "eu-central-1c", Name = "qs-test-ec1-private-sne-rds-03c-v2", key = "subnet4" },     #RDS
  { cidr = "10.1.5.0/27", az = "eu-central-1a", Name = "qs-test-ec1-private-sne-lambda-01a-v2", key = "subnet5" },  #Lambda
  { cidr = "10.1.6.0/24", az = "eu-central-1b", Name = "qs-test-ec1-private-sne-neo4j-01b-v2", key = "subnet6" },   #Neo4j
  { cidr = "10.1.7.0/27", az = "eu-central-1a", Name = "qs-test-ec1-private-sne-ilb-01a-v2", key = "subnet7" },     #ILB
  { cidr = "10.1.7.32/27", az = "eu-central-1b", Name = "qs-test-ec1-private-sne-ilb-02b-v2", key = "subnet8" },    #ILB
  { cidr = "10.1.7.64/27", az = "eu-central-1c", Name = "qs-test-ec1-private-sne-ilb-03c-v2", key = "subnet9" },    #ILB
  { cidr = "10.1.7.96/28", az = "eu-central-1a", Name = "qs-test-ec1-private-sne-redis-01a-v2", key = "subnet10" }, #Redis
  { cidr = "10.1.8.0/24", az = "eu-central-1a", Name = "qs-test-ec1-private-sne-glue-01a-v2", key = "subnet10" }    #Glue
]
vpc_tags = {
  "Name"        = "qs-test-ec1-main-vpc-v2"
  "Project"     = "qs"
  "Environment" = "test"
  "Terraformed" = true
  "Version"     = "V2"
}

#################################
########     EC2     ############
#################################

# Define the environment (e.g., "production", "dev", "test")
environment = "test"

# Define EC2 instances
instances = {
  Bastion_Host = {
    ami               = "ami-0e04bcbe83a83792e"
    ssh_pub_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCZfhnSyAz7Nnv7SxQ/ApOWHv3Wt1TE7dYCgz/InC23EHiKCLCrp5j07AipUmeCXTQa93I+zfe2bj53XfF9ItR/aQIBrDt6Hh9Dn+RuzBhTAW5YuMZfsPBINbjKvLaVPP1Q2/ZAVbq+IqsB9IQb+UYC/FvK94Cc/wDLOZLjFBJU0+jJSD0jdztCjp/aiNjeK3cf7gt8PPp+ZGKHzxhZW1SpYpbVCRO/9TtI36qH9dFVHC8JkcrO8Q2FzcfNhgxKPx0Z7IkmmhRS4B2Cplkp42L6sd4bK+iLXv9griHhtO1RTch4sVSzshgm0Ttvwxv8cQt6sXL4KMHfRIL8VMx+VAKXvfXEAd8uHq+OhgiAOvpdmfVQ2TemCfCDFanJ4MisbLsMLXoqvHpYSa/Jfu7NbDoV3XvqKijgzj3dV/IhLlvIwowYRE3APoWClw+AV3acTJ4FwOwew5evBT29w7vbJ7aVf4Qx4vYASSXxQAoLKEOqzf5Eksdwvy1KkXei9gM3HvrYkfvtwfGqpBKVXeICR4J5g6yUIqC3n39CHrxhyXjcUPDSexEsTHsRDUEFR6MDfg6y7aXWFd8utCgIrnNmB4S7EzBqiCpdT15d2aYqE5tvIbBenFvAXq0SPePKUZX5zxW+vTxkaKMZStQ47qsH+8VUOSFiyofkg9f/GcFYzgn5zw== bastion_host_test"
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
    vpc_name          = "qs-test-ec1-main-vpc-v2"
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
        description     = "EC2 instance connect"
      }
    }
  }
  # talentship = {
  #   ami                  = "ami-0e04bcbe83a83792e"
  #   ssh_pub_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCZfhnSyAz7Nnv7SxQ/ApOWHv3Wt1TE7dYCgz/InC23EHiKCLCrp5j07AipUmeCXTQa93I+zfe2bj53XfF9ItR/aQIBrDt6Hh9Dn+RuzBhTAW5YuMZfsPBINbjKvLaVPP1Q2/ZAVbq+IqsB9IQb+UYC/FvK94Cc/wDLOZLjFBJU0+jJSD0jdztCjp/aiNjeK3cf7gt8PPp+ZGKHzxhZW1SpYpbVCRO/9TtI36qH9dFVHC8JkcrO8Q2FzcfNhgxKPx0Z7IkmmhRS4B2Cplkp42L6sd4bK+iLXv9griHhtO1RTch4sVSzshgm0Ttvwxv8cQt6sXL4KMHfRIL8VMx+VAKXvfXEAd8uHq+OhgiAOvpdmfVQ2TemCfCDFanJ4MisbLsMLXoqvHpYSa/Jfu7NbDoV3XvqKijgzj3dV/IhLlvIwowYRE3APoWClw+AV3acTJ4FwOwew5evBT29w7vbJ7aVf4Qx4vYASSXxQAoLKEOqzf5Eksdwvy1KkXei9gM3HvrYkfvtwfGqpBKVXeICR4J5g6yUIqC3n39CHrxhyXjcUPDSexEsTHsRDUEFR6MDfg6y7aXWFd8utCgIrnNmB4S7EzBqiCpdT15d2aYqE5tvIbBenFvAXq0SPePKUZX5zxW+vTxkaKMZStQ47qsH+8VUOSFiyofkg9f/GcFYzgn5zw== bastion_host_test"
  #   instance_type        = "t2.large"
  #   name                 = "neo4j-customer0001"
  #   availability_zone    = "eu-central-1b"
  #   disk_size            = 20
  #   stop_protection      = false
  #   delete_protection    = false
  #   use_user_data        = true
  #   user_data_script     = "user-data.sh"
  #   subnet_type          = "private"
  #   subnet_index         = 5
  #   vpc_name             = "qs-test-ec1-main-vpc-v2"
  #   eip                  = false
  #   ebs                  = true
  #   secret               = true
  #   kms_key_arn          = "customer0001"
  #   security_group_names = ["qs-test-ec1-rds-nsg-test"]
  #   ingress_ports        = [7687]
  #   ingress = {
  #     sshoffice = {
  #       from_port       = 22
  #       to_port         = 22
  #       protocol        = "tcp"
  #       cidr_blocks     = ["14.97.127.46/32"] # Example of a specific IP range
  #       security_groups = []
  #       description     = "office ssh"
  #     }
  #   }
  # }
}

#################################
### APPLICATION LOAD BALANCER ###
#################################

ecs_cluster_name          = "qs-test-ec1-main-ecs-v2"
enable_container_insights = true

alb_security_group     = "qs-test-ec1-alb-nsg"
ilb_security_group     = "qs-test-ec1-ilb-nsg"
wss_alb_security_group = "test-qs-nsg-wss-alb-01"

lb = {
  "alb" = {
    lb_enable_deletion_protection = false
    lb_name                       = "qs-test-ec1-main-alb-v2"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-test-ec1-main-vpc-v2"
    lb_subnets_name               = ["qs-test-ec1-public-sne-alb-01a-v2", "qs-test-ec1-public-sne-alb-02b-v2", "qs-test-ec1-public-sne-alb-03c-v2"]
    security_group_name           = "qs-test-ec1-alb-nsg"
    lb_idle_timeout               = 60
    lb_client_keep_alive          = 3600
    is_internal_lb                = false
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-test-ec1-main-alb-logs"
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
        certificate_domain = "*.test.octonomy.ai"
        hosted_zone        = "test.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          Api = {
            tags         = { "Name" = "API" }
            priority     = 20
            action_type  = "forward"
            host_header  = ["*.test.octonomy.ai"]
            path_pattern = ["/api/appconnect/*"]
            forward = {
              target_group_name = "qs-test-api-alb"
            }
          }
          App = {
            tags        = { "Name" = "APP" }
            priority    = 21
            action_type = "forward"
            host_header = ["*.test.octonomy.ai"]
            forward = {
              target_group_name = "qs-test-app-alb"
            }
          }
          AI-Agent = {
            tags        = { "Name" = "AI-Agent" }
            priority    = 10
            action_type = "forward"
            host_header = ["ai-agent.test.octonomy.ai"]
            forward = {
              target_group_name = "qs-test-ai-agent-alb"
            }
          }
          librarian-assets = {
            tags        = { "Name" = "Librarian-assets" }
            priority    = 11
            action_type = "forward"
            host_header = ["*.test.assets.octonomy.ai"]
            forward = {
              target_group_name = "qs-test-librarian-assets-alb"
            }
          }
        }
      }
    }
    target_groups = {
      ai-agent = {
        name                 = "qs-test-ai-agent-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-api-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-app-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-librarian-assets-alb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
    lb_name                       = "qs-test-ec1-main-ilb-v2"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-test-ec1-main-vpc-v2"
    lb_subnets_name               = ["qs-test-ec1-private-sne-ilb-01a-v2", "qs-test-ec1-private-sne-ilb-02b-v2", "qs-test-ec1-private-sne-ilb-03c-v2"]
    security_group_name           = "qs-test-ec1-ilb-nsg"
    is_internal_lb                = true
    lb_idle_timeout               = 300
    lb_client_keep_alive          = 3600
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-test-ec1-main-ilb-alb-logs"
    listeners = {
      internallistener80 = {
        port           = 80
        protocol       = "HTTP"
        default_action = "forward"
        forward = {
          target_group_name = "qs-test-scheduler-ilb"
        }
      }
      internallistener443 = {
        port               = 443
        protocol           = "HTTPS"
        ssl_policy         = "ELBSecurityPolicy-2016-08"
        certificate_domain = "*.internal.test.octonomy.ai"
        hosted_zone        = "internal.test.octonomy.ai"
        is_private_zone    = false
        default_action     = "forward"
        forward = {
          target_group_name = "qs-test-scheduler-ilb"
        }
        rules = {
          internal-scheduler = {
            tags         = { "Name" = "scheduler" }
            priority     = 2
            action_type  = "forward"
            path_pattern = ["/scheduler/*"]
            forward = {
              target_group_name = "qs-test-scheduler-ilb"
            }
          }
          internal-dbms = {
            tags         = { "Name" = "dbms" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/dbms/*"]
            forward = {
              target_group_name = "qs-test-dbms-ilb"
            }
          }
          internal-etl = {
            tags         = { "Name" = "etl" }
            priority     = 3
            action_type  = "forward"
            path_pattern = ["/etl/*"]
            forward = {
              target_group_name = "qs-test-etl-ilb"
            }
          }
          internal-integration = {
            tags         = { "Name" = "integration" }
            priority     = 4
            action_type  = "forward"
            path_pattern = ["/integration/*"]
            forward = {
              target_group_name = "qs-test-integration-ilb"
            }
          }
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 5
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*"]
            forward = {
              target_group_name = "qs-test-agent-runtime-ilb"
            }
          }
          librarian-retrieval = {
            tags         = { "Name" = "Librarian-Retrieval" }
            priority     = 6
            action_type  = "forward"
            path_pattern = ["/librarian/*"]
            forward = {
              target_group_name = "qs-test-librarian-retrieval-ilb"
            }
          }
        }
      }
    }
    target_groups = {
      internal-dbms = {
        name                 = "qs-test-dbms-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-scheduler-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-etl-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-integration-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-agent-runtime-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
        name                 = "qs-test-librarian-retrieval-ilb"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
    lb_name                       = "qs-test-ec1-wss-alb-v2"
    lb_type                       = "application"
    is_nlb                        = false
    vpc_name                      = "qs-test-ec1-main-vpc-v2"
    lb_subnets_name               = ["qs-test-ec1-public-sne-alb-01a-v2", "qs-test-ec1-public-sne-alb-02b-v2", "qs-test-ec1-public-sne-alb-03c-v2"]
    security_group_name           = "test-qs-nsg-wss-alb-01"
    is_internal_lb                = false
    lb_idle_timeout               = 1800
    lb_client_keep_alive          = 1800
    enable_access_logs            = true
    alb_s3_log_bucket_name        = "qs-test-ec1-wss-alb-logs"
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
        certificate_domain = "*.test.wss.octonomy.ai"
        hosted_zone        = "test.wss.octonomy.ai"
        is_private_zone    = false
        default_action     = "fixed-response"
        rules = {
          agent-runtime = {
            tags         = { "Name" = "agent-runtime" }
            priority     = 1
            action_type  = "forward"
            path_pattern = ["/agent-runtime/*", "/socket.io/*"]
            host_header  = ["*.test.wss.octonomy.ai"]
            forward = {
              target_group_name = "test-qs-tg-alb-agent-runtime-v2"
            }
          }
          # x-agent-runtime = {
          #   tags        = { "Name" = "2-agent-runtime" }
          #   priority    = 2
          #   action_type = "forward"
          #   path_pattern = ["/agent-runtime/*", "/socket.io/*"]
          #   host_header = ["*.test.wss.octonomy.ai"]
          #   http_header = ["widget"]
          #   forward = {
          #     target_group_name = "test-qs-tg-alb-agentruntime-2-v2"
          #   }
          # }
        }
      }
    }
    target_groups = {
      agent-runtime = {
        name                 = "test-qs-tg-alb-agent-runtime-v2"
        target_type          = "ip"
        protocol             = "HTTP"
        port                 = 80
        deregistration_delay = 5
        vpc_name             = "qs-test-ec1-main-vpc-v2"
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
      #   name                 = "test-qs-tg-alb-agentruntime-2-v2"
      #   target_type          = "ip"
      #   protocol             = "HTTP"
      #   port                 = 80
      #   deregistration_delay = 5
      #   vpc_name             = "qs-test-ec1-main-vpc-v2"
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
    family                 = "qs-test-ec1-api-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-api-alb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 512
    memory_task_definition = 1024
    log_group_name         = "qs-test-ec1-api-ecs"
    ingress_port           = 3001
    secret_manager_name    = "qs-test-api"
    secrets                = ["DATABASE_URL"]
    execution_role_name    = "qs-test-ec1-api-ecs-iam-role"
    task_role_name         = "qs-test-ec1-api-ecs-iam-role"
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "UNIFIED_ENV", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_S3_BUCKET_NAME", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AGENT_RUNTIME_SERVICE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "DBMS_SERVICE_URL", "JWT_SECRET", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "AWS_CDN_URL", "VAPI_API_KEY", "VAPI_API_ENDPOINT", "VAPI_CUSTOMER_KEY", "WEBHOOK_WORKER_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER", "DEEPGRAM_API_KEY", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT"]
    secret_manager_arn     = "qs-test-ec1-api-secret-v2"
    logs_stream_prefix     = "qs-test-ec1-api-ecs"
    container_name         = "qs-test-ec1-api-ecs"
    container_port         = 3001
    host_port              = 3001
    cpu                    = 512
    memory                 = 1024
    security_group_names   = ["qs-test-ec1-alb-nsg"]
  }
  app = {
    ecs_name               = "app"
    family                 = "qs-test-ec1-app-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-app-alb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-test-ec1-app-ecs"
    execution_role_name    = "qs-test-ec1-app-ecs-iam-role"
    task_role_name         = "qs-test-ec1-app-ecs-iam-role"
    ingress_port           = 3000
    secrets                = ["NEXT_PUBLIC_DOMAIN", "NEXT_PUBLIC_SOCKET_DOMAIN", "NEXT_PUBLIC_ASSETS_BASE_URL"]
    secret_manager_arn     = "qs-test-ec1-app-secret-v2"

    container_name = "qs-test-ec1-app-ecs"

    container_port       = 3000
    host_port            = 3000
    cpu                  = 2048
    memory               = 4096
    security_group_names = ["qs-test-ec1-alb-nsg"]
  }
  dbms = {
    ecs_name               = "dbms"
    family                 = "qs-test-ec1-dbms-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-dbms-ilb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = false
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-test-ec1-dbms-ecs"
    ingress_port           = 3002
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "ALLOWED_PREFIXES", "DBMS_AUTH_TOKEN", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL_ETL", "SHADOW_DATABASE_URL_ETL", "AGENT_RUNTIME_SERVICE_URL", "INTEGRATION_SERVICE_URL", "SCH_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "AI_AGENT_AUTH_TOKEN"]
    secret_manager_arn     = "qs-test-ec1-dbms-secret-v2"
    container_name         = "qs-test-ec1-dbms-ecs"
    secret_manager_name    = "qs-test-dbms"
    # secrets             = ["PORT"]
    container_port       = 3002
    host_port            = 3002
    cpu                  = 2048
    memory               = 4096
    execution_role_name  = "qs-test-ec1-dbms-ecs-iam-role"
    task_role_name       = "qs-test-ec1-dbms-ecs-iam-role"
    security_group_names = ["qs-test-ec1-ilb-nsg"]
  }
  ai-agent = {
    ecs_name               = "ai-agent"
    family                 = "qs-test-ec1-ai-agent-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-ai-agent-alb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-test-ec1-ai-agent-ecs"
    ingress_port           = 80

    container_name       = "qs-test-ec1-ai-agent-ecs"
    container_port       = 80
    host_port            = 80
    cpu                  = 256
    memory               = 512
    execution_role_name  = "qs-test-ec1-ai-agent-ecs-iam-role"
    task_role_name       = "qs-test-ec1-ai-agent-ecs-iam-role"
    security_group_names = ["qs-test-ec1-alb-nsg"]
  }
  scheduler = {
    ecs_name               = "scheduler"
    family                 = "qs-test-ec1-scheduler-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-scheduler-ilb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-test-ec1-scheduler-ecs"
    ingress_port           = 3003
    secrets                = ["NODE_ENV", "AWS_REGION", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "COGNITO_WORKER_SQS_QUEUE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "COGNITO_USER_SYNC_SQS_QUEUE_URL", "COGNITO_PARTIAL_USER_SYNC_SQS_QUEUE_URL", "DEFAULT_SCHEDULER_ROLE_ARN", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "NEO4J_URL_CUSTOMER", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "CLUSTER_MANAGER_ETL_ENABLED", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "FULL_LOAD_SQS_QUEUE_URL", "INCREMENTAL_LOAD_SQS_QUEUE_URL", "DBMS_SERVICE_URL", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "EVALUATION_SQS_QUEUE_URL", "WEBHOOK_WORKER_SQS_QUEUE_URL"]
    secret_manager_arn     = "qs-test-ec1-scheduler-secret-v2"
    container_name         = "qs-test-ec1-scheduler-ecs"
    container_port         = 3003
    host_port              = 3003
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-test-ec1-scheduler-ecs-iam-role"
    task_role_name         = "qs-test-ec1-scheduler-ecs-iam-role"
    security_group_names   = ["qs-test-ec1-ilb-nsg"]
  }
  agent-runtime = {
    ecs_name               = "agent-runtime"
    family                 = "qs-test-ec1-agent-runtime-ecs"
    desired_count          = 2
    target_group_name      = ["test-qs-tg-alb-agent-runtime-v2", "qs-test-agent-runtime-ilb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-test-ec1-agent-runtime-ecs"
    ingress_port           = 3006
    secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "AWS_SQS_BASE_URL", "PROMPT_PROCESS_CLUSTER_QUEUE", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "LAUNCHDARKLY_SDK_KEY", "FEATURE_FLAG_SERVICE_PROVIDER"]
    secret_manager_arn     = "qs-test-ec1-agent-runtime-secret-v2"
    container_name         = "qs-test-ec1-agent-runtime-ecs"
    container_port         = 3006
    host_port              = 3006
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-test-ec1-agent-runtime-ecs-iam-role"
    task_role_name         = "qs-test-ec1-agent-runtime-ecs-iam-role"
    security_group_names   = ["test-qs-nsg-wss-alb-01", "qs-test-ec1-ilb-nsg"]
  }
  etl = {
    ecs_name               = "etl"
    family                 = "qs-test-ec1-etl-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-etl-ilb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-test-ec1-etl-ecs"
    ingress_port           = 3004
    secrets                = ["DATABASE_URL", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "PORT", "ETL_AUTH_TOKEN", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "INTEG_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL"]
    secret_manager_arn     = "qs-test-ec1-etl-secret-v2"
    container_name         = "qs-test-ec1-etl-ecs"
    container_port         = 3004
    host_port              = 3004
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-test-ec1-etl-ecs-iam-role"
    task_role_name         = "qs-test-ec1-etl-ecs-iam-role"
    security_group_names   = ["qs-test-ec1-ilb-nsg"]
  }
  integration = {
    ecs_name               = "integration"
    family                 = "qs-test-ec1-integration-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-integration-ilb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 2048
    memory_task_definition = 4096
    log_group_name         = "qs-test-ec1-integration-ecs"
    ingress_port           = 3005
    secrets                = ["ENCRYPTION_KEY", "UNIFIED_API_KEY", "UNIFIED_WORKSPACE_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "UNIFIED_ENDPOINT", "NODE_ENV", "AWS_REGION", "AWS_S3_BUCKET_NAME", "PORT", "UNIFIED_ENV", "APP_CONFIG_APPLICATION", "APP_CONFIG_ENVIRONMENT", "APP_CONFIG_CONFIGURATION", "ETL_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "CONFLUENCE_CONNECTION_ID", "ATLASSIAN_BASE_URL", "CONFLUENCE_BASE_URL", "CONFLUENCE_AUTH_TOKEN", "S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_DB_PASSWORD", "OPENAI_API_BASE_URL", "ANTHROPIC_API_BASE_URL", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "ALLOWED_PREFIXES", "PG_DB_HOST", "PG_DB_PORT", "PG_DB_USERNAME", "PG_DB_PASSWORD", "PG_DB_NAME", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AGENT_RUNTIME_SERVICE_URL", "DHL_API_BASE_URL", "GOKARLA_BASE_URL", "VAPI_API_ENDPOINT", "REDIS_CACHE_PORT", "REDIS_CACHE_HOST"]
    secret_manager_arn     = "qs-test-ec1-integration-secret-v2"
    container_name         = "qs-test-ec1-integration-ecs"
    container_port         = 3005
    host_port              = 3005
    cpu                    = 2048
    memory                 = 4096
    execution_role_name    = "qs-test-ec1-integration-ecs-iam-role"
    task_role_name         = "qs-test-ec1-integration-ecs-iam-role"
    security_group_names   = ["qs-test-ec1-ilb-nsg"]
  }
  librarian-retrieval = {
    ecs_name               = "librarian-retrieval"
    family                 = "qs-test-ec1-librarian-retrieval-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-librarian-retrieval-ilb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-test-ec1-librarian-retrieval-ecs"
    ingress_port           = 9098
    secrets                = ["DATABASE_URL", "OPENAI_API_KEY", "VOYAGE_API_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "COMMON_DATABASE_URL", "VOYAGEAI_API_URL"]
    secret_manager_arn     = "qs-test-ec1-librarian-retrieval-secret-v2"
    container_name         = "qs-test-ec1-librarian-ecs"
    container_port         = 9098
    host_port              = 9098
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-test-ec1-librarian-retrieval-ecs-iam-role"
    task_role_name         = "qs-test-ec1-librarian-retrieval-ecs-iam-role"
    security_group_names   = ["qs-test-ec1-ilb-nsg"]
  }
  librarian-assets = {
    ecs_name               = "librarian-assets"
    family                 = "qs-test-ec1-librarian-assets-ecs"
    desired_count          = 0
    target_group_name      = ["qs-test-librarian-assets-alb"]
    subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
    enable_execute_command = true
    cpu_task_definition    = 256
    memory_task_definition = 512
    log_group_name         = "qs-test-ec1-librarian-assets-ecs"
    ingress_port           = 9099
    secrets                = ["DATABASE_URL", "OPENAI_API_KEY", "VOYAGE_API_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "COMMON_DATABASE_URL", "VOYAGEAI_API_URL", "SERVICE_NAME", "CUSTOM_ACCESS_TOKEN_SECRET_KEY"]
    secret_manager_arn     = "qs-test-ec1-librarian-assets-secret-v2"
    container_name         = "qs-test-ec1-librarian-assets-ecs"
    container_port         = 9099
    host_port              = 9099
    cpu                    = 256
    memory                 = 512
    execution_role_name    = "qs-test-ec1-librarian-assets-ecs-iam-role"
    task_role_name         = "qs-test-ec1-librarian-assets-ecs-iam-role"
    security_group_names   = ["qs-test-ec1-alb-nsg"]
  }
  # x-agent-runtime = {
  #   ecs_name               = "2-agent-runtime"
  #   family                 = "qs-test-ec1-agent-runtime-ecs"
  #   desired_count          = 0
  #   target_group_name      = ["test-qs-tg-alb-agentruntime-2-v2"]
  #   subnets                = ["qs-test-ec1-private-sne-ecs-01a-v2"]
  #   enable_execute_command = true
  #   cpu_task_definition    = 2048
  #   memory_task_definition = 4096
  #   log_group_name         = "qs-test-ec1-2-agent-runtime-ecs"
  #   ingress_port           = 3006
  #   secrets                = ["REDIS_HOST", "REDIS_PORT", "DATABASE_URL", "ALLOWED_PREFIXES", "SCH_AUTH_TOKEN", "DBMS_AUTH_TOKEN", "INTEG_AUTH_TOKEN", "AGRUN_AUTH_TOKEN", "OPENAI_API_KEY", "PROMPT_PROCESS_SQS_QUEUE_URL", "ENCRYPTION_KEY", "ETL_SERVICE_URL", "SCHEDULER_SERVICE_URL", "INTEGRATION_SERVICE_URL", "ETL_AUTH_TOKEN", "DBMS_SERVICE_URL", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "JWT_SECRET", "ALLOWED_ORIGIN", "VOYAGE_BASE_URL"]
  #   secret_manager_arn     = "qs-test-ec1-2-agent-runtime-secret-v2"
  #   container_name         = "qs-test-ec1-agent-runtime-ecs"
  #   container_port         = 3006
  #   host_port              = 3006
  #   cpu                    = 2048
  #   memory                 = 4096
  #   execution_role_name    = "qs-test-ec1-2-agent-runtime-ecs-iam-role"
  #   task_role_name         = "qs-test-ec1-2-agent-runtime-ecs-iam-role"
  #   security_group_names   = ["test-qs-nsg-wss-alb-01"]
  # }
}

#################################
######## DB SUBNET GROUP ########
#################################

dbsubnet = {
  subnet_group_01 = {
    name        = "qs-test-ec1-db-sne-grp"
    subnet_name = ["qs-test-ec1-private-sne-rds-01a-v2", "qs-test-ec1-private-sne-rds-02b-v2", "qs-test-ec1-private-sne-rds-03c-v2"]
  }
}

#################################
########     LAMBDA   ###########
#################################

# Lamda
lambda = {
  lambda01 = {
    function_name = "qs-test-ec1-post-signup-trigger-lambda-v2"
    role_name     = "qs-test-ec1-trigger-lambda-iam-role"
    variables = {
      DB_DATA_MIGRATION_SQS_QUEUE_URL = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-cognito-user-sync-sqs-v2"
    }
  }
}

#################################
########     SQS     ############
#################################

sqs = {
  sqs001 = {
    name = "qs-test-ec1-cognito-user-partial-sync-sqs-v2"
  }
  sqs002 = {
    name = "qs-test-ec1-cognito-user-sync-sqs-v2"
  }
  sqs003 = {
    name = "qs-test-ec1-db-data-migration-sqs-v2"
  }
  sqs004 = {
    name = "qs-test-ec1-prompt-process-sqs-v2"
  }
  sqs005 = {
    name = "qs-test-ec1-prompt-process-sqs-v1"
  }
  sqs006 = {
    name = "qs-test-ec1-prompt-process-sqs-v3"
  }
  sqs007 = {
    name = "qs-test-ec1-prompt-process-sqs-v4"
  }
  sqs008 = {
    name = "qs-test-ec1-cr-data-loader-sqs-v2"
  }
  sqs0009 = {
    name = "qs-test-ec1-whg-prompt-process-sqs-v1"
  }
  sqs0010 = {
    name = "qs-test-ec1-whg-prompt-process-sqs-v2"
  }
  sqs0011 = {
    name = "qs-test-ec1-whg-prompt-process-sqs-v3"
  }
  sqs0012 = {
    name = "qs-test-ec1-whg-prompt-process-sqs-v4"
  }
  sqs0013 = {
    name = "qs-test-ec1-whg-webhook-process-sqs-v1"
  }
  sqs0014 = {
    name = "qs-test-ec1-db-schema-migration-sqs-v2"
  }
  sqs0015 = {
    name = "qs-test-ec1-librarian-kb-migrations-sqs-v2"
  }
  sqs0016 = {
    name = "qs-test-ec1-conversation-timeout-sqs-v1"
  }
}

#################################
########  schedulers ############
#################################

schedulers = [
  {
    name                         = "qs-test-ec1-customer0001-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0001"
    job_id                       = "1"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 1
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-test-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-test-ec1-scheduler-iam-role"
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
    name                         = "qs-test-ec1-customer0002-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0002 "
    job_id                       = "2"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 2
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-test-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-test-ec1-scheduler-iam-role"
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
    name                         = "qs-test-ec1-customer0003-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0003 "
    job_id                       = "3"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 3
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-test-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-test-ec1-scheduler-iam-role"
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
    name                         = "qs-test-ec1-customer0004-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0004"
    job_id                       = "4"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 4
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-test-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-test-ec1-scheduler-iam-role"
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
    name                         = "qs-test-ec1-customer0006-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0006"
    job_id                       = "5"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 5
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-test-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-test-ec1-scheduler-iam-role"
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
    name                         = "qs-test-ec1-customer0012-cognito-user-sync-job-schedule-v2"
    description                  = "Sync job for customer0012"
    job_id                       = "6"
    job_type                     = "COGNITO_USER_SYNC"
    tenant_id                    = 6
    schedule_expression          = "rate(10 minutes)"
    group_name                   = "default"
    sqs_name                     = "qs-test-ec1-cognito-user-sync-sqs-v2"
    execution_role               = "qs-test-ec1-scheduler-iam-role"
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
  "appconfig001" = {
    app_name = "qs-test-ec1-app-appconfig-v2"
    tags = {
      "Project"     = "qs"
      "Environment" = "test"
      "Terraformed" = true
      "Version"     = "V2"
    }
    environment = {
      "test" = {
        name        = "test"
        description = "test environment"
        tags = {
          "Project"     = "qs"
          "Environment" = "test"
          "Terraformed" = true
          "Version"     = "V2"
        }
      }
    }
    config = {
      "config1" = {
        name        = "qs-test-ec1-app-appconfig-feature-v2"
        description = "Primary configuration"
        tags = {
          "Project"     = "qs"
          "Environment" = "test"
          "Terraformed" = true
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
    secret_name = "qs-test-ec1-api-secret-v2"
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
    secret_name = "qs-test-ec1-dbms-secret-v2"
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
    secret_name = "qs-test-ec1-integration-secret-v2"
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
    secret_name = "qs-test-ec1-etl-secret-v2"
    secret_keys = {
      "DATABASE_URL"                = ""
      "CLUSTER_MANAGER_ETL_ENABLED" = ""
      "ETL_SERVICE_URL"             = ""
      "SCHEDULER_SERVICE_URL"       = ""
      "INTEGRATION_SERVICE_URL"     = ""
    }
  }
  "agentruntime" = {
    secret_name = "qs-test-ec1-agent-runtime-secret-v2"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "scheduler" = {
    secret_name = "qs-test-ec1-scheduler-secret-v2"
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
      "EVALUATION_SQS_QUEUE_URL"                = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-full-load-sqs-v2"
    }
  }
  "app" = {
    secret_name = "qs-test-ec1-app-secret-v2"
    secret_keys = {
      "NEXT_PUBLIC_DOMAIN"        = "octonomy"
      "NEXT_PUBLIC_SOCKET_DOMAIN" = "wss.octonomy"
    }
  }
  "librarian-retrieval" = {
    secret_name = "qs-test-ec1-librarian-retrieval-secret-v2"
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
  "librarian-assets" = {
    secret_name = "qs-test-ec1-librarian-assets-secret-v2"
    secret_keys = {
      "DATABASE_URL"                   = ""
      "OPENAI_API_KEY"                 = ""
      "VOYAGE_API_KEY"                 = ""
      "ENV"                            = ""
      "LIBRARIAN_AUTH_TOKEN"           = ""
      "COMMON_DATABASE_URL"            = ""
      "VOYAGEAI_API_URL"               = ""
      "CUSTOM_ACCESS_TOKEN_SECRET_KEY" = ""
    }
  }
  "agent-runtime" = {
    secret_name = "qs-test-ec1-agent-runtime-secret-v3"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "whg-api" = {
    secret_name = "qs-test-ec1-whg-api-secret-v3"
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
    secret_name = "qs-test-ec1-whg-agent-runtime-secret-v3"
    secret_keys = {
      "DATABASE_URL" = ""
      "REDIS_HOST"   = ""
      "REDIS_PORT"   = ""
    }
  }
  "librarian-migration" = {
    secret_name = "qs-test-ec1-librarian-migration-secret-v3"
    secret_keys = {
      "DATABASE_URL"                   = ""
      "OPENAI_API_KEY"                 = ""
      "VOYAGE_API_KEY"                 = ""
      "ENV"                            = ""
      "LIBRARIAN_AUTH_TOKEN"           = ""
      "COMMON_DATABASE_URL"            = ""
      "VOYAGEAI_API_URL"               = ""
      "CUSTOM_ACCESS_TOKEN_SECRET_KEY" = ""
    }
  }
  "stage-processor" = {
    secret_name = "qs-test-ec1-stage-processor-secret-v2"
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
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:kms:eu-central-1:637423349055:key/*"]
    }]
  }
  "iam_002" = {
    name        = "AWS_EventBridge_Scheduler_Execution_Policy_v2"
    description = "AWS_EventBridge_Scheduler_Execution_Policy_v2"
    statements = [{
      Action = [
        "sqs:SendMessage"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:sqs:eu-central-1:637423349055:*"]
    }]
  }
  "iam_003" = {
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
  "iam_004" = {
    name        = "qs-test-ec1-api-ec2-ssm-iam-policy-v2"
    description = "qs-test-ec1-api-ec2-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      }
    ]
  }
  "iam_005" = {
    name        = "qs-test-ec1-api-taskexecution-iam-policy-v2"
    description = "qs-test-ec1-api-taskexecution-iam-policy-v2"
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
  "iam_006" = {
    name        = "qs-test-ec1-api-sqs-iam-policy-v2"
    description = "qs-test-ec1-api-sqs-iam-policy-v2"
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
  "iam_007" = {
    name        = "qs-test-ec1-api-ssm-iam-policy-v2"
    description = "qs-test-ec1-api-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_008" = {
    name        = "qs-test-ec1-api-cognito-iam-policy-v2"
    description = "qs-test-ec1-api-cognito-iam-policy-v2"
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
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DescribeUserPool",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_009" = {
    name        = "qs-test-ec1-api-s3-iam-policy-v2"
    description = "qs-test-ec1-api-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_010" = {
    name        = "qs-test-ec1-api-secrets-manager-ssm-iam-policy-v2"
    description = "qs-test-ec1-api-secrets-manager-ssm-iam-policy-v2"
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
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
      }
    ]
  }
  "iam_011" = {
    name        = "qs-test-ec1-lambda-trigger-sqs-iam-policy-v2"
    description = "qs-test-ec1-lambda-trigger-sqs-iam-policy-v2"
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
  "iam_012" = {
    name        = "qs-test-ec1-lambda-trigger-cognito-iam-policy-v2"
    description = "qs-test-ec1-lambda-trigger-cognito-iam-policy-v2"
    statements = [{
      Action = [
        "cognito-idp:AdminAddUserToGroup",
        "cognito-idp:AdminListGroupsForUser",
        "cognito-idp:AdminRemoveUserFromGroup",
        "cognito-idp:AssociateWebACL",
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DescribeUserPoolClient",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms",
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_013" = {
    name        = "qs-test-ec1-lambda-trigger-ec2-iam-policy-v2"
    description = "qs-test-ec1-lambda-trigger-ec2-iam-policy-v2"
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
  "iam_014" = {
    name        = "qs-test-ec1-lambda-trigger-cloudwatch-iam-policy-v2"
    description = "qs-test-ec1-lambda-trigger-cloudwatch-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogGroup",
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
    }]
  }
  "iam_015" = {
    name        = "qs-test-ec1-librarian-migration-sqs-iam-policy-v2"
    description = "qs-test-ec1-librarian-migration-sqs-iam-policy-v2"
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
  "iam_016" = {
    name        = "qs-test-ec1-librarian-migration-ssm-iam-policy-v2"
    description = "qs-test-ec1-librarian-migration-ssm-iam-policy-v2"
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
    }]
  }
  "iam_017" = {
    name        = "qs-test-ec1-librarian-migration-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-librarian-migration-secretsmanager-iam-policy-v2"
    statements = [{
      Action = [
        "secretsmanager:BatchGetSecretValue",
        "secretsmanager:GetSecretValue",
        "secretsmanager:TagResource",
        "secretsmanager:UntagResource",
        "secretsmanager:UpdateSecretVersionStage"
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_018" = {
    name        = "qs-test-ec1-agent-runtime-ecstaskexecutionrole-iam-policy-v2"
    description = "qs-test-ec1-agent-runtime-ecstaskexecutionrole-iam-policy-v2"
    statements = [{
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_019" = {
    name        = "qs-test-ec1-agent-runtime-sqs-iam-policy-v2"
    description = "qs-test-ec1-agent-runtime-sqs-iam-policy-v2"
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
  "iam_020" = {
    name        = "qs-test-ec1-agent-runtime-bedrock-iam-policy-v2"
    description = "qs-test-ec1-agent-runtime-bedrock-iam-policy-v2"
    statements = [{
      Sid = "BedrockAll"
      Action = [
        "bedrock:*"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Sid = "MarketplaceOperationsFromBedrockFor3pModels"
        Action = [
          "aws-marketplace:Subscribe",
          "aws-marketplace:ViewSubscriptions",
          "aws-marketplace:Unsubscribe"
        ]
        Effect   = "Allow"
        Resource = ["*"]
        Condition = {
          StringEquals = {
            "aws:CalledViaLast" = "bedrock.amazonaws.com"
          }
        }
      }
    ]
  }
  "iam_021" = {
    name        = "qs-test-ec1-agent-runtime-cognito-iam-policy-v2"
    description = "qs-test-ec1-agent-runtime-cognito-iam-policy-v2"
    statements = [{
      Action = [
        "cognito-idp:AdminGetUser",
        "cognito-idp:AssociateWebACL",
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_022" = {
    name        = "qs-test-ec1-agent-runtime-s3-iam-policy-v2"
    description = "qs-test-ec1-agent-runtime-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_023" = {
    name        = "qs-test-ec1-agent-runtime-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-agent-runtime-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_024" = {
    name        = "qs-test-ec1-librarian-assets-ssm-iam-policy-v2"
    description = "qs-test-ec1-librarian-assets-ssm-iam-policy-v2"
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
    }]
  },
  "iam_025" = {
    name        = "qs-test-ec1-librarian-assets-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-librarian-assets-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_026" = {
    name        = "qs-test-ec1-whg-agent-runtime-sqs-iam-policy-v2"
    description = "qs-test-ec1-whg-agent-runtime-sqs-iam-policy-v2"
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
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_027" = {
    name        = "qs-test-ec1-whg-agent-runtime-s3-iam-policy-v2"
    description = "qs-test-ec1-whg-agent-runtime-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_028" = {
    name        = "qs-test-ec1-whg-agent-runtime-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-whg-agent-runtime-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_029" = {
    name        = "qs-test-ec1-etl-ecstaskexecution-iam-policy-v2"
    description = "qs-test-ec1-etl-ecstaskexecution-iam-policy-v2"
    statements = [{
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_030" = {
    name        = "qs-test-ec1-etl-s3-iam-policy-v2"
    description = "qs-test-ec1-etl-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_031" = {
    name        = "qs-test-ec1-etl-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-etl-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_032" = {
    name        = "qs-test-ec1-app-ecstaskexecution-iam-policy-v2"
    description = "qs-test-ec1-app-ecstaskexecution-iam-policy-v2"
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
  "iam_033" = {
    name        = "qs-test-ec1-app-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-app-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
  "iam_034" = {
    name        = "qs-test-ec1-scheduler-ecs-taskexecution-iam-policy-v2"
    description = "qs-test-ec1-scheduler-ecs-taskexecution-iam-policy-v2"
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
  },
  "iam_035" = {
    name        = "qs-test-ec1-scheduler-sqs-iam-policy-v2"
    description = "qs-test-ec1-scheduler-sqs-iam-policy-v2"
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
  },
  "iam_036" = {
    name        = "qs-test-ec1-scheduler-cognito-iam-policy-v2"
    description = "qs-test-ec1-scheduler-cognito-iam-policy-v2"
    statements = [{
      Action = [
        "cognito-idp:AdminAddUserToGroup",
        "cognito-idp:AdminGetUser",
        "cognito-idp:AdminListGroupsForUser",
        "cognito-idp:AdminRemoveUserFromGroup",
        "cognito-idp:AssociateWebACL",
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:ListUsers",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  },
  "iam_037" = {
    name        = "qs-test-ec1-scheduler-eventbridge-iam-policy-v2"
    description = "qs-test-ec1-scheduler-eventbridge-iam-policy-v2"
    statements = [
      {
        Action = [
          "scheduler:*"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "iam:PassRole"
        ]
        Effect = "Allow"
        Resource = [
          "*"
        ]
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "scheduler.amazonaws.com"
          }
        }
      }
    ]
  },
  "iam_038" = {
    name        = "qs-test-ec1-scheduler-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-scheduler-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_039" = {
    name        = "qs-test-ec1-dbms-ecr-logs-iam-policy-v2"
    description = "qs-test-ec1-dbms-ecr-logs-iam-policy-v2"
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
  "iam_040" = {
    name        = "qs-test-ec1-dbms-sqs-iam-policy-v2"
    description = "qs-test-ec1-dbms-sqs-iam-policy-v2"
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
  "iam_041" = {
    name        = "qs-test-ec1-dbms-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-dbms-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_042" = {
    name        = "qs-test-ec1-librarian-retrieval-logs-taskexecution-iam-policy-v2"
    description = "qs-test-ec1-librarian-retrieval-logs-taskexecution-iam-policy-v2"
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
  "iam_043" = {
    name        = "qs-test-ec1-librarian-retrieval-ssm-iam-policy-v2"
    description = "qs-test-ec1-librarian-retrieval-ssm-iam-policy-v2"
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
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_044" = {
    name        = "qs-test-ec1-librarian-retrieval-s3-iam-policy-v2"
    description = "qs-test-ec1-librarian-retrieval-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_045" = {
    name        = "qs-test-ec1-librarian-retrieval-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-librarian-retrieval-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_046" = {
    name        = "qs-test-ec1-integration-ses-iam-policy-v2"
    description = "qs-test-ec1-integration-ses-iam-policy-v2"
    statements = [{
      Action = [
        "ses:AllowVendedLogDeliveryForResource",
        "ses:CancelExportJob",
        "ses:CreateExportJob",
        "ses:GetAddressListImportJob",
        "ses:GetExportJob",
        "ses:GetReputationEntity",
        "ses:ListTagsForResource",
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
  "iam_047" = {
    name        = "qs-test-ec1-integration-ecr-logs-iam-policy-v2"
    description = "qs-test-ec1-integration-ecr-logs-iam-policy-v2"
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
  "iam_048" = {
    name        = "qs-test-ec1-integration-s3-iam-policy-v2"
    description = "qs-test-ec1-integration-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_049" = {
    name        = "qs-test-ec1-integration-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-integration-secretsmanager-iam-policy-v2"
    statements = [{
      Sid = "BasePermissions"
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
        Sid = "S3Permissions"
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
    }]
  }
  "iam_050" = {
    name        = "qs-test-ec1-whg-api-ec2-ssm-iam-policy-v2"
    description = "qs-test-ec1-whg-api-ec2-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      }
    ]
  }
  "iam_051" = {
    name        = "qs-test-ec1-whg-api-taskexecution-iam-policy-v2"
    description = "qs-test-ec1-whg-api-taskexecution-iam-policy-v2"
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
  "iam_052" = {
    name        = "qs-test-ec1-whg-api-sqs-iam-policy-v2"
    description = "qs-test-ec1-whg-api-sqs-iam-policy-v2"
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
  "iam_053" = {
    name        = "qs-test-ec1-whg-api-ssm-iam-policy-v2"
    description = "qs-test-ec1-whg-api-ssm-iam-policy-v2"
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
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_054" = {
    name        = "qs-test-ec1-whg-api-cognito-iam-policy-v2"
    description = "qs-test-ec1-whg-api-cognito-iam-policy-v2"
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
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DescribeUserPool",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_055" = {
    name        = "qs-test-ec1-whg-api-s3-iam-policy-v2"
    description = "qs-test-ec1-whg-api-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ]
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_056" = {
    name        = "qs-test-ec1-whg-api-secrets-manager-ssm-iam-policy-v2"
    description = "qs-test-ec1-whg-api-secrets-manager-ssm-iam-policy-v2"
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
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::awsserverlessrepo-changesets*",
          "arn:aws:s3:::secrets-manager-rotation-apps-*/*"
        ]
      }
    ]
  }
  "iam_057" = {
    name        = "qs-test-ec1-whg-agent-runtime-bedrock-iam-policy-v2"
    description = "qs-test-ec1-whg-agent-runtime-bedrock-iam-policy-v2"
    statements = [{
      Sid = "BedrockAll"
      Action = [
        "bedrock:*"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Sid = "MarketplaceOperationsFromBedrockFor3pModels"
        Action = [
          "aws-marketplace:Subscribe",
          "aws-marketplace:ViewSubscriptions",
          "aws-marketplace:Unsubscribe"
        ]
        Effect   = "Allow"
        Resource = ["*"]
        Condition = {
          StringEquals = {
            "aws:CalledViaLast" = "bedrock.amazonaws.com"
          }
        }
      }
    ]
  }
  "iam_058" = {
    name        = "qs-test-ec1-whg-agent-runtime-cognito-iam-policy-v2"
    description = "qs-test-ec1-whg-agent-runtime-cognito-iam-policy-v2"
    statements = [{
      Action = [
        "cognito-idp:AdminGetUser",
        "cognito-idp:AssociateWebACL",
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_059" = {
    name        = "qs-test-ec1-app-ssm-iam-policy-v2"
    description = "qs-test-ec1-app-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_060" = {
    name        = "qs-test-ec1-dbms-cognito-iam-policy-v2"
    description = "qs-test-ec1-dbms-cognito-iam-policy-v2"
    statements = [{
      Action = [
        "cognito-idp:AssociateWebACL",
        "cognito-idp:CreateGroup",
        "cognito-idp:CreateTerms",
        "cognito-idp:DeleteTerms",
        "cognito-idp:DescribeTerms",
        "cognito-idp:DisassociateWebACL",
        "cognito-idp:GetTokensFromRefreshToken",
        "cognito-idp:GetWebACLForResource",
        "cognito-idp:ListGroups",
        "cognito-idp:ListResourcesForWebACL",
        "cognito-idp:ListTagsForResource",
        "cognito-idp:ListTerms",
        "cognito-idp:TagResource",
        "cognito-idp:UntagResource",
        "cognito-idp:UpdateManagedLoginBranding",
        "cognito-idp:UpdateTerms"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_061" = {
    name        = "qs-test-ec1-dbms-s3-iam-policy-v2"
    description = "qs-test-ec1-dbms-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_062" = {
    name        = "qs-test-ec1-ai-agent-ssm-iam-policy-v2"
    description = "qs-test-ec1-ai-agent-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:DescribeLog*",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery",
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
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Effect   = "Allow"
        Resource = ["*"]
      }
    ]
  }
  "iam_063" = {
    name        = "qs-test-ec1-ai-agent-ecstaskexecution-iam-policy-v2"
    description = "qs-test-ec1-ai-agent-ecstaskexecution-iam-policy-v2"
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
  "iam_064" = {
    name        = "qs-test-ec1-ai-agent-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-ai-agent-secretsmanager-iam-policy-v2"
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
  "iam_065" = {
    name        = "qs-test-ec1-scheduler-s3-iam-policy-v2"
    description = "qs-test-ec1-scheduler-s3-iam-policy-v2"
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
        "s3:GetObject*",
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
        "s3:UpdateBucketMetadataInventoryTableConfiguration",
        "s3:UpdateStorageLensGroup"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_066" = {
    name        = "qs-test-ec1-scheduler-ssm-iam-policy-v2"
    description = "qs-test-ec1-scheduler-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_067" = {
    name        = "qs-test-ec1-etl-ssm-iam-policy-v2"
    description = "qs-test-ec1-etl-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_068" = {
    name        = "qs-test-ec1-integration-ssm-iam-policy-v2"
    description = "qs-test-ec1-integration-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_069" = {
    name        = "qs-test-ec1-integration-cloudwatch-iam-policy-v2"
    description = "qs-test-ec1-integration-cloudwatch-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_070" = {
    name        = "qs-test-ec1-lambda-trigger-ssm-iam-policy-v2"
    description = "qs-test-ec1-lambda-trigger-ssm-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:CreateScheduledQuery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DeleteScheduledQuery",
        "logs:FilterLogEvents",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetScheduled*",
        "logs:Link",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListScheduledQueries",
        "logs:ListTags*",
        "logs:PutAccountPolicy",
        "logs:PutLogEvents",
        "logs:StopLiveTail",
        "logs:Tag*",
        "logs:Unmask",
        "logs:Untag*",
        "logs:UpdateLogDelivery",
        "logs:UpdateScheduledQuery"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_071" = {
    name        = "qs-test-ec1-lambda-trigger-LambdaQueue-iam-policy-v2"
    description = "qs-test-ec1-lambda-trigger-LambdaQueue-iam-policy-v2"
    statements = [{
      Action = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_072" = {
    name        = "qs-test-ec1-librarian-assets-logs-taskexecution-iam-policy-v2"
    description = "qs-test-ec1-librarian-assets-logs-taskexecution-iam-policy-v2"
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
}

role = {
  api = {
    name         = "qs-test-ec1-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-ec2-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-taskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-cognito-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-api-secrets-manager-ssm-iam-policy-v2"
    ]
  }
  app = {
    name         = "qs-test-ec1-app-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-app-ecstaskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-app-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-app-ssm-iam-policy-v2"
    ]
  }
  dbms = {
    name         = "qs-test-ec1-dbms-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-dbms-ecr-logs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-dbms-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-dbms-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-dbms-cognito-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-dbms-s3-iam-policy-v2",
      "arn:aws:iam::aws:policy/AmazonEventBridgeSchedulerFullAccess"
    ]
  }
  ai-agent = {
    name         = "qs-test-ec1-ai-agent-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-ai-agent-ecstaskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-ai-agent-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-ai-agent-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2"
    ]
  }
  agent-runtime = {
    name         = "qs-test-ec1-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-agent-runtime-ecstaskexecutionrole-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-agent-runtime-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-agent-runtime-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-agent-runtime-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-agent-runtime-bedrock-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-agent-runtime-cognito-iam-policy-v2"
    ]
  }
  scheduler = {
    name         = "qs-test-ec1-scheduler-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-ecs-taskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-cognito-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-eventbridge-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-scheduler-ssm-iam-policy-v2"
    ]
  }
  etl = {
    name         = "qs-test-ec1-etl-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-etl-ecstaskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-etl-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-etl-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-etl-ssm-iam-policy-v2"
    ]
  }
  integration = {
    name         = "qs-test-ec1-integration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-integration-ecr-logs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-integration-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-integration-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-integration-ses-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-integration-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-integration-cloudwatch-iam-policy-v2"
    ]
  }
  lambda = {
    name         = "qs-test-ec1-trigger-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-lambda-trigger-cognito-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-lambda-trigger-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-lambda-trigger-ec2-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-lambda-trigger-cloudwatch-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-lambda-trigger-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-lambda-trigger-LambdaQueue-iam-policy-v2"
    ]
  }
  eventbridge_scheduler = {
    name         = "qs-test-ec1-scheduler-iam-role"
    type         = "Service"
    service_type = ["scheduler.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/AWS_EventBridge_Scheduler_Execution_Policy_v2"
    ]
  }
  librarian-retrieval = {
    name         = "qs-test-ec1-librarian-retrieval-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-retrieval-logs-taskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-retrieval-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-retrieval-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-retrieval-s3-iam-policy-v2"
    ]
  }
  librarian-assets = {
    name         = "qs-test-ec1-librarian-assets-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-assets-logs-taskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-assets-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-assets-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2"
    ]
  }
  whg-api = {
    name         = "qs-test-ec1-whg-api-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-taskexecution-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-secrets-manager-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-cognito-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-ec2-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-api-ssm-iam-policy-v2"
    ]
  }
  whg-agent-runtime = {
    name         = "qs-test-ec1-whg-agent-runtime-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-agent-runtime-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-agent-runtime-sqs-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-agent-runtime-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-agent-runtime-cognito-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-whg-agent-runtime-bedrock-iam-policy-v2"
    ]
  }
  librarian-migration = {
    name         = "qs-test-ec1-librarian-migration-ecs-iam-role"
    type         = "Service"
    service_type = ["ecs-tasks.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-migration-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-migration-ssm-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-librarian-migration-sqs-iam-policy-v2"
    ]
  }
  lambda02 = {
    name         = "qs-test-ec1-queue-handler-lambda-iam-role"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::637423349055:policy/AmazonSSM-Policy-v2"
    ]
  }
  ingestion-queue-orchestrator = {
    name         = "qs-test-ec1-ingestion-queue-orchestrator-ecs-iam-role"
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
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-llm = {
    name         = "qs-test-ec1-ingestion-worker-llm-ecs-iam-role"
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
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-generic = {
    name         = "qs-test-ec1-ingestion-worker-generic-ecs-iam-role"
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
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  ingestion-worker-pgvector-loader = {
    name         = "qs-test-ec1-ingestion-worker-pgvector-loader-ecs-iam-role"
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
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
}

#################################
######## REDIS ########
#################################

redis_subnet = {
  subnet_group_01 = {
    name        = "qs-test-ec1-redis-sne-grp"
    subnet_name = ["qs-test-ec1-private-sne-redis-01a-v2"]
  }
}

# Redis Parameter Group
redis_params = {
  "param001" = {
    redis_pg_name   = "qs-test-ec1-redis-pubsub-pg-v2"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "AKE"
    }]
  }
  "param002" = {
    redis_pg_name   = "qs-test-ec1-redis-cache-pg-v2"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "Ex"
    }]
  }
  "param003" = {
    redis_pg_name   = "qs-test-ec1-redis-whg-pubsub-pg-v2"
    redis_pg_family = "redis7"
    redis_pg_parameters = [{
      name  = "notify-keyspace-events"
      value = "AKE"
    }]
  }
}

redis = {
  "redis01" = {
    name                 = "qs-test-ec1-redis-cache-v2"
    sneGroupName         = "qs-test-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-test-ec1-main-vpc-v2"
    parameter_group_name = "qs-test-ec1-redis-cache-pg-v2"
    num_cache_clusters   = 1
    environment          = "test"
  }
  "redis02" = {
    name                 = "qs-test-ec1-redis-pubsub-v2"
    sneGroupName         = "qs-test-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-test-ec1-main-vpc-v2"
    parameter_group_name = "qs-test-ec1-redis-pubsub-pg-v2"
    num_cache_clusters   = 1
    environment          = "test"
  }
  "redis03" = {
    name                 = "qs-test-ec1-redis-whg-pubsub-v2"
    sneGroupName         = "qs-test-ec1-redis-sne-grp"
    size                 = "cache.t4g.medium"
    vpc_name             = "qs-test-ec1-main-vpc-v2"
    num_cache_clusters   = 1
    parameter_group_name = "qs-test-ec1-redis-whg-pubsub-pg-v2"
    environment          = "test"
  }
}

s3 = {
  "s30001" = {
    bucket_name             = "qs-test-ec1-logos-s3-v2"
    block_all_public_access = true
  }
  "s30002" = {
    bucket_name             = "qs-test-ec1-customer0001-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0001"
    tags = {
      "TenantID" = "Customer0001"
    }
  }
  "s30003" = {
    bucket_name             = "qs-test-ec1-customer0002-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0002"
    tags = {
      "TenantID" = "Customer0002"
    }
  }
  "s30004" = {
    bucket_name             = "qs-test-ec1-customer0003-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0003"
    tags = {
      "TenantID" = "Customer0003"
    }
  }
  "s30005" = {
    bucket_name             = "qs-test-ec1-customer0004-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0004"
    tags = {
      "TenantID" = "Customer0004"
    }
  }
  "s30006" = {
    bucket_name             = "qs-test-ec1-gluescript-s3-v2"
    block_all_public_access = true
  }
  "s30007" = {
    bucket_name             = "qs-test-ec1-glue-library-dependency-s3-v2"
    block_all_public_access = true
  }
  "s30008" = {
    bucket_name             = "qs-test-ec1-chatwidget-s3-v2"
    block_all_public_access = true
  }
  "s3009" = {
    bucket_name             = "qs-test-ec1-query-result-athena-s3-v2"
    block_all_public_access = true
  }
  "s30010" = {
    bucket_name             = "qs-test-ec1-customer0006-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0006"
    tags = {
      "TenantID" = "Customer0006"
    }
  }
  "s30011" = {
    bucket_name             = "qs-test-ec1-logos-s3-v2"
    block_all_public_access = true
  }
  "s30012" = {
    bucket_name             = "qs-test-ec1-shared-s3-v2"
    block_all_public_access = true
  }
  "s30013" = {
    bucket_name             = "qs-test-ec1-customer0012-s3-v2"
    block_all_public_access = true
    kms_key_arn             = "customer0012"
    tags = {
      "TenantID" = "Customer0012"
    }
  }
}

# This is for custom policy
buckets = ["qs-test-ec1-logos-s3-v2"]

s3_bucket_policy = {
  "qs-test-ec1-logos-s3-v2" = {
    bucket_id = "qs-test-ec1-logos-s3-v2"
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
          "Resource" : "arn:aws:s3:::qs-test-ec1-logos-s3-v2/*",
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : "arn:aws:cloudfront::637423349055:distribution/ESBEZNS7IGHYR"
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
  "rds_test" = {
    environment = "test"
    key_name    = "qs-test-ec1-rds-test-kms-v2"
    kms_key_policy = {
      "Version" : "2012-10-17",
      "Id" : "test",
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
    environment = "test"
    key_name    = "qs-test-ec1-customer0001-kms-v2"
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
    environment = "test"
    key_name    = "qs-test-ec1-customer0003-kms-v2"
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
    environment = "test"
    key_name    = "qs-test-ec1-customer0004-kms-v2"
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
    environment = "test"
    key_name    = "qs-test-ec1-customer0002-kms-v2"
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
  "customer0006" = {
    environment = "test"
    key_name    = "qs-test-ec1-customer0006-kms-v2"
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
  "customer0012" = {
    environment = "test"
    key_name    = "qs-test-ec1-customer0012-kms-v2"
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
              "kms:CallerAccount" : "637423349055",
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
              "arn:aws:iam::637423349055:root",
              "arn:aws:iam::637423349055:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AWS-TEST-QA_ea8bf66da4bd2c02"
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
      "TenantID" = "Customer0012"
    }
  }
}
#################################
########   COGNITO  #############
#################################

tenants = {
  anwr = {
    user_pool_name               = "qs-test-ec1-customer0006-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0006"
    callbackUrls                 = ["https://anwr.test.octonomy.ai/api/appconnect/auth/callback", "https://anwr.test.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://anwr.test.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      anwr = {
        idp_name    = "anwr"
        metadataUrl = "https://dev-13821971.okta.com/app/exknr1fwreZZ8t27J5d7/sso/saml/metadata"
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
  worldhost-group = {
    user_pool_name               = "qs-test-ec1-customer0012-cgnto-v1"
    post_confirmation_lambda_arn = "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-post-signup-trigger-v3"
    app_client_name              = "customer0012"
    callbackUrls                 = ["https://worldhost-group.test.octonomy.ai/api/appconnect/auth/callback", "https://worldhost-group.test.octonomy.ai/api/appconnect/chat/callback"]
    logout_urls                  = ["https://worldhost-group.test.octonomy.ai/api/appconnect/auth/signout"]
    idp = {
      anwr = {
        idp_name    = "worldhost-group"
        metadataUrl = "https://login.microsoftonline.com/e80a991a-e8bd-4930-bb0c-8d3b30b04c08/federationmetadata/2007-06/federationmetadata.xml?appid=841418a5-5c42-4f14-918e-2cff6b3bfa06"
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
########     RDS     ############
#################################

# RDS Parameter Group
rds_pg_name   = "qs-test-ec1-rds-pg-v2"
rds_pg_family = "postgres16"
rds_pg_parameters = [
  {
    name  = "rds.force_ssl"
    value = "0"
  }
]

rds-new = {
  rds01 = {
    vpc_name                 = "qs-test-ec1-main-vpc-v2"
    subnet_group_name        = "qs-test-ec1-db-sne-grp"
    instance_name            = "test"
    instance_type            = "db.t4g.large"
    kms_key_arn              = "customer0001"
    engine_version           = "16.10"
    environment              = "test"
    parameter_group_name     = "qs-test-ec1-rds-pg-v2"
    skip_final_snapshot      = true
    backup_retention_period  = 7
    deletion_protection      = true
    delete_automated_backups = false
  }
}

sns_topics = {
  sns01 = {
    name = "qs-test-ec1-sns-alert-v2"
  }
}
alarms = {
  "alarm0001" = {
    alarm_name                = "qs-test-ec1-alarm-bastion-cpu-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Maximum"
    threshold                 = 90
    alarm_description         = "Alarm for EC2 instance CPU utilization"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    actions_enabled           = true
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    ec2_key                   = "Bastion_Host"
    dimensions = {
      InstanceId = "" // keep it empty and use ec2_key to get the instance Id, only applicable for namespace AWS/EC2
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-test-ec1-alarm-bastion-status-v2"
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
    actions_enabled           = true
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    ec2_key                   = "Bastion_Host"
    dimensions = {
      InstanceId = "" // keep it empty and use ec2_key to get the instance Id, only applicable for namespace AWS/EC2
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-api-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "api"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-agent-runtime-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "agent-runtime"
    }
  }
  "alarm0007" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-app-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "app"
    }
  }
  "alarm0008" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-dbms-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "dbms"
    }
  }
  "alarm0009" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-etl-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "etl"
    }
  }
  "alarm0010" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-integration-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "integration"
    }
  }
  "alarm0011" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-scheduler-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    actions_enabled           = false
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "scheduler"
    }
  }
  "alarm0012" = {
    alarm_name                = "qs-test-ec1-alarm-ecs-ai-agent-taskcount-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      ClusterName = "qs-test-ec1-main-ecs-v2"
      ServiceName = "ai-agent"
    }
  }
  "alarm0026" = {
    alarm_name                = "qs-test-ec1-alarm-alb-main-502-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "HTTPCode_ELB_502_Count"
    namespace                 = "AWS/ApplicationELB"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 5
    alarm_description         = "Alarm for 502 errors in alb"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0027" = {
    alarm_name                = "qs-test-ec1-alarm-alb-main-503-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "HTTPCode_ELB_503_Count"
    namespace                 = "AWS/ApplicationELB"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 5
    alarm_description         = "Alarm for 503 errors in alb"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    actions_enabled           = false
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      LoadBalancer = "alb" // provide load balancer key
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-test-ec1-alarm-customer0006-kms-DisabledKey-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-test-ec1-customer0006-kms-v2"
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-test-ec1-alarm-customer0001-kms-DisabledKey-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-test-ec1-customer0001-kms-v2"
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-test-ec1-alarm-customer0002-kms-DisabledKey-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-test-ec1-customer0002-kms-v2"
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-test-ec1-alarm-customer0003-kms-DisabledKey-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-test-ec1-customer0003-kms-v2"
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-test-ec1-alarm-customer0004-kms-DisabledKey-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-test-ec1-customer0004-kms-v2"
    }
  }
  "alarm0031" = {
    alarm_name                = "qs-test-ec1-alarm-customer0005-kms-DisabledKey-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      KeyId = "qs-test-ec1-customer0005-kms-v2"
    }
  }
}
sns_topic_subscription = {
  snss01 = {
    sns_name = "qs-test-ec1-sns-alert-v2"
    protocol = "email"
    endpoint = "rizwana.parveen@talentship.io"
  }
  snss02 = {
    sns_name = "qs-test-ec1-sns-alert-v2"
    protocol = "email"
    endpoint = "Rajeshwar.rajakumar@talentship.io"
  }
  snss03 = {
    sns_name = "qs-test-ec1-sns-alert-v2"
    protocol = "email"
    endpoint = "darwin.wilmut@talentship.io"
  }
}
lb_5xx_errors_threshold = 10
rds_instance_id         = "qs-test-ec1-test-rds-v2"

## Cloudfront ###
cf_origin_0001 = "qs-test-ec1-logos-s3-v2.s3.eu-central-1.amazonaws.com"

## Cloudfront_0002 ###
cf_origin_0002 = "qs-test-ec1-main-alb-v2-960815346.eu-central-1.elb.amazonaws.com"
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

cf_origin_0003           = "qs-test-ec1-wss-alb-v2-805954952.eu-central-1.elb.amazonaws.com"
acm_certificate_arn_0003 = "arn:aws:acm:us-east-1:637423349055:certificate/313fdfd1-8575-42b0-87cd-dfd7af56387c"
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
    resource_group_name = "qs-test-ec1-rg-customer0001"
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
    resource_group_name = "qs-test-ec1-rg-customer0002"
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
    resource_group_name = "qs-test-ec1-rg-customer0003"
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
    resource_group_name = "qs-test-ec1-rg-customer0004"
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
    resource_group_name = "qs-test-ec1-rg-customer0005"
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
    resource_group_name = "qs-test-ec1-rg-customer0006"
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
schedulers_threshold               = 5
sqs_messages_not_visible_threshold = 6
missing_data_actions               = ["missing"]
DBInstanceIdentifier               = ["qs-test-ec1-test-rds-v2"]

#################################
########      WAF    ############
#################################

addresses = [
  "14.97.127.46/32"
]

waf_acls = {
  cloudfront_main = {
    name            = "qs-test-ec1-waf-cf-v2"
    scope           = "CLOUDFRONT"
    description     = "qs-test-ec1-waf-cf-v2"
    waf_metric_name = "qs-test-ec1-waf-cf-v2"
    log_group_name  = "aws-waf-logs-qs-v2"
    waf_rules = [
      {
        name                  = "qs-test-ec1-rate-limiting-v2"
        priority              = 0
        statement_type        = "rate_based"
        rate_limit            = 1000
        evaluation_window_sec = 300
        aggregate_key_type    = "IP" # Fixed typo from 'aggregate_key_type'
        action                = "count"
        metric_name           = "qs-test-ec1-rate-limiting-v2"
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
        name                     = "qs-test-ec1-url-block-waf-rule"
        priority                 = 2
        statement_type           = "custom"
        statement_nested_type    = "and"
        byte_match_search_string = "/api/appconnect/docs"
        text_transformation_type = "NONE"
        country_codes            = ["IN"]
        action                   = "block"
        response_code            = 403
        custom_response_body_key = "403-response-page"
        metric_name              = "qs-test-ec1-url-block-waf-rule"
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
        name           = "qs-test-ec1-country-restrictions-allow-waf-rule"
        priority       = 3
        statement_type = "geo"
        country_codes = [
          "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
          "VA", "HU", "IS", "IN", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT", "MD", "MC", "ME", "NL",
          "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "UA", "GB", "US"
        ]
        action      = "allow"
        metric_name = "qs-test-ec1-country-restrictions-allow-waf-rule"
      },
      {
        name           = "qs-test-ec1-country-restrictions-block-waf-rule"
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
        metric_name              = "qs-test-ec1-country-restrictions-block-waf-rule"
      },
      {
        name           = "qs-test-ec1-country-restrictions-block-waf-rule-2"
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
        metric_name              = "qs-test-ec1-country-restrictions-block-waf-rule-2"
      }
    ]
  }
}
dbconnection_threshold = 1469
dbload_threshold       = 4


cloudwatch_log_group = {
  cloudwatch0001 = {
    log_group_name    = "qs-test-ec1-observability-agent-runtime"
    retention_in_days = 90
  }
  cloudwatch0002 = {
    log_group_name    = "qs-test-ec1-observability-api"
    retention_in_days = 90
  }
}

private_buckets = ["qs-test-ec1-customer0001-s3-v2", "qs-test-ec1-customer0002-s3-v2", "qs-test-ec1-customer0003-s3-v2", "qs-test-ec1-customer0004-s3-v2", "qs-test-ec1-customer0006-s3-v2", "qs-test-ec1-customer0012-s3-v2"]

public_alb_subnet_ids = ["subnet-0bac1b82f4da14404", "subnet-04b11600cab057511", "subnet-0826eefcd2e19dcd2"]

private_alb_subnet_ids = ["subnet-033bd6dc8d1c0d71a", "subnet-0c640670e414c1d4c", "subnet-095232e081fec7c52"]

ecs_subnet_id = ["subnet-04584f8c65ac95fcb"]

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
    secret_keys            = ["AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "AWS_SQS_BASE_URL", "CLOUD_WATCH_LOGS_SQS_QUEUE_URL", "CLOUD_WATCH_METRICS_SQS_QUEUE_URL", "DATABASE_URL", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "OPENAI_API_KEY", "PROMPT_PROCESS_CLUSTER_QUEUE", "PROMPT_PROCESS_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "REDIS_HOST", "REDIS_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "VOYAGE_BASE_URL"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "AWS_CDN_URL", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "AWS_S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DEEPGRAM_API_KEY", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "NEO4J_URL_CUSTOMER", "NODE_ENV", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID", "VAPI_API_ENDPOINT", "VAPI_API_KEY", "VAPI_CUSTOMER_KEY", "WEBHOOK_WORKER_SQS_QUEUE_URL", "CR_DATA_LOAD_QUEUE_URL", "ASSETS_SERVICE_URL", "ASSETS_AUTH_TOKEN"]
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
    secret_keys            = ["NEXT_PUBLIC_ASSETS_BASE_URL", "NEXT_PUBLIC_DOMAIN", "NEXT_PUBLIC_SOCKET_DOMAIN"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_PREFIXES", "CLUSTER_MANAGER_ETL_ENABLED", "DATABASE_URL", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_PREFIXES", "ANTHROPIC_API_BASE_URL", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "ATLASSIAN_BASE_URL", "AWS_REGION", "AWS_S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "CONFLUENCE_AUTH_TOKEN", "CONFLUENCE_BASE_URL", "CONFLUENCE_CONNECTION_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DB_DATA_MIGRATION_SQS_QUEUE_URL", "DB_SCHEMA_MIGRATION_SQS_QUEUE_URL", "DHL_API_BASE_URL", "DHL_TEST_TRACKING_NUMBER", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "GOKARLA_BASE_URL", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JIRA_CONNECTION_ID", "NEO4J_DB_PASSWORD", "NEO4J_DB_URL", "NEO4J_DB_USERNAME", "NEO4J_URL_CUSTOMER", "NODE_ENV", "OPENAI_API_BASE_URL", "PG_DB_HOST", "PG_DB_NAME", "PG_DB_PASSWORD", "PG_DB_PORT", "PG_DB_USERNAME", "PORT", "S3_BUCKET_NAME", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "SHADOW_DATABASE_URL", "SHADOW_DATABASE_URL_CUSTOMER", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID", "VAPI_API_ENDPOINT"]
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
    secret_keys            = ["AUTH_STRATEGY", "COMMON_DATABASE_URL", "CONFIGURATION_SCHEMA_BUCKET", "CONFIGURATION_SCHEMA_DEFAULT_VERSION", "CONFIGURATION_SCHEMA_PATH", "CUSTOM_ACCESS_TOKEN_SECRET_KEY", "DATABASE_URL", "ENCRYPTION_KEY", "ENV", "LIBRARIAN_AUTH_TOKEN", "OPENAI_API_KEY", "SERVICE_NAME", "VECTOR_DB_TYPE", "VOYAGEAI_API_URL", "VOYAGE_API_KEY"]
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
    secret_keys            = ["AGENT_RUNTIME_SERVICE_URL", "AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "APP_CONFIG_APPLICATION", "APP_CONFIG_CONFIGURATION", "APP_CONFIG_ENVIRONMENT", "AWS_CDN_URL", "AWS_LAMBDA_ENDPOINT", "AWS_REGION", "AWS_S3_BUCKET_NAME", "CLUSTER_MANAGER_ETL_ENABLED", "COGNITO_CLIENT_ID", "COGNITO_USER_POOL_ID", "DATABASE_URL", "DATABASE_URL_CUSTOMER", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "DEEPGRAM_API_KEY", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "NEO4J_URL_CUSTOMER", "NODE_ENV", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "UNIFIED_API_KEY", "UNIFIED_ENDPOINT", "UNIFIED_ENV", "UNIFIED_WORKSPACE_ID", "VAPI_API_ENDPOINT", "VAPI_API_KEY", "VAPI_CUSTOMER_KEY", "WEBHOOK_WORKER_SQS_QUEUE_URL", "CR_DATA_LOAD_QUEUE_URL"]
    desired_count          = 1
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
    secret_keys            = ["AGRUN_AUTH_TOKEN", "AI_AGENT_AUTH_TOKEN", "AI_AGENT_SERVICE_URL", "ALLOWED_ORIGIN", "ALLOWED_PREFIXES", "AWS_SQS_BASE_URL", "CLOUD_WATCH_LOGS_SQS_QUEUE_URL", "CLOUD_WATCH_METRICS_SQS_QUEUE_URL", "DATABASE_URL", "DBMS_AUTH_TOKEN", "DBMS_SERVICE_URL", "ENCRYPTION_KEY", "ETL_AUTH_TOKEN", "ETL_SERVICE_URL", "FEATURE_FLAG_SERVICE_PROVIDER", "INTEGRATION_SERVICE_URL", "INTEG_AUTH_TOKEN", "JWT_SECRET", "LAUNCHDARKLY_SDK_KEY", "LIBRARIAN_RETRIEVAL_AUTH_TOKEN", "LIBRARIAN_RETRIEVAL_SERVICE_URL", "OBSERVABILITY_DISPATCH_SQS_QUEUE_URL", "OPENAI_API_KEY", "PROMPT_PROCESS_CLUSTER_QUEUE", "PROMPT_PROCESS_SQS_QUEUE_URL", "REDIS_CACHE_HOST", "REDIS_CACHE_PORT", "REDIS_HOST", "REDIS_PORT", "SCHEDULER_SERVICE_URL", "SCH_AUTH_TOKEN", "VOYAGE_BASE_URL"]
    desired_count          = 1
  }
}

# public_alb = {
#   "ai-agent" = {
#     container_port = 80
#   }
#   "librarian-assets" = {
#     container_port = 9099
#   }
#   "api" = {
#     container_port = 3001
#   }
#   "whg-api" = {
#     container_port = 3001
#   }
#   "app" = {
#     container_port = 3000
#   }
# }

# internal_alb = {
#   "dbms" = {
#     container_port = 3002
#   }
#   "scheduler" = {
#     container_port = 3003
#   }
#   "etl" = {
#     container_port = 3004
#   }
#   "integration" = {
#     container_port = 3005
#   }
#   "librarian-retrieval" = {
#     container_port = 9098
#   }
# }

# target_groups = {
#     "agent-runtime" = {
#       enable_stickiness          = true
#       stickiness_cookie_duration = 86400
#       path                       = "/agent-runtime/api/v1/health-check"
#     }
#     "agent-runtime-ilb"   = {
#       path                       = "/agent-runtime/api/v1/health-check"
#     }
#     "ai-agent"            = {}
#     "api"                 = {
#       path = "/api/appconnect/health-check"
#     }
#     "app"                 = {}
#     "dbms"                = {
#       path = "/dbms/api/v1/health-check"
#     }
#     "etl"                 = {
#       path = "/etl/api/v1/health-check"
#     }
#     "integration"         = {
#       path = "/integration/api/v1/health-check"
#     }
#     "librarian-assets"    = {}
#     "librarian-retrieval" = {}
#     "scheduler"           = {
#       path = "/scheduler/api/v1/health-check"
#     }
#   }

