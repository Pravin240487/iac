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
  default = {
    Terraformed = "true"
    Owner       = "Octonomy.devops@talentship.io"
  }
}

variable "wss_alb_security_group" {
  type = string
}

variable "lambda_security_group" {
  type = string
}

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

variable "iam_role" {
  type = map(object({
    name           = string
    type           = string
    service_type   = list(string)
    permission_arn = list(string)
    tags = optional(map(string), {
      Terraformed = "true"
      Owner       = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "lambda" {
  type = map(object({
    function_name       = string
    image_uri           = string
    role_name           = string
    subnet_name         = optional(list(string))
    security_group_name = optional(list(string))
    memory_size         = optional(number, 128)
    timeout             = optional(number, 3)
    variables           = optional(map(string), {})
    tags = optional(map(string), {
      Terraformed = "true"
      Owner       = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "lambda_zip" {
  type = map(object({
    function_name = string
    handler       = optional(string, "lambda_function.lambda_handler")
    runtime       = optional(string, "python3.12")
    role_name     = string
    memory_size   = optional(number, 128)
    timeout       = optional(number, 3)
    variables     = optional(map(string), {})
    tags = optional(map(string), { Terraformed = "true"
      Owner = "Octonomy.devops@talentship.io"
    })
  }))
  default = {}
}

variable "sqs" {
  type = map(object({
    name                       = string
    delay_seconds              = optional(number, 90)
    max_message_size           = optional(number, 262144)
    message_retention_seconds  = optional(number, 86400)
    receive_wait_time_seconds  = optional(number, 10)
    visibility_timeout_seconds = optional(number, 30)
    dlq_name                   = optional(string)
    enable_dlq                 = optional(bool, false)
    max_receive_count          = optional(number, 3)
    tags = optional(map(string), {
      Terraformed = "true"
      Owner       = "Octonomy.devops@talentship.io"
    })
  }))
}

variable "sfn" {
  description = "step function to run the glue job"
  type = map(object({
    rest_api_name            = optional(string, null)
    name                     = string
    role_arn                 = string
    state_machine_definition = optional(string, null)
    log_group_name           = string
    include_execution_data   = bool
    level                    = string
  }))
}

variable "secret" {
  description = "secrets for storing the glue data connection password and username"
  type = map(object({
    connection_name = string
    secret_name     = string
    username        = string
  }))
}

variable "data_connection" {
  description = "Glue data connection to attach in ETL job"
  type = map(object({
    glue_subnets_name  = string
    security_group_rds = string
    connection_name    = string
    availability_zone  = string
    rds_cluster_name   = string
    database_name      = string
    database_type      = string
  }))
}

variable "glue_jobs" {
  description = "Map of Glue job configurations."
  type = map(object({
    connections_use           = bool
    default_arguments         = map(string)
    connection_name           = optional(list(string), null)
    description               = string
    execution_class           = string
    glue_version              = string
    job_run_queuing_enabled   = bool
    maintenance_window        = string
    max_retries               = number
    name                      = string
    non_overridable_arguments = map(string)
    role_arn                  = string
    security_configuration    = string
    tags                      = map(string)
    timeout                   = number
    worker_type               = string
    command_name              = string
    python_version            = string
    script_location           = string
    max_concurrent_runs       = number
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
    actions_enabled           = optional(bool, true)
  }))
}
variable "environment" {
  description = "The environment in which the instances are being deployed. Typical values are 'prod', 'dev', or 'test'."
  type        = string
}
variable "dlq_messages_sent_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"
}
variable "dlq_messages_sent_threshold" {
  default     = 20
  type        = number
  description = "The threshold of the alarm"
}
variable "dlq_messages_sent_statistic" {
  default     = "Sum"
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
variable "sns_topic" {
  description = "The name of the SNS topic to send the alarm to"
  type        = string
}
variable "treat_missing_data" {
  default     = "notBreaching"
  type        = string
  description = "treat missing data for the scheduler metric alarm"

}
variable "sf_datapoints_to_alarm" {
  default     = 1
  type        = number
  description = "The number of datapoints to alarm"
}
variable "sf_statistic" {
  default     = "Sum"
  type        = string
  description = "The statistic of the alarm"

}
variable "sf_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"

}
variable "sf_threshold" {
  default     = 1
  type        = number
  description = "The threshold of the alarm"

}
variable "create_ecr_lambda" {
  default     = true
  type        = bool
  description = "type of lambda to create"
}
variable "create_event_source_mapping" {
  default     = true
  type        = bool
  description = "Whether to create an event source mapping for the lambda function"

}
variable "image_uri" {
  type        = string
  description = "image uri of cw_log_lambda"
}
variable "subnet_name" {
  type        = string
  description = "subnets for the lambda"
}
variable "create_iam_role" {
  default     = false
  type        = bool
  description = "Whether to create an IAM role for the lambda function"
}
variable "lambdas" {
  default = []
  type    = list(string)
}

variable "lambda_period" {
  default     = 300
  type        = number
  description = "The period of the alarm"

}
variable "lambda_threshold" {
  default     = 1
  type        = number
  description = "The threshold of the alarm"

}
variable "lambda_errors_threshold" {
  default     = 1
  type        = number
  description = "The threshold of the alarm"

}

variable "ses_domain" {
  description = "A map of SES domain configurations."
  type = map(object({
    topic_arn                  = string
    notification_type          = list(string)
    ses_domain_name            = string
    ses_domain_identity_policy = any
    ses_identity_policy_name   = string
  }))
  default = {}
}

variable "ses_emails" {
  description = "A list of email addresses to verify in SES"
  type        = list(string)
  default     = []
}

variable "ses_email_identity_policy" {
  description = "A list of IAM policies (in JSON) for each SES email identity"
  type        = list(any)
  default     = []
}
variable "da_glue_jobs" {
  description = "glue jobs for data analytics"
  type = map(object({

    name                    = string
    description             = optional(string, "")
    max_retries             = optional(number, 0)
    timeout                 = optional(number, 480)
    max_concurrent_runs     = optional(number, 1)
    command_name            = optional(string, "glueetl")
    glue_version            = optional(string, "5.0")
    job_run_queuing_enabled = optional(bool, false)
    python_version          = optional(string, "3")
    execution_class         = optional(string, "STANDARD")
    worker_type             = optional(string, "G.1X")
    max_capacity            = optional(number, null)
    number_of_workers       = optional(number, 2)
    use_connections         = optional(bool, false)
    connection_keys         = optional(list(string), [])
    maintenance_window      = optional(string, null)
    security_configuration  = optional(string, null)
    config_path             = string
    file                    = string
  }))
  default = {}
}
variable "project_version" {
  description = "The version of the project"
  type        = string
  default     = "v1"
}
variable "region_suffix" {
  description = "The suffix for the region, used in resource names"
  type        = string
  default     = "ec1"

}
variable "cw_log_retention_days" {
  description = "The number of days to retain CloudWatch logs"
  type        = number
  default     = 90

}
variable "create_da_stf" {
  description = "Whether to create a step function for data analytics"
  type        = bool
  default     = false
}

variable "x_ray_tracing" {
  description = "Enable X-Ray tracing for the Lambda functions"
  type        = bool
  default     = true

}
variable "stf_log_level" {
  description = "The log level for the step function"
  type        = string
  default     = "ALL"
}
variable "stf_enable_logging" {
  description = "Enable logging for the step function"
  type        = bool
  default     = true

}
variable "stf_include_execution_data" {
  description = "Include execution data in the step function logs"
  type        = bool
  default     = true

}
variable "da_sns_endpoint" {
  description = "The SNS endpoint for data analytics step function"
  type        = list(string)
  default     = []

}
variable "da_lambda_src_dir" {
  description = "The source directory for the data analytics Lambda functions"
  type        = string
  default     = "./da_resources"

}
variable "da_lambda_output_path" {
  description = "The output path for the data analytics Lambda functions"
  type        = string
  default     = "lambda_function.zip"
}
variable "da_lambda_runtime" {
  description = "The runtime for the Lambda functions"
  type        = string
  default     = "python3.12"
}
variable "da_lambda_handler" {
  description = "The handler for the Lambda functions"
  type        = string
  default     = "lambda_function.lambda_handler"

}
variable "da_timeout" {
  description = "The timeout for the Lambda functions in seconds"
  type        = number
  default     = 15

}
variable "da_instance_type" {
  description = "The instance type for the Glue jobs"
  type        = string
  default     = "t3a.2xlarge"

}
variable "da_ami_id" {
  description = "The AMI ID for the Glue jobs"
  type        = string
  default     = "ami-03250b0e01c28d196"

}
variable "da_ssh_pub_key" {
  description = "The SSH public key for the Glue jobs"
  type        = string
  default     = ""

}
variable "da_enable_ebs_volume" {
  description = "Enable EBS volume for the Glue jobs"
  type        = bool
  default     = true

}
variable "da_ebs_volume_size" {
  description = "Size of the EBS volume for the Glue jobs in GB"
  type        = number
  default     = 20

}
variable "da_ebs_type" {
  description = "Type of the EBS volume for the Glue jobs"
  type        = string
  default     = "gp3"

}
variable "ps_role_arn" {
  type        = string
  description = "The ARN of the IAM role for the post signup trigger Lambda function"
  default     = ""
}

variable "ps_image_uri" {
  type        = string
  description = "The image URI for the post signup trigger Lambda function"
  default     = ""
}

variable "ps_db_data_migration_sqs_queue_url" {
  type        = string
  description = "The SQS queue URL for DB data migration"
  default     = ""
}
variable "da_ebs_encrypted" {
  type        = bool
  description = "Whether the EBS volume for the Glue jobs should be encrypted"
  default     = false
}
variable "da_root_block_device_encrypted" {
  type        = bool
  description = "Whether the root block device for the Glue jobs should be encrypted"
  default     = false

}
variable "ARGUN_AUTH_TOKEN" {
  type        = string
  description = "The authentication token for AGRUN"
}
variable "API_ENDPOINT" {
  type        = string
  description = "The API endpoint for AGRUN"

}
variable "DBMS_AUTH_TOKEN" {
  type        = string
  description = "The authentication token for DBMS"

}
variable "ETL_AUTH_TOKEN" {
  type        = string
  description = "The authentication token for ETL"


}
variable "INTEG_AUTH_TOKEN" {
  type        = string
  description = "The authentication token for INTEG"

}
variable "SCH_AUTH_TOKEN" {
  type        = string
  description = "The authentication token for SCH"
}
variable "da_subnet_id" {
  description = "subnet ID for the Glue jobs"
  type        = string
  default     = ""

}
variable "glue_connection_subnet_id" {
  description = "subnet ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "glue_connection_c4_sg_id" {
  description = "security group ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "glue_connection_c5_sg_id" {
  description = "security group ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "glue_connection_c6_sg_id" {
  description = "security group ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "glue_connection_c13_sg_id" {
  description = "security group ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "glue_connection_c14_sg_id" {
  description = "security group ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "glue_connection_common_sg_id" {
  description = "security group ID for the Glue data connection"
  type        = string
  default     = ""

}
variable "c4_jdbc_host" {
  description = "JDBC host for the C4 database"
  type        = string
  default     = ""
}
variable "c5_jdbc_host" {
  description = "JDBC host for the C5 database"
  type        = string
  default     = ""
}
variable "c6_jdbc_host" {
  description = "JDBC host for the C5 database"
  type        = string
  default     = ""
}
variable "c13_jdbc_host" {
  description = "JDBC host for the C5 database"
  type        = string
  default     = ""
}
variable "c14_jdbc_host" {
  description = "JDBC host for the C5 database"
  type        = string
  default     = ""
}
variable "common_jdbc_host" {
  description = "JDBC host for the Common database"
  type        = string
  default     = ""
}
variable "C4_DB_PASSWORD" {
  type        = string
  description = "The password for the C4 database"
  default     = ""

}
variable "C5_DB_PASSWORD" {
  type        = string
  description = "The password for the C5 database"
  default     = ""

}
variable "C6_DB_PASSWORD" {
  type        = string
  description = "The password for the C6 database"
  default     = ""

}
variable "C13_DB_PASSWORD" {
  type        = string
  description = "The password for the C6 database"
  default     = ""

}
variable "C14_DB_PASSWORD" {
  type        = string
  description = "The password for the C6 database"
  default     = ""

}
variable "COMMON_DB_PASSWORD" {
  type        = string
  description = "The password for the Common database"
  default     = ""

}
variable "OPENAI_API_KEY" {
  type        = string
  description = "The username for the databases"
  default     = ""
}