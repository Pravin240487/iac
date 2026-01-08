data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

module "lambda_security_group" {
  source              = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sg?archive=zip"
  security_group_name = var.lambda_security_group
  vpc_id              = data.aws_vpc.this.id
  ingress = {
    ingress3003 = {
      protocol    = "tcp"
      from_port   = 3003
      to_port     = 3003
      cidr_blocks = [data.aws_vpc.this.cidr_block]
    }
  }
  egress = {
    egress = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = var.tags
}

module "iam_policy" {
  source                = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//iampolicy?archive=zip"
  for_each              = var.iam_policies
  iam_policy_name       = each.value.name
  iam_policy_name_desc  = each.value.description
  iam_policy_statements = each.value.statements
}

module "iam_role" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//iam?archive=zip"
  role       = var.iam_role
  depends_on = [module.iam_policy]
}

data "aws_security_groups" "lambda" {
  for_each = var.lambda
  filter {
    name   = "group-name"
    values = each.value.security_group_name
  }
  depends_on = [module.lambda_security_group]
}

data "aws_subnets" "this_lambda" {
  for_each = var.lambda
  filter {
    name   = "tag:Name"
    values = each.value.subnet_name
  }
}

module "lambda" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//lambda/image?archive=zip"
  for_each = var.lambda

  lambda = {
    "${each.key}" = merge(
      each.value,
      {
        subnet_ids         = data.aws_subnets.this_lambda[each.key].ids,
        security_group_ids = data.aws_security_groups.lambda[each.key].ids,
        tags               = each.value.tags,
        # special case for internal API proxy
        variables = can(regex("qs-${var.environment}-ec1-internal-api-proxy-lambda-*", each.value.function_name)) ? {
          ACTION           = "api"
          AGRUN_AUTH_TOKEN = var.ARGUN_AUTH_TOKEN
          API_ENDPOINT     = var.API_ENDPOINT
          DBMS_AUTH_TOKEN  = var.DBMS_AUTH_TOKEN
          ETL_AUTH_TOKEN   = var.ETL_AUTH_TOKEN
          INTEG_AUTH_TOKEN = var.INTEG_AUTH_TOKEN
          SCH_AUTH_TOKEN   = var.SCH_AUTH_TOKEN
          LAMBDA_TYPE      = "etl"
        } : each.value.variables
      }
    )
  }
  depends_on = [module.iam_role]
}

module "lambda_zip" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//lambda/zip?archive=zip"
  lambda     = var.lambda_zip
  depends_on = [module.iam_role]
}

module "sqs" {
  source     = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//sqs?archive=zip"
  sqs        = var.sqs
  depends_on = [module.lambda]
}

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = module.sqs.arn["sqs001"]
  function_name    = var.lambda["lambda002"]["function_name"]
  depends_on       = [module.sqs]
}

resource "aws_lambda_permission" "allow_sqs" {
  statement_id  = "AllowSQSToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda["lambda002"]["function_name"]
  principal     = "sqs.amazonaws.com"
  source_arn    = module.sqs.arn["sqs001"]
  depends_on    = [module.sqs]
}

resource "aws_lambda_event_source_mapping" "queue_handler" {
  event_source_arn = module.sqs.arn["sqs003"]
  function_name    = var.lambda_zip["lambda01"]["function_name"]
  depends_on       = [module.sqs, module.lambda_zip]
}
resource "aws_lambda_permission" "queue_handler" {
  statement_id  = "AllowSQSToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_zip["lambda01"]["function_name"]
  principal     = "sqs.amazonaws.com"
  source_arn    = module.sqs.arn["sqs003"]
  depends_on    = [module.sqs, module.lambda_zip]
}

resource "aws_lambda_event_source_mapping" "queue_handler_dlq" {
  event_source_arn = module.sqs.dlq_arn["sqs003"]
  function_name    = var.lambda_zip["lambda01"]["function_name"]
  depends_on       = [module.sqs, module.lambda_zip]
}
resource "aws_lambda_permission" "queue_handler_dlq" {
  statement_id  = "AllowSQSDLQToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_zip["lambda01"]["function_name"]
  principal     = "sqs.amazonaws.com"
  source_arn    = module.sqs.dlq_arn["sqs003"]
  depends_on    = [module.sqs, module.lambda_zip]
}

resource "aws_lambda_event_source_mapping" "glue" {
  count            = var.environment != "dev" && var.environment != "test" && var.environment != "stg" && var.environment != "prd" ? 1 : 0
  event_source_arn = module.sqs.arn["sqs003"]
  function_name    = var.lambda["lambda006"]["function_name"]
  depends_on       = [module.sqs]
}
resource "aws_lambda_permission" "glue" {
  count         = var.environment != "dev" && var.environment != "test" && var.environment != "stg" && var.environment != "prd" ? 1 : 0
  statement_id  = "AllowSQSToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda["lambda006"]["function_name"]
  principal     = "sqs.amazonaws.com"
  source_arn    = module.sqs.arn["sqs003"]
  depends_on    = [module.sqs]
}

resource "aws_lambda_event_source_mapping" "glue_dlq" {
  count            = var.environment != "dev" && var.environment != "test" && var.environment != "stg" && var.environment != "prd" ? 1 : 0
  event_source_arn = module.sqs.dlq_arn["sqs003"]
  function_name    = var.lambda["lambda006"]["function_name"]
  depends_on       = [module.sqs]
}
resource "aws_lambda_permission" "glue_dlq" {
  count         = var.environment != "dev" && var.environment != "test" && var.environment != "stg" && var.environment != "prd" ? 1 : 0
  statement_id  = "AllowSQSDLQToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda["lambda006"]["function_name"]
  principal     = "sqs.amazonaws.com"
  source_arn    = module.sqs.dlq_arn["sqs003"]
  depends_on    = [module.sqs]
}

resource "aws_lambda_permission" "observability_sqs_handler" {
  statement_id  = "AllowSQSDLQToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda["lambda007"]["function_name"]
  principal     = "sqs.amazonaws.com"
  source_arn    = module.sqs.arn["sqs004"]
  depends_on    = [module.sqs]
}


module "sf" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//stepfunction?archive=zip"
  for_each    = var.sfn
  sf_name     = each.value.name
  sf_role_arn = each.value.role_arn
  //  state_machine_definition = each.value.api_endpoint ? each.value.state_machine_definition : local.state_machine_definition_with_endpoint[each.key]
  state_machine_definition = each.value.state_machine_definition
  log_group_name           = each.value.log_group_name
  include_execution_data   = each.value.include_execution_data
  level                    = each.value.level
  depends_on               = [module.iam_role]
}

module "random" {
  for_each = { for k, v in var.secret : v.connection_name => v }
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//random?archive=zip"
}

module "secret" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//secret?archive=zip"
  for_each    = { for k, v in var.secret : v.connection_name => v }
  secret_name = each.value.secret_name
  secret_keys = {
    "username" = each.value.username
    "password" = module.random[each.key].random_string
  }
}

data "aws_db_instance" "glue_rds_connection" {
  for_each               = var.environment != "stg" ? { for k, v in var.data_connection : v.connection_name => v } : {}
  db_instance_identifier = each.value.rds_cluster_name
}

data "aws_security_groups" "this" {
  for_each = { for k, v in var.data_connection : v.connection_name => v }
  filter {
    name   = "group-name"
    values = [each.value.security_group_rds]
  }
}

data "aws_subnets" "this" {
  for_each = { for k, v in var.data_connection : v.connection_name => v }
  filter {
    name   = "tag:Name"
    values = [each.value.glue_subnets_name]
  }
}

data "aws_db_instance" "shared_rds" {
  count                  = var.environment == "stg" ? 1 : 0
  db_instance_identifier = "qs-stg-ec1-shared-rds-v1"
}

data "aws_security_groups" "shared_rds" {
  count = var.environment == "stg" ? 1 : 0
  filter {
    name   = "group-id"
    values = data.aws_db_instance.shared_rds[0].vpc_security_groups
  }
}

module "glue_connection" {
  source                 = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//etl_glue/glue_connection?archive=zip"
  for_each               = { for k, v in var.data_connection : v.connection_name => v }
  jdbc_connection_url    = each.key == "qs-stg-ec1-customer0012-glue-v1" ? "jdbc:postgresql://qs-stg-ec1-customer0012-rds-v1.cbk2ogcwaxfa.eu-central-1.rds.amazonaws.com:5432/masterdb" : var.environment == "stg" ? "jdbc:postgresql://qs-stg-ec1-shared-rds-v1.cbk2ogcwaxfa.eu-central-1.rds.amazonaws.com:5432/masterdb" : "jdbc:${each.value.database_type}://${data.aws_db_instance.glue_rds_connection[each.key].endpoint}/${each.value.database_name}"
  secret_id              = module.secret[each.key].arn
  connection_name        = each.value.connection_name
  availability_zone      = each.value.availability_zone
  security_group_id_list = var.environment == "stg" && each.key == "qs-stg-ec1-customer0012-glue-v1" ? ["sg-0282642d5d58af37e"] : var.environment == "stg" ? data.aws_security_groups.shared_rds[0].ids : data.aws_security_groups.this[each.key].ids
  subnet_id              = data.aws_subnets.this[each.key].ids[0]
  depends_on             = [module.secret]
}

module "glue" {
  source                    = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//etl_glue/etl_job?archive=zip"
  for_each                  = var.glue_jobs
  connections               = each.value.connections_use ? flatten([for conn_name in each.value.connection_name : module.glue_connection[conn_name].glue_connection_name]) : []
  default_arguments         = each.value.default_arguments
  description               = each.value.description
  execution_class           = each.value.execution_class
  glue_version              = each.value.glue_version
  job_run_queuing_enabled   = each.value.job_run_queuing_enabled
  maintenance_window        = each.value.maintenance_window
  max_retries               = each.value.max_retries
  name                      = each.value.name
  non_overridable_arguments = each.value.non_overridable_arguments
  role_arn                  = each.value.role_arn
  security_configuration    = each.value.security_configuration
  tags                      = each.value.tags
  timeout                   = each.value.timeout
  worker_type               = each.value.worker_type
  command_name              = each.value.command_name
  python_version            = each.value.python_version
  script_location           = each.value.script_location
  max_concurrent_runs       = each.value.max_concurrent_runs
  depends_on                = [module.iam_role]
}

data "aws_sns_topic" "this" {
  for_each = var.alarms
  name     = each.value.sns_name
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
  alarm_actions             = [data.aws_sns_topic.this[each.key].arn]
  actions_enabled           = each.value.actions_enabled
  dimensions_list = merge(each.value.dimensions, {
    StateMachineArn = contains(keys(each.value.dimensions), "StateMachineArn") ? module.sf[each.value.dimensions.StateMachineArn].arn : null
  })
}
######################### Lambda for sqs to cloudwatch logs #########################
data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}
data "aws_security_group" "sg" {
  name = var.lambda_security_group
}

module "ses_domain" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/ses_domain/1.0.0"

  for_each                     = var.ses_domain
  topic_arn                    = each.value.topic_arn
  notification_type            = each.value.notification_type
  domain_name                  = each.value.ses_domain_name
  ses_domain_identity_policy   = jsonencode(each.value.ses_domain_identity_policy)
  aws_ses_identity_policy_name = each.value.ses_identity_policy_name
}

module "ses_email" {
  count  = var.environment != "prd" ? 1 : 0
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/ses_email/1.0.0"
  emails = var.ses_emails

  ses_email_identity_policy = [
    for policy in var.ses_email_identity_policy : jsonencode(policy)
  ]
}

resource "aws_lambda_function" "post_signup_trigger" {
  count = 1

  function_name = "qs-${var.environment}-ec1-post-signup-trigger-v3"
  role          = var.ps_role_arn
  package_type  = "Image"
  image_uri     = var.ps_image_uri


  environment {
    variables = {
      LAMBDA_TYPE                     = "post-signup-trigger"
      DB_DATA_MIGRATION_SQS_QUEUE_URL = var.ps_db_data_migration_sqs_queue_url
    }
  }

  memory_size = 128
  timeout     = 3

  architectures = ["x86_64"]
  tags = {
    Owner       = "Octonomy.devops@talentship.io"
    Terraformed = true
  }
}

# resource "aws_iam_role_policy_attachment" "lambda_sqs_cloudwatch_attach" {
#   policy_arn = module.lambda_sqs_cloudwatch_policy.arn
#   role       = module.cw_log_lambda.iam_role_name[0]
# }
# module "cw_metric_lambda" {
#   source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/lambda/1.0.0"
#   function_name = "qs-${var.environment}-ec1-cw-metric-sqs-lambda"
#   role_arn = module.cw_log_lambda.iam_role_arn[0]
#   create_ecr_lambda = var.create_ecr_lambda
#   create_iam_role = var.create_iam_role
#   create_event_source_mapping = var.create_event_source_mapping
#   image_uri = var.image_uri
#   subnet_ids = [data.aws_subnet.subnet.id]
#   security_group_ids = [data.aws_security_group.sg.id]
#   event_source_arn = module.cw_metric_sqs.sqs_arn


#   environment_variables = {
#     "SQS_QUEUE_URL" = "${module.cw_metric_sqs.sqs_id}"
#     "CLOUDWATCH_METRIC_NAMESPACE" = "Octonomy"
#     "VERSION" = "v1"
#     "ACTION" = "cloudWatchMetric"
#   }
#   tags = var.tags
# }
########################################################
module "da_s3_resources" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/s3/1.0.0"
  bucket_name = "oc-${var.environment}-${var.region_suffix}-da-resources-s3-${var.project_version}"
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_s3_assets" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/s3/1.0.0"
  bucket_name = "oc-${var.environment}-${var.region_suffix}-da-assets-s3-${var.project_version}"
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_glue_iam_policy" {
  source               = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"
  iam_policy_name      = "oc-${var.environment}-${var.region_suffix}-da-glue-iam-policy-${var.project_version}"
  iam_policy_name_desc = "policy for data analytics glue jobs"
  iam_policy_statements = [
    {
      "Sid" : "AllowS3Access",
      "Effect" : "Allow",
      "Action" : [
        "s3:*"
      ],
      "Resource" : [
        "${module.da_s3_assets[count.index].arn}", "${module.da_s3_assets[count.index].arn}/*", "${module.da_s3_resources[count.index].arn}", "${module.da_s3_resources[count.index].arn}/*"
      ]
    },
    {
      "Sid" : "AllowGlueUsage",
      "Effect" : "Allow",
      "Action" : [
        "glue:GetJobRun",
        "glue:GetJob",
        "glue:GetTable",
        "glue:GetDatabase",
        "glue:GetConnection"
      ],
      "Resource" : ["*"]
    },
    {
      "Sid" : "AllowLogs",
      "Effect" : "Allow",
      "Action" : [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource" : ["*"]
    },
    {
      "Sid" : "AllowSecretsManager",
      "Effect" : "Allow",
      "Action" : [
        "secretsmanager:GetSecretValue"
      ],
      "Resource" : ["arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:*"]
    },
    {
      "Sid" : "RDSAccess",
      "Effect" : "Allow",
      "Action" : [
        "rds:*",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeCoipPools",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeLocalGatewayRouteTablePermissions",
        "ec2:DescribeLocalGatewayRouteTables",
        "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
        "ec2:DescribeLocalGateways",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcAttribute",
        "ec2:DescribeVpcs"
      ],
      "Resource" : ["*"]
    },
    {
      "Sid" : "AllowEC2NetworkInterfaces",
      "Effect" : "Allow",
      "Action" : [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:AssignPrivateIpAddresses",
        "ec2:UnassignPrivateIpAddresses"
      ],
      "Resource" : ["*"]
    },
    {
      "Sid" : "AllowVpcEndpointValidation",
      "Effect" : "Allow",
      "Action" : [
        "ec2:DescribeVpcEndpoints",
        "ec2:DescribeRouteTables"
      ],
      "Resource" : ["*"]
    },
    {
      "Sid" : "AllowLambdaAccess",
      "Effect" : "Allow",
      "Action" : [
        "lambda:*"
      ],
      "Resource" : ["*"]
    }
  ]
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_glue_iam" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = "oc-${var.environment}-${var.region_suffix}-da-glue-iam-${var.project_version}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "glue.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  iam_role_policy_attachments = [module.da_glue_iam_policy[count.index].arn, "arn:aws:iam::aws:policy/AmazonVPCFullAccess"]
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_stf_iam_policy" {
  source               = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"
  iam_policy_name      = "oc-${var.environment}-${var.region_suffix}-da-stf-iam-policy-${var.project_version}"
  iam_policy_name_desc = "policy for data analytics step function"
  iam_policy_statements = [
    {
      "Sid" : "StartGlueJobs",
      "Effect" : "Allow",
      "Action" : [
        "glue:StartJobRun",
        "glue:GetJobRun"
      ],
      "Resource" : "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:job/*"
    },
    {
      "Sid" : "CloudWatchLogs",
      "Effect" : "Allow",
      "Action" : [
        "logs:*"
      ],
      "Resource" : "*"
    },
    {
      "Sid" : "SNS",
      "Effect" : "Allow",
      "Action" : [
        "sns:*"
      ],
      "Resource" : "*"
    },
    {
      "Sid" : "AllowXRayTracing",
      "Effect" : "Allow",
      "Action" : [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ],
      "Resource" : "*"
    },
    {
      "Sid" : "state",
      "Effect" : "Allow",
      "Action" : [
        "states:*"
      ],
      "Resource" : "*"
    },
    {
      "Sid" : "AllowCloudWatchEvents",
      "Effect" : "Allow",
      "Action" : [
        "events:PutRule",
        "events:PutTargets",
        "events:DescribeRule"
      ],
      "Resource" : "arn:aws:events:${var.region}:${data.aws_caller_identity.current.account_id}:rule/StepFunctionsGetEventsFor*"
    },
    {
      "Sid" : "AllowPassRoleForCloudWatchLogs",
      "Effect" : "Allow",
      "Action" : [
        "iam:PassRole"
      ],
      "Resource" : "*"
    },
    {
      "Sid" : "AllowLambdaInvoke",
      "Effect" : "Allow",
      "Action" : [
        "lambda:InvokeFunction"
      ],
      "Resource" : "*"
    },
    {
      "Sid" : "S3",
      "Effect" : "Allow",
      "Action" : [
        "s3:*"
      ],
      "Resource" : "*"
    },
  ]
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_stf_iam" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = "oc-${var.environment}-${var.region_suffix}-da-stf-iam-${var.project_version}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "states.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  iam_role_policy_attachments = [module.da_stf_iam_policy[count.index].arn]
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
#######################da glue jobs #################################

module "da_secret_c4" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-c4-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    host      = var.environment == "stg" || var.environment == "prd" ? var.c4_jdbc_host : var.common_jdbc_host
    password  = var.environment == "dev" ? var.COMMON_DB_PASSWORD : var.C4_DB_PASSWORD
    port      = 5432
    tenant_id = "customer0004"
    username  = var.environment == "stg" ? "stg_read_user" : var.environment == "prd" ? "customer0004_read_user" : "readuser"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_c5" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-c5-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    host      = var.environment == "stg" || var.environment == "prd" ? var.c5_jdbc_host : var.common_jdbc_host
    password  = var.environment == "dev" ? var.COMMON_DB_PASSWORD : var.C5_DB_PASSWORD
    port      = 5432
    tenant_id = "customer0005"
    username  = var.environment == "dev" ? "readuser" : "customer0005_read_user"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_c13" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-c13-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    host      = var.environment == "stg" || var.environment == "prd" ? var.c13_jdbc_host : var.common_jdbc_host
    password  = var.environment == "dev" ? var.COMMON_DB_PASSWORD : var.C13_DB_PASSWORD
    port      = 5432
    tenant_id = "customer0013"
    username  = var.environment == "dev" ? "readuser" : "customer0013_read_user"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_c6" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-c6-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    host      = var.environment == "stg" || var.environment == "prd" ? var.c6_jdbc_host : var.common_jdbc_host
    password  = var.environment == "dev" ? var.COMMON_DB_PASSWORD : var.C6_DB_PASSWORD
    port      = 5432
    tenant_id = "customer0006"
    username  = var.environment == "dev" ? "readuser" : "customer0006_read_user"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_common" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-common-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    host      = var.common_jdbc_host
    password  = var.COMMON_DB_PASSWORD
    port      = 5432
    tenant_id = "common"
    username  = var.environment != "prd" ? "readuser" : "common_read_user"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_openai" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-openai-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    AZURE_OPENAI_API_KEY     = ""
    AZURE_OPENAI_ENDPOINT    = ""
    AZURE_OPENAI_API_VERSION = "2025-04-01-preview"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_taxanomy" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-taxanomy-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    OPENAI_API_KEY = var.OPENAI_API_KEY
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_secret_c14" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/secret-manager/1.0.0"
  secret_name        = "oc-${var.environment}-${var.region_suffix}-da-secrets-c14-${var.project_version}"
  secret_description = "secrets for data analytics"
  secret_keys = {
    host      = var.environment == "stg" || var.environment == "prd" ? var.c14_jdbc_host : var.common_jdbc_host
    password  = var.environment == "dev" ? var.COMMON_DB_PASSWORD : var.C14_DB_PASSWORD
    port      = 5432
    tenant_id = "customer0014"
    username  = var.environment == "dev" ? "readuser" : "customer0014_read_user"
  }
  count = var.create_da_stf ? 1 : 0
}
module "glue_jobs_connection_c4" {
  source          = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"
  connection_name = "oc-${var.environment}-${var.region_suffix}-glue-connection-c4-${var.project_version}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${var.environment == "dev" ? var.common_jdbc_host : var.c4_jdbc_host}/customer0004:5432"
    SECRET_ID           = module.da_secret_c4[count.index].secret_arn
  }

  physical_connection_requirements = {
    availability_zone      = "eu-central-1a"
    subnet_id              = var.glue_connection_subnet_id
    security_group_id_list = var.environment == "stg" || var.environment == "prd" ? [var.glue_connection_c4_sg_id] : [var.glue_connection_common_sg_id]
  }
  tags  = var.tags
  count = var.create_da_stf ? 1 : 0
}
module "glue_jobs_connection_c5" {
  source          = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"
  connection_name = "oc-${var.environment}-${var.region_suffix}-glue-connection-c5-${var.project_version}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${var.environment == "dev" ? var.common_jdbc_host : var.c5_jdbc_host}/customer0005:5432"
    SECRET_ID           = module.da_secret_c5[count.index].secret_arn
  }

  # Network configuration for secure database access
  physical_connection_requirements = {
    availability_zone      = "eu-central-1a"
    subnet_id              = var.glue_connection_subnet_id
    security_group_id_list = var.environment == "stg" || var.environment == "prd" ? [var.glue_connection_c5_sg_id] : [var.glue_connection_common_sg_id]
  }
  tags  = var.tags
  count = var.create_da_stf ? 1 : 0
}
module "glue_jobs_connection_c6" {
  source          = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"
  connection_name = "oc-${var.environment}-${var.region_suffix}-glue-connection-c6-${var.project_version}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${var.environment == "dev" ? var.common_jdbc_host : var.c6_jdbc_host}/customer0006:5432"
    SECRET_ID           = module.da_secret_c6[count.index].secret_arn
  }

  # Network configuration for secure database access
  physical_connection_requirements = {
    availability_zone      = "eu-central-1a"
    subnet_id              = var.glue_connection_subnet_id
    security_group_id_list = var.environment == "stg" || var.environment == "prd" ? [var.glue_connection_c6_sg_id] : [var.glue_connection_common_sg_id]
  }
  tags  = var.tags
  count = var.create_da_stf ? 1 : 0
}
module "glue_jobs_connection_c13" {
  source          = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"
  connection_name = "oc-${var.environment}-${var.region_suffix}-glue-connection-c13-${var.project_version}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${var.environment == "dev" ? var.common_jdbc_host : var.c13_jdbc_host}/customer0013:5432"
    SECRET_ID           = module.da_secret_c13[count.index].secret_arn
  }

  # Network configuration for secure database access
  physical_connection_requirements = {
    availability_zone      = "eu-central-1a"
    subnet_id              = var.glue_connection_subnet_id
    security_group_id_list = var.environment == "stg" || var.environment == "prd" ? [var.glue_connection_c13_sg_id] : [var.glue_connection_common_sg_id]
  }
  tags  = var.tags
  count = var.create_da_stf ? 1 : 0
}
module "glue_jobs_connection_common" {
  source          = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"
  connection_name = "oc-${var.environment}-${var.region_suffix}-glue-connection-common-${var.project_version}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${var.common_jdbc_host}/common:5432"
    SECRET_ID           = module.da_secret_common[count.index].secret_arn
  }

  # Network configuration for secure database access
  physical_connection_requirements = {
    availability_zone      = "eu-central-1a"
    subnet_id              = var.glue_connection_subnet_id
    security_group_id_list = [var.glue_connection_common_sg_id]
  }
  tags  = var.tags
  count = var.create_da_stf ? 1 : 0
}
module "glue_jobs_connection_c14" {
  source          = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"
  connection_name = "oc-${var.environment}-${var.region_suffix}-glue-connection-c14-${var.project_version}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://${var.environment == "dev" ? var.common_jdbc_host : var.c14_jdbc_host}/customer0014:5432"
    SECRET_ID           = module.da_secret_c14[count.index].secret_arn
  }

  # Network configuration for secure database access
  physical_connection_requirements = {
    availability_zone      = "eu-central-1a"
    subnet_id              = var.glue_connection_subnet_id
    security_group_id_list = var.environment == "stg" || var.environment == "prd" ? [var.glue_connection_c14_sg_id] : [var.glue_connection_common_sg_id]
  }
  tags  = var.tags
  count = var.create_da_stf ? 1 : 0
}

module "da_dashboard_etl" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-job/1.0.0"
  for_each = var.da_glue_jobs

  # Job Identification and Metadata
  name            = "oc-${var.environment}-${var.region_suffix}-glue-job-${each.value.name}-${var.project_version}"
  description     = "data analytics glue job ${each.value.description}"
  role_arn        = module.da_glue_iam[0].arn
  script_location = each.value.config_path == "bronze" ? "s3://${module.da_s3_resources[0].id}/glue_job_scripts/rds_standard_bronze.py" : (each.value.config_path == "silver" || each.value.config_path == "taxonomy_config/flatten") ? "s3://${module.da_s3_resources[0].id}/glue_job_scripts/rds_standard_silver.py" : each.value.config_path == "taxonomy_config/creation" ? "s3://${module.da_s3_resources[0].id}/glue_job_scripts/taxonomy_batch_creation.py" : each.value.config_path == "taxonomy_config/process" ? "s3://${module.da_s3_resources[0].id}/glue_job_scripts/taxonomy_batch_process.py" : each.value.config_path == "DevOps" ? "s3://oc-${var.environment}-ec1-devops-s3-v1/data_analytics/db_data_dump_restore.py" : "s3://${module.da_s3_resources[0].id}/glue_job_scripts/rds_conversation_grouping.py"

  # Job Execution Configuration
  command_name   = each.value.command_name
  python_version = each.value.python_version
  glue_version   = each.value.glue_version

  # Resource and Performance
  worker_type             = each.value.worker_type
  max_capacity            = each.value.max_capacity
  max_concurrent_runs     = each.value.max_concurrent_runs
  max_retries             = each.value.max_retries
  timeout                 = each.value.timeout
  number_of_workers       = each.value.number_of_workers
  execution_class         = each.value.execution_class
  job_run_queuing_enabled = each.value.job_run_queuing_enabled
  maintenance_window      = each.value.maintenance_window
  security_configuration  = each.value.security_configuration
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }

  # Job Runtime Arguments
  default_arguments = {
    "--extra-jars"                       = "s3://${module.da_s3_resources[0].id}/jdbc_jar/postgresql-42.7.6.jar"
    "--additional-python-modules"        = "s3://${module.da_s3_resources[0].id}/octonomy_analytical_etl-0.1.0-py3-none-any.whl"
    "--enable-metrics"                   = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--TempDir"                          = "s3://${module.da_s3_assets[0].id}/temporary"
    "--conf"                             = "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog --conf spark.delta.logStore.class=org.apache.spark.sql.delta.storage.S3SingleDriverLogStore"
    "--datalake-formats"                 = "delta"
    "--config_path"                      = "s3://${module.da_s3_resources[0].id}/metadata_config/${each.value.config_path == "grouping" ? "bronze" : each.value.config_path}/${each.value.file}"
    "--env"                              = var.environment
  }

  connections = ["oc-${var.environment}-${var.region_suffix}-glue-connection-c6-${var.project_version}", "oc-${var.environment}-${var.region_suffix}-glue-connection-c5-${var.project_version}", "oc-${var.environment}-${var.region_suffix}-glue-connection-c4-${var.project_version}", "oc-${var.environment}-${var.region_suffix}-glue-connection-common-${var.project_version}", "oc-${var.environment}-${var.region_suffix}-glue-connection-c13-${var.project_version}", "oc-${var.environment}-${var.region_suffix}-glue-connection-c14-${var.project_version}"]

}
################### master data stf #######################
module "da-master-data-load-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-master-data-load-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0

}
module "da_master_data_load_stf" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name                   = "oc-${var.environment}-${var.region_suffix}-da-master-data-load-stf-${var.project_version}"
  role_arn               = module.da_stf_iam[count.index].arn
  definition             = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-master-data-load-stf-${var.project_version}.json")
  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data # Include input/output data in logs for debugging
  log_destination        = "${module.da-master-data-load-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing # Enable AWS X-Ray tracing for performance analysis
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
################### rds bronze stf #######################
module "da-rds-bronze-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-rds-bronze-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-rds-bronze" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-rds-bronze-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-rds-bronze-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-rds-bronze-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
################### rds silver stf #######################
module "da-rds-silver-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-rds-silver-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-rds-silver_stf" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-rds-silver-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-rds-silver-stf-${var.project_version}.json")

  # Comprehensive logging and monitoring configuration
  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-rds-silver-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

################### intent processing stf #######################
module "da-intent-processing-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-intent-processing-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-intent-processing" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-intent-processing-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-intent-processing-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-intent-processing-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

################### topic processing stf #######################
module "da-topic-processing-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-topic-processing-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-topic-processing" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-topic-processing-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-topic-processing-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-topic-processing-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

################### gap processing stf #######################
module "da-gap-processing-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-gap-processing-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-gap-processing" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-gap-processing-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-gap-processing-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-gap-processing-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

################### flattening stf #######################
module "da-flattening-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-flattening-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
module "da-flattening" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-flattening-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-flattening-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-flattening-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

################### batch creation stf #######################
module "da-batch-creation-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-batch-creation-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-batch-creation" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-batch-creation-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-batch-creation-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-batch-creation-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
################### batch creation stf #######################
module "da-silver-state-execution-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-rds-silver-state-execution-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}

module "da-silver-state-execution" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name       = "oc-${var.environment}-${var.region_suffix}-da-rds-silver-state-execution-stf-${var.project_version}"
  role_arn   = module.da_stf_iam[count.index].arn
  definition = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-rds-silver-state-execution-stf-${var.project_version}.json")

  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data
  log_destination        = "${module.da-batch-creation-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
################### conversation delta stf #######################
module "da-conversation-delta-stf-logs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name    = "oc-${var.environment}-${var.region_suffix}-da-conversation-delta-stf-${var.project_version}"
  retention_in_days = var.cw_log_retention_days
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0

}
module "da_conversation-delta_stf" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name                   = "oc-${var.environment}-${var.region_suffix}-da-conversation-delta-stf-${var.project_version}"
  role_arn               = module.da_stf_iam[count.index].arn
  definition             = file("${path.module}/sf_definition/oc-common-${var.region_suffix}-da-conversation-delta-stf-${var.project_version}.json")
  enable_logging         = var.stf_enable_logging
  log_level              = var.stf_log_level
  include_execution_data = var.stf_include_execution_data # Include input/output data in logs for debugging
  log_destination        = "${module.da-conversation-delta-stf-logs[count.index].arn}:*"
  enable_tracing         = var.x_ray_tracing # Enable AWS X-Ray tracing for performance analysis
  tags = {
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Octonomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
    "Environment" = var.environment
  }
  count = var.create_da_stf ? 1 : 0
}
############### DA SNS ######################
module "sns" {
  source            = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//messaging/sns/1.0.0"
  name              = "oc-${var.environment}-${var.region_suffix}-da-sns-alert-${var.project_version}"
  endpoint          = var.da_sns_endpoint
  kms_master_key_id = ""
  tags              = var.tags
  count             = var.create_da_stf ? 1 : 0
}
module "da_lambda" {
  source           = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/lambda/1.0.0"
  lambda_role_name = "oc-${var.environment}-${var.region_suffix}-da-lambda-iam-role"
  function_name    = "oc-${var.environment}-${var.region_suffix}-da-s3-prefix-lambda-${var.project_version}"
  source_dir       = var.da_lambda_src_dir
  output_path      = var.da_lambda_output_path
  timeout          = var.da_timeout
  lambda_runtime   = var.da_lambda_runtime
  lambda_handler   = var.da_lambda_handler
  tags = {
    "environment" = var.environment
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Ocotnomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"

  }
  count = var.create_da_stf ? 1 : 0
}
module "da_ec2_sg" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/security-group/1.0.0/"
  name   = "oc-${var.environment}-${var.region_suffix}-da-sg-${var.project_version}"
  vpc_id = data.aws_vpc.this.id
  tags = {
    "environment" = var.environment
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Ocotnomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
  }
  count = var.create_da_stf ? 1 : 0
}
module "efs_egress" {
  source            = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/egress-rule/1.0.0/"
  security_group_id = module.da_ec2_sg[count.index].id
  name              = "oc-${var.environment}-${var.region_suffix}-da-egress-${var.project_version}"
  description       = "egress rule for the da ec2"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    "environment" = var.environment
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Ocotnomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_ec2_ingress_8123" {
  source            = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0/"
  security_group_id = module.da_ec2_sg[count.index].id
  name              = "oc-${var.environment}-${var.region_suffix}-da-ingress-${var.project_version}"
  description       = "ingress rule for the da ec2"
  cidr_ipv4         = data.aws_vpc.this.cidr_block
  from_port         = 8123
  ip_protocol       = "tcp"
  to_port           = 8123
  tags = {
    "environment" = var.environment
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Ocotnomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_ec2_ingress_9000" {
  source            = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0/"
  security_group_id = module.da_ec2_sg[count.index].id
  name              = "oc-${var.environment}-${var.region_suffix}-da-ingress2-${var.project_version}"
  description       = "ingress rule for the da ec2"
  cidr_ipv4         = data.aws_vpc.this.cidr_block
  from_port         = 9000
  ip_protocol       = "tcp"
  to_port           = 9000
  tags = {
    "environment" = var.environment
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Ocotnomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
  }
  count = var.create_da_stf ? 1 : 0
}
module "da_ec2" {
  source                      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ec2/1.0.0"
  name                        = "oc-${var.environment}-${var.region_suffix}-da-ec2-${var.project_version}"
  instance_type               = var.da_instance_type
  ami                         = var.da_ami_id
  ssh_pub_key                 = var.da_ssh_pub_key
  subnet_id                   = var.da_subnet_id #public subnet
  security_group_ids          = [module.da_ec2_sg[count.index].id]
  enable_ebs_volume           = var.da_enable_ebs_volume
  ebs_volume_size             = var.da_ebs_volume_size
  encrypted                   = var.da_ebs_encrypted
  root_block_device_encrypted = var.da_root_block_device_encrypted
  ebs_type                    = var.da_ebs_type
  user_data                   = <<-EOF
#!/bin/bash
apt update -y
apt install -y docker.io docker-compose unzip

systemctl enable docker
systemctl start docker

DEVICE="/dev/nvme1n1"
MOUNT_POINT="/mnt/clickhouse"

if lsblk | grep -q "nvme1n1"; then
  if ! blkid $DEVICE; then
    mkfs.ext4 $DEVICE
  fi
  mkdir -p $MOUNT_POINT
  mount $DEVICE $MOUNT_POINT
  echo "$DEVICE $MOUNT_POINT ext4 defaults,nofail 0 2" >> /etc/fstab
fi

mkdir -p /opt/clickhouse
cat <<EOL > /opt/clickhouse/docker-compose.yml
version: '3.8'
services:
  clickhouse:
    image: clickhouse/clickhouse-server:latest
    container_name: clickhouse
    ports:
      - "8123:8123"
      - "9000:9000"
    volumes:
      - /mnt/clickhouse:/var/lib/clickhouse
    restart: unless-stopped
EOL

cd /opt/clickhouse
docker-compose up -d
EOF

  tags = {
    "environment" = var.environment
    "service"     = "da-analytics"
    "application" = "octonomy"
    "expirydate"  = "None"
    "Owner"       = "Ocotnomy.devops@talentship.io"
    "systemstate" = "active"
    "terraformed" = "true"
  }
  count = var.create_da_stf ? 1 : 0

}


