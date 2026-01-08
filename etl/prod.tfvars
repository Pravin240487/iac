key = "prod/etl/terraform.tfstate"

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
vpc_name               = "qs-prd-ec1-main-vpc-v1"
subnet_name            = "qs-prd-ec1-private-sne-lambda-01a-v1"
wss_alb_security_group = "prd-qs-nsg-wss-alb-01"
lambda_security_group  = "qs-prd-ec1-nsg-ETLlambda"

# #################################
# ######## IAM POLICY  ############
# #################################

iam_policies = {
  "iam_001" = {
    name        = "GlueJobRunManagementFullAccessPolicy_v1"
    description = "GlueJobRunManagementFullAccessPolicy"
    statements = [{
      Action = [
        "glue:StartJobRun",
        "glue:GetJobRun",
        "glue:GetJobRuns",
        "glue:BatchStopJobRun"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_002" = {
    name        = "XRayAccessPolicy_v1"
    description = "XRayAccessPolicy"
    statements = [{
      Action = [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords",
        "xray:GetSamplingRules",
        "xray:GetSamplingTargets"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_003" = {
    name        = "ETLApiProxyLambdaExecutionRoleDefaultPolicy-v1"
    description = "ETLApiProxyLambdaExecutionRoleDefaultPolicy-v1"
    statements = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-central-1:597088029926:log-group:/aws/lambda/*"]
      },
      {
        Action = [
          "ec2:AttachNetworkInterface",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DetachNetworkInterface",
          "ecr:GetAuthorizationToken"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:ecr:eu-central-1:597088029926:repository/qs-lambda/core"]
    }]
  }
  "iam_004" = {
    name        = "ETLExtractLambdaExecutionRoleDefaultPolicy-v1"
    description = "ETLExtractLambdaExecutionRoleDefaultPolicy-v1"
    statements = [{
      Action = [
        "execute-api:Invoke"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:execute-api:eu-central-1:597088029926:x997oqyuml/*/*/*"]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:logs:eu-central-1:597088029926:log-group:/aws/lambda/*"]
      },
      {
        Action = [
          "ec2:AttachNetworkInterface",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DetachNetworkInterface",
          "ecr:GetAuthorizationToken",
          "rds-db:connect",
          "rds:DescribeDBProxies",
          "rds:DescribeDBProxyTargets"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:ecr:eu-central-1:597088029926:repository/qs-lambda/core"]
      },
      {
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ReceiveMessage",
          "sqs:SendMessage",
          "lambda:InvokeFunction"
        ]
        Effect = "Allow"
        Resource = ["arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-incremental-dead-letter-sqs-v1",
          "arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-glue-job-sqs-v1",
          "arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-glue-job-sqs-dead-letter-sqs-v1"
        ]
      },
      {
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ReceiveMessage"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-full-load-dead-letter-sqs-v1",
          "arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-full-load-sqs-v1",
          "arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-incremental-load-sqs-v1"
          //"arn:aws:sqs:eu-central-1:597088029926:qs-prd-ec1-etl-partial-load-sqs-v1"
        ]
      },
      {
        Action = [
          "states:StartExecution"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-etl-full-load-stf-v1",
          "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-confluence-data-processing-stf-v1"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["lambda:InvokeFunction"]
        Resource = ["arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1"]
      }
    ]
  }
  "iam_005" = {
    name        = "ETLLambda-ecr-role-policy-v1"
    description = "ETLLambda-ecr-role-policy-v1"
    statements = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-central-1:597088029926:log-group:/aws/lambda/*"]
      },
      {
        Action = [
          "ec2:AttachNetworkInterface",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DetachNetworkInterface",
          "ecr:GetAuthorizationToken"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:ecr:eu-central-1:597088029926:repository/qs-lambda/core"]
      }
    ]
  }
  "iam_006" = {
    name        = "StepFunctionsRoleDefaultPolicy-v1"
    description = "StepFunctionsRoleDefaultPolicy-v1"
    statements = [{
      Action = [
        "execute-api:Invoke"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:execute-api:eu-central-1:597088029926:x997oqyuml/*"]
      },
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
          "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1:*"
        ]
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:ecr:eu-central-1:597088029926:repository/qs-lambda/core"]
      }
    ]
  }
  "iam_007" = {
    name        = "GrafanaCloudWatchLogs-ReadList-Access-v1"
    description = "GrafanaCloudWatchLogs-ReadList-Access-v1"
    statements = [{
      Action = [
        "xray:GetTraceGraph",
        "xray:GetServiceGraph",
        "logs:Describe*",
        "logs:List*",
        "logs:StartQuery",
        "cloudwatch:List*",
        "logs:StopQuery",
        "xray:GetInsightSummaries",
        "cloudwatch:Describe*",
        "logs:Get*",
        "xray:BatchGetTraces",
        "xray:GetTimeSeriesServiceStatistics",
        "logs:GetQueryResults",
        "xray:GetInsight",
        "cloudwatch:Get*",
        "logs:FilterLogEvents",
        "xray:GetTraceSummaries"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_008" = {
    name        = "Athena-s3-v1"
    description = "Athena-s3-v1"
    statements = [{
      Action = [
        "s3:List*",
        "s3:Get*",
        "s3:Describe*",
        "s3:Put*",
        "s3:Delete*"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucketVersions",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy",
          "s3:GetBucketAcl",
          "s3:GetObjectAcl",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion",
          "s3:PutObjectTagging",
          "s3:DeleteObjectTagging"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::qs-prd-ec1-query-result-athena-s3-v1",
          "arn:aws:s3:::qs-prd-ec1-query-result-athena-s3-v1/*"
        ]
      }
    ]
  }
  "iam_009" = {
    name        = "waf_logging"
    description = "waf_logging"
    statements = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_010" = {
    name        = "qs-prd-ec1-observability-handler-policy-v1"
    description = "qs-prd-ec1-observability-handler-policy-v1"
    statements = [{
      Action = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "cloudwatch:PutMetricData",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "sqs:ChangeMessageVisibility"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_011" = {
    name        = "LambdaInvokeScopedAccessPolicy-v1"
    description = "LambdaInvokeScopedAccessPolicy-v1"
    statements = [{
      Action = [
        "lambda:InvokeFunction"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1"]
      }
    ]
  }
}

# #################################
# ######## IAM ROLE  ##############
# #################################

iam_role = {
  "iam_role_001" = {
    name         = "StepFunctions-qs-etl-pipeline-v1-data-processing-role-v1"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/GlueJobRunManagementFullAccessPolicy_v1",
      "arn:aws:iam::597088029926:policy/XRayAccessPolicy_v1",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_002" = {
    name         = "qs-prd-ec1-full-load-dlq-trigger-lambda-iam-role-v1"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/ETLLambda-ecr-role-policy-v1",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
    ]
  }
  "iam_role_003" = {
    name         = "qs-prd-ec1-etl-extract-lambda-iam-role-v1"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/ETLExtractLambdaExecutionRoleDefaultPolicy-v1"
    ]
  }
  "iam_role_004" = {
    name         = "qs-prd-ec1-internal-etl-api-proxy-lambda-iam-role-v1"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/ETLApiProxyLambdaExecutionRoleDefaultPolicy-v1"
    ]
  }
  "iam_role_005" = {
    name         = "qs-prd-ec1-etl-stf-iam-role-v1"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/StepFunctionsRoleDefaultPolicy-v1",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_006" = {
    name         = "qs-prd-ec1-glue-iam-role-v1"
    type         = "Service"
    service_type = ["glue.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
      "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
      "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess",
      "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
    ]
  }
  "iam_role_007" = {
    name         = "qs-prd-ec1-GrafanaCloudWatchLogs-ReadList-iam-role-v1"
    type         = "AWS"
    service_type = ["arn:aws:iam::654654596584:root"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/GrafanaCloudWatchLogs-ReadList-Access-v1"
    ]
  }
  "iam_role_008" = {
    name         = "qs-prd-ec1-Athena-grafana-iam-role-v1"
    type         = "AWS"
    service_type = ["arn:aws:iam::654654596584:root"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::597088029926:policy/Athena-s3-v1"
    ]
  }
  "iam_role_010" = {
    name         = "qs-prd-ec1-waf-logging-iam-role-v2"
    type         = "Service"
    service_type = ["waf.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::597088029926:policy/AwsKms_v1",
      "arn:aws:iam::597088029926:policy/Athena-s3-v1",
      "arn:aws:iam::597088029926:policy/waf_logging"
    ]
  }
  "iam_role_011" = {
    name         = "qs-prd-ec1-observability-handler-iam-role-v1"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/qs-prd-ec1-observability-handler-policy-v1",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_0012" = {
    name         = "qs-prd-ec1-evaluation-processing-stf-iam-role-v1"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::597088029926:policy/LambdaInvokeScopedAccessPolicy-v1",
      "arn:aws:iam::597088029926:policy/GlueJobRunManagementFullAccessPolicy_v1",
      "arn:aws:iam::597088029926:policy/XRayAccessPolicy_v1",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
}

# #################################
# ######## Lambda    ##############
# #################################

lambda = {
  lambda001 = {
    function_name       = "qs-prd-ec1-etl-full-load-dlq-process-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-full-load-dlq-trigger-lambda-iam-role-v1"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v1"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-etl-full-load-dead-letter-sqs-v1"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-etl-full-load-stf-v1"
    }
  }
  lambda002 = {
    function_name       = "qs-prd-ec1-etl-full-load-process-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-etl-extract-lambda-iam-role-v1"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v1"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-etl-full-load-sqs-v1"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-etl-full-load-stf-v1"
    }
  }
  lambda003 = {
    function_name       = "qs-prd-ec1-etl-incremental-load-dlq-process-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-etl-extract-lambda-iam-role-v1"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v1"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-etl-incremental-dead-letter-sqs-v1"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-etl-full-load-stf-v1"
    }
  }
  lambda004 = {
    function_name       = "qs-prd-ec1-etl-incremental-load-process-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-etl-extract-lambda-iam-role-v1"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v1"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-etl-incremental-load-sqs-v1"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-etl-full-load-stf-v1"
    }
  }
  lambda005 = {
    function_name       = "qs-prd-ec1-internal-api-proxy-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-internal-etl-api-proxy-lambda-iam-role-v1"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v1"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlambda"]
    timeout             = 360

  }
  lambda006 = {
    function_name       = "qs-prd-ec1-etl-glue-job-process-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-etl-extract-lambda-iam-role-v1" //"qs-prd-ec1-internal-etl-api-proxy-lambda-iam-role-v1"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v1"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "glueJob"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-etl-glue-job-sqs-v1"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:597088029926:stateMachine:qs-prd-ec1-confluence-data-processing-stf-v1"
    }
  }
  lambda007 = {
    function_name       = "qs-prd-ec1-observability-handler-lambda-v1"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
    role_name           = "qs-prd-ec1-observability-handler-iam-role-v1" //"qs-dev-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    subnet_name         = ["qs-prd-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-prd-ec1-nsg-ETLlamda"]
    variables = {
      ACTION                             = "observabilityHandler"
      CLOUDWATCH_LOG_GROUP_AGENT_RUNTIME = "qs-prd-ec1-observability-agent-runtime"
      CLOUDWATCH_LOG_GROUP_API           = "qs-prd-ec1-observability-api"
      CLOUDWATCH_METRIC_NAMESPACE        = "Octonomy"
      SQS_QUEUE_URL                      = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-observability-sqs-v1"
    }
  }
}

# #################################
# ########   Lambda ZIP  ##########
# #################################

lambda_zip = {
  lambda01 = {
    function_name = "qs-prd-ec1-queue-handler-lambda-v1"
    role_name     = "qs-prd-ec1-queue-handler-lambda-iam-role"
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.12"
  }
}

# #################################
# ########   SQS     ##############
# #################################
sqs = {
  sqs001 = {
    name          = "qs-prd-ec1-etl-full-load-sqs-v1"
    enable_dlq    = true
    dlq_name      = "qs-prd-ec1-etl-full-load-dead-letter-sqs-v1"
    delay_seconds = 0
  }
  sqs002 = {
    name          = "qs-prd-ec1-etl-incremental-load-sqs-v1"
    enable_dlq    = true
    dlq_name      = "qs-prd-ec1-etl-incremental-dead-letter-sqs-v1"
    delay_seconds = 0
  }
  sqs003 = {
    name          = "qs-prd-ec1-etl-glue-job-sqs-v1"
    enable_dlq    = true
    dlq_name      = "qs-prd-ec1-etl-glue-job-sqs-dead-letter-sqs-v1"
    delay_seconds = 0
  }
  sqs004 = {
    name = "qs-prd-ec1-observability-sqs-v1"
  }
}

#################################
#######   Step Function  #######
#################################

sfn = {
  "sfn_001" = {
    name                     = "qs-prd-ec1-confluence-data-processing-stf-v1"
    role_arn                 = "arn:aws:iam::597088029926:role/StepFunctions-qs-etl-pipeline-v1-data-processing-role-v1"
    log_group_name           = "qs-prd-ec1-confluence-data-processing-stf-log-v1"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
{
  "Comment": "ETL Workflow with Extract, Clean, Transform, and Store Embedding",
  "StartAt": "FetchJobInfo",
  "States": {
    "FetchJobInfo": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "GET",
        "path.$": "States.Format('https://api.internal.octonomy.ai/etl/api/v1/job/{}', $.jobId)",
        "headers": {
          "x-service-type": "etl",
          "accept": "*/*",
          "x-tenant-id.$": "$.tenantId",
          "Content-Type": "application/json"
        }
      },
      "Next": "Initialize",
      "ResultPath": "$.ResponseBody"
    },
    "Initialize": {
      "Type": "Pass",
      "Next": "ExtractionDataStarted",
      "Parameters": {
        "jobId.$": "States.Format('{}', $.ResponseBody.data.id)",
        "tenantId.$": "States.Format('{}', $.tenantId)",
        "jobExecutionId.$": "States.Format('{}', $.jobExecutionId)",
        "tenantS3Bucket.$": "States.Format('{}', $.ResponseBody.data.context.default.s3BucketName)",
        "srcPath.$": "States.Format('{}', $.ResponseBody.data.context.default.srcPath)",
        "dataSourceType.$": "States.Format('{}', $.ResponseBody.data.context.default.dataSourceType)",
        "extractData.$": "$.ResponseBody.data.context.extract",
        "cleaningData.$": "$.ResponseBody.data.context.cleaning",
        "generateTranslation.$": "$.ResponseBody.data.context.translation",
        "generateKnowledge.$": "$.ResponseBody.data.context.knowledgeGeneration",
        "chunking.$": "$.ResponseBody.data.context.chunking",
        "embeddingAndVectorLoad.$": "$.ResponseBody.data.context.vectorization",
        "apiProxyUrl": "https://api.internal.octonomy.ai",
        "llmCredentialStoreUrl": "https://api.internal.octonomy.ai/integration/api/v1/custom/genai",
        "pgvectorCredentialStoreUrl": "https://api.internal.octonomy.ai/integration/api/v1/custom/kms",
        "apiProxyArn": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
        "envMode": "prd",
        "credUrl": "https://api.internal.octonomy.ai/integration/api/v1/",
        "etlApiUrl": "https://api.internal.octonomy.ai/etl/api/v1/job",
        "ExtractDataPayload": {
          "status": "EXTRACTING",
          "logMessage": {
            "message": "Extraction has been started"
          }
        },
        "headers": {
          "x-service-type": "etl",
          "accept": "*/*",
          "x-tenant-id.$": "$.tenantId",
          "Content-Type": "application/json"
        }
      }
    },
    "HandleCustomError": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.JobFailedData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Next": "JobFail"
    },
    "ReportFailure": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.FailedData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Next": "JobFail"
    },
    "ExtractionDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.ExtractionStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.ExtractDataPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "Extraction"
    },
    "Extraction": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-Extraction-glue-v1",
        "Arguments": {
          "--ETL_JOB_ID.$": "$.jobId",
          "--TENANT_ID.$": "$.tenantId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "TimeoutSeconds": 172800,
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "CleaningInputPreparation",
      "ResultPath": "$.extracted"
    },
    "JobFailureInputPreparation": {
      "Type": "Pass",
      "Next": "HandleCustomError",
      "Parameters": {
        "LambdaPayload": {
          "status": "FAILED",
          "endTime.$": "$$.State.EnteredTime",
          "logMessage": {
            "error": {
              "Error.$": "$.errorInfo.Error",
              "ErrorMessage.$": "States.StringToJson($.errorInfo.Cause)"
            }
          }
        }
      },
      "ResultPath": "$.JobFailedData"
    },
    "CleaningInputPreparation": {
      "Type": "Pass",
      "Next": "CleaningDataStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "TRANSFORMING",
          "logMessage": {
            "message": "Cleaning has been started"
          }
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.jobId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--TENANT_ID.$": "$.tenantId",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "ResultPath": "$.CleaningData"
    },
    "CleaningDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.CleandedStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.CleaningData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "CleaningData"
    },
    "CleaningData": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-Cleaning-glue-v1",
        "Arguments.$": "$.CleaningData.GluePayload"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "TranslationInputPreparation",
      "ResultPath": "$.cleaned"
    },
    "FailureInputPreparation": {
      "Type": "Pass",
      "Next": "ReportFailure",
      "ResultPath": "$.FailedData",
      "Parameters": {
        "LambdaPayload": {
          "status": "FAILED",
          "endTime.$": "$$.State.EnteredTime",
          "logMessage": {
            "error": {
              "Error.$": "$.errorInfo.Error",
              "ErrorMessage.$": "$.errorInfo.Cause"
            }
          }
        }
      }
    },
    "TranslationInputPreparation": {
      "Type": "Pass",
      "Next": "TranslationDataStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "TRANSFORMING",
          "logMessage": {
            "message": "Translation has been started"
          }
        },
        "GluePayload": {
          "--TENANT_ID.$": "$.tenantId",
          "--ETL_JOB_ID.$": "$.jobId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "ResultPath": "$.TranslationData"
    },
    "TranslationDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.TransaltionStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.TranslationData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "TranslateData"
    },
    "TranslateData": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-Translation-glue-v1",
        "Arguments.$": "$.TranslationData.GluePayload"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "GenerateContextInputPreparation",
      "ResultPath": "$.translated"
    },
    "GenerateContextInputPreparation": {
      "Type": "Pass",
      "Next": "GenerateContextStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "TRANSFORMING",
          "logMessage": {
            "message": "Knowledge Generation has been started"
          }
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.jobId",
          "--TENANT_ID.$": "$.tenantId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "ResultPath": "$.GenerateContextData"
    },
    "GenerateContextStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.GenerateContextStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.GenerateContextData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "GenerateContext"
    },
    "GenerateContext": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-KnowledgeCreation-glue-v1",
        "Arguments.$": "$.GenerateContextData.GluePayload"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "ChunkingInputPreparation",
      "ResultPath": "$.generateContext"
    },
    "ChunkingInputPreparation": {
      "Type": "Pass",
      "Next": "ChunkingDataStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "TRANSFORMING",
          "logMessage": {
            "message": "Chunking has been started"
          }
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.jobId",
          "--TENANT_ID.$": "$.tenantId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "ResultPath": "$.ChunkingData"
    },
    "ChunkingDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.ChunkingStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.ChunkingData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "Chunking"
    },
    "Chunking": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-Chunking-glue-v1",
        "Arguments.$": "$.ChunkingData.GluePayload"
      },
      "TimeoutSeconds": 14400,
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "ChunkingEnhancementInputPreparation",
      "ResultPath": "$.chunked"
    },
    "ChunkingEnhancementInputPreparation": {
      "Type": "Pass",
      "Next": "ChunkingEnhancementDataStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "TRANSFORMING",
          "logMessage": {
            "message": "Chunking Enhancement has been started"
          }
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.jobId",
          "--TENANT_ID.$": "$.tenantId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "ResultPath": "$.ChunkingEnhancementData"
    },
    "ChunkingEnhancementDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.ChunkingEnhancementStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.ChunkingEnhancementData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "ChunkingEnhancement"
    },
    "ChunkingEnhancement": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-ChunkEnhancement-glue-v1",
        "Arguments.$": "$.ChunkingEnhancementData.GluePayload"
      },
      "TimeoutSeconds": 172800,
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "EmbeddingAndStoreInputPreparation",
      "ResultPath": "$.chunkEnhanced"
    },
    "EmbeddingAndStoreInputPreparation": {
      "Type": "Pass",
      "Next": "GenerateEmbeddingAndStoreStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "LOADING",
          "logMessage": {
            "message": "Generate Embedding and Store has been started"
          }
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.jobId",
          "--TENANT_ID.$": "$.tenantId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl",
          "--ETL_EXEC_ID.$": "$.jobExecutionId"
        }
      },
      "ResultPath": "$.GenerateEmbeddingAndStoreData"
    },
    "GenerateEmbeddingAndStoreStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.GenerateEmbedddingAndStorePayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.GenerateEmbeddingAndStoreData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "GenerateEmbeddingsAndStore"
    },
    "GenerateEmbeddingsAndStore": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-vectorload-glue-v1",
        "Arguments.$": "$.GenerateEmbeddingAndStoreData.GluePayload"
      },
      "ResultPath": "$.storeResult",
      "TimeoutSeconds": 21600,
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "JobCompletedInputPreparation"
    },
    "JobCompletedInputPreparation": {
      "Type": "Pass",
      "Next": "JobCompleted",
      "Parameters": {
        "JobCompletedPayload": {
          "status": "COMPLETED",
          "logMessage": {
            "message": "ETL job has been completed successfully"
          },
          "endTime.$": "$$.State.EnteredTime"
        },
        "ActivateExecutionPayload": {
          "activeExecutionId.$": "$.jobExecutionId",
          "status": "COMPLETED"
        }
      },
      "ResultPath": "$.JobCompletedData"
    },
    "JobCompleted": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.JobCompletedData.JobCompletedPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "ActivateExecution",
      "ResultPath": "$.activateExecution"
    },
    "ActivateExecution": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}', $.apiProxyUrl, $.jobId)",
        "body.$": "States.JsonToString($.JobCompletedData.ActivateExecutionPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "End": true
    },
    "JobFail": {
      "Type": "Fail",
      "Error": "JobFailed",
      "Cause": "ETL steps failed after retries."
    }
  }
}
EOF
  }
  "sfn_002" = {
    name                     = "qs-prd-ec1-etl-full-load-stf-v1"
    role_arn                 = "arn:aws:iam::597088029926:role/qs-prd-ec1-etl-stf-iam-role-v1"
    log_group_name           = "qs-prd-ec1-etl-full-load-stf-log-v1"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
{
  "StartAt": "Initialize",
  "TimeoutSeconds": 7200,
  "States": {
    "Initialize": {
      "Type": "Pass",
      "ResultPath": "$.meta",
      "Parameters": {
        "jobId.$": "States.Format('{}', $.jobId)",
        "jobExecutionId.$": "States.Format('{}', $.jobExecutionId)",
        "tenantId.$": "States.Format('{}', $.tenantId)",
        "tenantDomain.$": "States.Format('{}', $.tenantDomain)",
        "connectorType.$": "States.Format('{}', $.connectorType)",
        "integrationType.$": "States.Format('{}', $.integrationType)",
        "uri.$": "States.Format('{}', $.uri)",
        "retryCount": 0,
        "totalDownloadedFileCount": 0
      },
      "Next": "UpdateJobStatusToIngesting"
    },
    "UpdateJobStatusToIngesting": {
      "Type": "Pass",
      "ResultPath": "$.statusPayload",
      "Parameters": {
        "status": "INGESTING",
        "logMessage": {
          "message": "Job ingestion started successfully",
          "jobId.$": "$.jobId",
          "jobExecutionId.$": "$.jobExecutionId"
        }
      },
      "Next": "UpdateJobStatusAPI"
    },
    "UpdateJobStatusToFailed": {
      "Type": "Pass",
      "ResultPath": "$.statusPayload",
      "Parameters": {
        "status": "FAILED",
        "logMessage": {
          "error": {
            "jobId.$": "$.meta.jobId",
            "jobExecutionId.$": "$.meta.jobExecutionId",
            "errorDetails.$": "$.error"
          }
        }
      },
      "Next": "UpdateJobStatusAPI"
    },
    "UpdateJobStatusAPI": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('https://api.internal.octonomy.ai/etl/api/v1/job/{}/executions/{}', $.meta.jobId, $.meta.jobExecutionId)",
        "body.$": "States.JsonToString($.statusPayload)",
        "headers": {
          "x-service-type": "etl",
          "accept": "*/*",
          "x-tenant-id.$": "$.meta.tenantId",
          "Content-Type": "application/json"
        }
      },
      "ResultPath": "$.updateStatusResponse",
      "Retry": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 5,
          "MaxAttempts": 3,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "Next": "UpdateJobStatusToFailed",
          "ResultPath": "$.error"
        }
      ],
      "Next": "RouteAfterStatusUpdate"
    },
    "RouteAfterStatusUpdate": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.statusPayload.status",
          "StringEquals": "INGESTING",
          "Next": "CheckUpdateJobStatusResponse"
        },
        {
          "Variable": "$.statusPayload.status",
          "StringEquals": "FAILED",
          "Next": "CheckFailedStatusUpdate"
        }
      ],
      "Default": "FailWorkflow"
    },
    "CheckFailedStatusUpdate": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.updateStatusResponse.statusCode",
          "NumericEquals": 200,
          "Next": "FailWorkflow"
        }
      ],
      "Default": "FailWorkflow"
    },
    "CheckUpdateJobStatusResponse": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.updateStatusResponse.statusCode",
          "NumericEquals": 200,
          "Next": "Check Service Type"
        }
      ],
      "Default": "UpdateJobStatusToFailed"
    },
    "FailWorkflow": {
      "Type": "Fail",
      "Error": "JobExecutionFailed",
      "Cause": "Job execution failed and status updated to FAILED"
    },
    "Check Service Type": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.meta.integrationType",
          "StringEquals": "atlassianconfluence",
          "Next": "Process Confluence Items"
        },
        {
          "Variable": "$.meta.integrationType",
          "StringEquals": "coda",
          "Next": "Process Coda Items"
        },
        {
          "Variable": "$.meta.integrationType",
          "StringEquals": "microsoftsharepoint",
          "Next": "Process SharePoint Items"
        },
        {
          "Variable": "$.meta.integrationType",
          "StringEquals": "awss3",
          "Next": "Send Message to SQS"
        }
      ],
      "Default": "UpdateJobStatusToFailed"
    },
    "Process SharePoint Items": {
      "Type": "Map",
      "ItemsPath": "$.dataSource.space",
      "ResultPath": "$.totalDownloadedFileCount",
      "MaxConcurrency": 1,
      "Next": "Sum All File Counts",
      "Catch": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "Next": "UpdateJobStatusToFailed",
          "ResultPath": "$.error"
        }
      ],
      "Parameters": {
        "uri": "https://api.internal.octonomy.ai/integration/api/v1/stf/custom/storage/sharepoint",
        "spaceId.$": "$$.Map.Item.Value",
        "connectionId.$": "$.connectionId",
        "tenantId.$": "$.meta.tenantId",
        "jobExecutionId.$": "$.meta.jobExecutionId",
        "jobId.$": "$.meta.jobId",
        "integrationType.$": "$.meta.integrationType",
        "meta": {
          "retryCount": 0
        }
      },
      "ItemProcessor": {
        "ProcessorConfig": {
          "Mode": "INLINE"
        },
        "StartAt": "PrepareDownloadSitePayload",
        "States": {
          "PrepareDownloadSitePayload": {
            "Type": "Pass",
            "ResultPath": "$.downloadSitePayload",
            "Parameters": {
              "siteId.$": "$.spaceId",
              "jobExecutionId.$": "$.jobExecutionId",
              "jobId.$": "$.jobId"
            },
            "Next": "DownloadSiteToS3"
          },
          "DownloadSiteToS3": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
            "ResultPath": "$.downloadSiteResponse",
            "Next": "CheckDownloadSiteResponse",
            "Parameters": {
              "httpMethod": "POST",
              "path.$": "States.Format('{}/download_site_to_s3?siteId={}&fileTypeFilter={}', $.uri, $.spaceId, $$.Execution.Input.dataSource.extractStrategy)",
              "headers": {
                "x-connection-id.$": "$.connectionId",
                "x-service-type": "etl",
                "x-tenant-id.$": "$.tenantId"
              },
              "body.$": "States.JsonToString($.downloadSitePayload)"
            }
          },
          "CheckDownloadSiteResponse": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.downloadSiteResponse.statusCode",
                "NumericEquals": 200,
                "Next": "SetDownloadFileCount"
              },
              {
                "Variable": "$.downloadSiteResponse.statusCode",
                "NumericEquals": 201,
                "Next": "SetDownloadFileCount"
              },
              {
                "Variable": "$.downloadSiteResponse.statusCode",
                "NumericGreaterThanEquals": 500,
                "Next": "IncrementRetryCountDownloadSite"
              },
              {
                "Variable": "$.downloadSiteResponse.statusCode",
                "IsPresent": false,
                "Next": "IncrementRetryCountDownloadSite"
              }
            ],
            "Default": "SharePointFailWorkflow"
          },
          "SetDownloadFileCount": {
            "Type": "Pass",
            "Parameters": {
              "downloadedFileCount.$": "$.downloadSiteResponse.data.data.downloadedFiles"
            },
            "Next": "EndSharePointWorkflow"
          },
          "IncrementRetryCountDownloadSite": {
            "Type": "Pass",
            "ResultPath": "$.meta",
            "Parameters": {
              "retryCount.$": "States.MathAdd($.meta.retryCount, 1)",
              "retryStep": "DownloadSiteToS3"
            },
            "Next": "CheckSharePointRetryCount"
          },
          "CheckSharePointRetryCount": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.meta.retryCount",
                "NumericLessThan": 10,
                "Next": "RetrySharePointRequest"
              }
            ],
            "Default": "SharePointFailWorkflow"
          },
          "RetrySharePointRequest": {
            "Type": "Wait",
            "Seconds": 60,
            "Next": "RetrySharePointStepRouter"
          },
          "RetrySharePointStepRouter": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.meta.retryStep",
                "StringEquals": "DownloadSiteToS3",
                "Next": "DownloadSiteToS3"
              }
            ],
            "Default": "SharePointFailWorkflow"
          },
          "SharePointFailWorkflow": {
            "Type": "Fail",
            "Error": "SharePointProcessingFailed",
            "Cause": "SharePoint site download processing failed after retry attempts"
          },
          "EndSharePointWorkflow": {
            "Type": "Succeed"
          }
        }
      }
    },
    "Process Coda Items": {
      "Type": "Map",
      "ItemsPath": "$.dataSource.space",
      "ResultPath": "$.totalDownloadedFileCount",
      "MaxConcurrency": 1,
      "Next": "Sum All File Counts",
      "Catch": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "Next": "UpdateJobStatusToFailed",
          "ResultPath": "$.error"
        }
      ],
      "Parameters": {
        "uri": "https://api.internal.octonomy.ai/integration/api/v1/stf/custom/kms/coda",
        "docId.$": "$$.Map.Item.Value",
        "connectionId.$": "$.connectionId",
        "tenantId.$": "$.meta.tenantId",
        "jobExecutionId.$": "$.meta.jobExecutionId",
        "jobId.$": "$.meta.jobId",
        "meta": {
          "retryCount": 0
        }
      },
      "ItemProcessor": {
        "ProcessorConfig": {
          "Mode": "INLINE"
        },
        "StartAt": "PrepareExportInitiatePayload",
        "States": {
          "PrepareExportInitiatePayload": {
            "Type": "Pass",
            "ResultPath": "$.exportInitiatePayload",
            "Parameters": {
              "docId.$": "$.docId",
              "jobExecutionId.$": "$.jobExecutionId",
              "jobId.$": "$.jobId"
            },
            "Next": "ExportInitiate"
          },
          "ExportInitiate": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
            "ResultPath": "$.exportInitiateResponse",
            "Next": "CheckExportInitiateResponse",
            "Parameters": {
              "httpMethod": "POST",
              "path.$": "States.Format('{}/export_initiate?docId={}', $.uri, $.docId)",
              "headers": {
                "x-connection-id.$": "$.connectionId",
                "x-service-type": "etl",
                "x-tenant-id.$": "$.tenantId"
              },
              "body.$": "States.JsonToString($.exportInitiatePayload)"
            }
          },
          "CheckExportInitiateResponse": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.exportInitiateResponse.statusCode",
                "NumericEquals": 200,
                "Next": "PrepareExportPayload"
              },
              {
                "Variable": "$.exportInitiateResponse.statusCode",
                "NumericGreaterThanEquals": 500,
                "Next": "IncrementRetryCountExportInitiate"
              },
              {
                "Variable": "$.exportInitiateResponse.statusCode",
                "IsPresent": false,
                "Next": "IncrementRetryCountExportInitiate"
              }
            ],
            "Default": "CodaFailWorkflow"
          },
          "IncrementRetryCountExportInitiate": {
            "Type": "Pass",
            "ResultPath": "$.meta",
            "Parameters": {
              "retryCount.$": "States.MathAdd($.meta.retryCount, 1)",
              "retryStep": "ExportInitiate"
            },
            "Next": "CheckCodaRetryCount"
          },
          "PrepareExportPayload": {
            "Type": "Pass",
            "ResultPath": "$.exportPayload",
            "Parameters": {
              "docId.$": "$.docId",
              "jobExecutionId.$": "$.jobExecutionId",
              "jobId.$": "$.jobId"
            },
            "Next": "Export"
          },
          "Export": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
            "ResultPath": "$.exportResponse",
            "Next": "CheckExportResponse",
            "Parameters": {
              "httpMethod": "POST",
              "path.$": "States.Format('{}/export?docId={}', $.uri, $.docId)",
              "headers": {
                "x-connection-id.$": "$.connectionId",
                "x-service-type": "etl",
                "x-tenant-id.$": "$.tenantId"
              },
              "body.$": "States.JsonToString($.exportPayload)"
            }
          },
          "CheckExportResponse": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.exportResponse.statusCode",
                "NumericEquals": 200,
                "Next": "PrepareExportStatusPayload"
              },
              {
                "Variable": "$.exportResponse.statusCode",
                "NumericGreaterThanEquals": 500,
                "Next": "IncrementRetryCountExport"
              },
              {
                "Variable": "$.exportResponse.statusCode",
                "IsPresent": false,
                "Next": "IncrementRetryCountExport"
              }
            ],
            "Default": "CodaFailWorkflow"
          },
          "IncrementRetryCountExport": {
            "Type": "Pass",
            "ResultPath": "$.meta",
            "Parameters": {
              "retryCount.$": "States.MathAdd($.meta.retryCount, 1)",
              "retryStep": "Export"
            },
            "Next": "CheckCodaRetryCount"
          },
          "PrepareExportStatusPayload": {
            "Type": "Pass",
            "ResultPath": "$.exportStatusPayload",
            "Parameters": {
              "docId.$": "$.docId",
              "jobExecutionId.$": "$.jobExecutionId",
              "jobId.$": "$.jobId"
            },
            "Next": "WaitBeforeExportStatus"
          },
          "WaitBeforeExportStatus": {
            "Type": "Wait",
            "Seconds": 300,
            "Next": "ExportStatus"
          },
          "ExportStatus": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
            "ResultPath": "$.exportStatusResponse",
            "Next": "CheckExportStatusResponse",
            "Parameters": {
              "httpMethod": "POST",
              "path.$": "States.Format('{}/export_status', $.uri)",
              "headers": {
                "x-connection-id.$": "$.connectionId",
                "x-service-type": "etl",
                "x-tenant-id.$": "$.tenantId"
              },
              "body.$": "States.JsonToString($.exportStatusPayload)"
            }
          },
          "CheckExportStatusResponse": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.exportStatusResponse.statusCode",
                "NumericGreaterThanEquals": 500,
                "Next": "IncrementRetryCountExportStatus"
              },
              {
                "Variable": "$.exportStatusResponse.data.data.pendingItemsCount",
                "NumericGreaterThan": 0,
                "Next": "IncrementRetryCountExportStatus"
              },
              {
                "Variable": "$.exportStatusResponse.statusCode",
                "IsPresent": false,
                "Next": "IncrementRetryCountExportStatus"
              },
              {
                "Variable": "$.exportStatusResponse.statusCode",
                "NumericEquals": 200,
                "Next": "SetCodaFileCount"
              }
            ],
            "Default": "CodaFailWorkflow"
          },
          "SetCodaFileCount": {
            "Type": "Pass",
            "Parameters": {
              "downloadedFileCount.$": "$.exportStatusResponse.data.data.downloadedFiles"
            },
            "Next": "EndCodaWorkflow"
          },
          "IncrementRetryCountExportStatus": {
            "Type": "Pass",
            "ResultPath": "$.meta",
            "Parameters": {
              "retryCount.$": "States.MathAdd($.meta.retryCount, 1)",
              "retryStep": "WaitBeforeExportStatus"
            },
            "Next": "CheckCodaRetryCount"
          },
          "CheckCodaRetryCount": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.meta.retryCount",
                "NumericLessThan": 30,
                "Next": "RetryCodaRequest"
              }
            ],
            "Default": "CodaFailWorkflow"
          },
          "RetryCodaRequest": {
            "Type": "Wait",
            "Seconds": 60,
            "Next": "RetryStepRouter"
          },
          "RetryStepRouter": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.meta.retryStep",
                "StringEquals": "ExportInitiate",
                "Next": "ExportInitiate"
              },
              {
                "Variable": "$.meta.retryStep",
                "StringEquals": "Export",
                "Next": "Export"
              },
              {
                "Variable": "$.meta.retryStep",
                "StringEquals": "WaitBeforeExportStatus",
                "Next": "WaitBeforeExportStatus"
              }
            ],
            "Default": "CodaFailWorkflow"
          },
          "CodaFailWorkflow": {
            "Type": "Fail",
            "Error": "CodaProcessingFailed",
            "Cause": "Coda export processing failed after retry attempts"
          },
          "EndCodaWorkflow": {
            "Type": "Succeed"
          }
        }
      }
    },
    "Process Confluence Items": {
      "Type": "Map",
      "ResultPath": "$.totalDownloadedFileCount",
      "Next": "Sum All File Counts",
      "InputPath": "$",
      "Catch": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "Next": "UpdateJobStatusToFailed",
          "ResultPath": "$.error"
        }
      ],
      "Parameters": {
        "uri": "https://api.internal.octonomy.ai/integration/api/v1/stf/custom/kms/atlassianconfluence/get_pages_by_space_id",
        "spaceId.$": "$$.Map.Item.Value",
        "connectionId.$": "$.connectionId",
        "tenantId.$": "$.meta.tenantId",
        "jobExecutionId.$": "$.meta.jobExecutionId",
        "jobId.$": "$.meta.jobId",
        "meta": {
          "retryCount": 0
        }
      },
      "ItemsPath": "$.dataSource.space",
      "ItemProcessor": {
        "ProcessorConfig": {
          "Mode": "INLINE"
        },
        "StartAt": "RequestData",
        "States": {
          "RequestData": {
            "Next": "CheckResponse",
            "Retry": [
              {
                "ErrorEquals": [
                  "Lambda.ClientExecutionTimeoutException",
                  "Lambda.ServiceException",
                  "Lambda.AWSLambdaException",
                  "Lambda.SdkClientException"
                ],
                "IntervalSeconds": 2,
                "MaxAttempts": 6,
                "BackoffRate": 2
              },
              {
                "ErrorEquals": [
                  "ServiceUnavailable",
                  "InternalServerError",
                  "RequestTimeout"
                ],
                "IntervalSeconds": 120,
                "MaxAttempts": 5,
                "BackoffRate": 2
              }
            ],
            "Type": "Task",
            "OutputPath": "$",
            "ResultPath": "$",
            "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
            "Parameters": {
              "httpMethod": "GET",
              "path.$": "$.uri",
              "queryStringParameters": {
                "filterBy.$": "States.Format('{}', 'spaceId')",
                "spaceId.$": "States.Format('{}', $.spaceId)"
              },
              "headers": {
                "x-connection-id.$": "$.connectionId",
                "x-service-type": "etl",
                "x-tenant-id.$": "$.tenantId"
              }
            }
          },
          "IncrementRetryCount": {
            "Type": "Pass",
            "ResultPath": "$.meta",
            "Parameters": {
              "retryCount.$": "States.MathAdd($.meta.retryCount, 1)"
            },
            "Next": "RequestData"
          },
          "CheckRetryCount": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.meta.retryCount",
                "NumericLessThan": 5,
                "Next": "IncrementRetryCount"
              }
            ],
            "Default": "ConfluenceFailWorkflow"
          },
          "RetryRequest": {
            "Type": "Wait",
            "Seconds": 2,
            "Next": "CheckRetryCount"
          },
          "CheckResponse": {
            "Type": "Choice",
            "Choices": [
              {
                "Variable": "$.statusCode",
                "NumericEquals": 200,
                "Next": "SetConfluenceFileCount"
              },
              {
                "Variable": "$.statusCode",
                "NumericEquals": 429,
                "Next": "RateLimitWait"
              },
              {
                "Variable": "$.statusCode",
                "NumericGreaterThanEquals": 500,
                "Next": "RetryRequest"
              }
            ],
            "Default": "ConfluenceFailWorkflow"
          },
          "SetConfluenceFileCount": {
            "Type": "Pass",
            "Parameters": {
              "downloadedFileCount.$": "$.data.data.downloadedFiles"
            },
            "Next": "EndWorkflow"
          },
          "ConfluenceFailWorkflow": {
            "Type": "Fail",
            "Error": "ConfluenceProcessingFailed",
            "Cause": "Confluence API request failed or max retries exceeded"
          },
          "EndWorkflow": {
            "Type": "Succeed"
          },
          "RateLimitWait": {
            "Type": "Wait",
            "Seconds": 10,
            "Next": "RequestData"
          }
        }
      },
      "MaxConcurrency": 1
    },
    "Sum All File Counts": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.meta.integrationType",
          "StringEquals": "awss3",
          "Next": "Send Message to SQS"
        },
        {
          "Variable": "$.totalDownloadedFileCount",
          "IsNull": true,
          "Next": "Sum Default Files"
        },
        {
          "Variable": "$.totalDownloadedFileCount",
          "IsPresent": false,
          "Next": "Sum Default Files"
        }
      ],
      "Default": "Sum File Counts"
    },
    "Sum File Counts": {
      "Type": "Pass",
      "Parameters": {
        "meta.$": "$.meta",
        "totalDownloadedFileCount.$": "$.totalDownloadedFileCount"
      },
      "ResultPath": "$",
      "Next": "Initialize File Count Sum Loop"
    },
    "Sum Default Files": {
      "Type": "Pass",
      "Parameters": {
        "meta.$": "$.meta",
        "totalDownloadedFileCount": []
      },
      "ResultPath": "$",
      "Next": "Initialize File Count Sum Loop"
    },
    "Initialize File Count Sum Loop": {
      "Type": "Pass",
      "Parameters": {
        "fileCountSum": 0,
        "fileCountIndex": 0,
        "fileCountArray.$": "$.totalDownloadedFileCount",
        "fileCountLength.$": "States.ArrayLength($.totalDownloadedFileCount)",
        "meta.$": "$.meta"
      },
      "ResultPath": "$",
      "Next": "File Count Sum Loop Choice"
    },
    "File Count Sum Loop Choice": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.fileCountIndex",
          "NumericLessThanPath": "$.fileCountLength",
          "Next": "Get Current File Count Value"
        }
      ],
      "Default": "Check File Count"
    },
    "Get Current File Count Value": {
      "Type": "Pass",
      "Parameters": {
        "currentFileCountValue.$": "States.ArrayGetItem($.fileCountArray, $.fileCountIndex)",
        "fileCountSum.$": "$.fileCountSum",
        "fileCountIndex.$": "$.fileCountIndex",
        "fileCountArray.$": "$.fileCountArray",
        "fileCountLength.$": "$.fileCountLength",
        "meta.$": "$.meta"
      },
      "ResultPath": "$",
      "Next": "Add File Count To Sum"
    },
    "Add File Count To Sum": {
      "Type": "Pass",
      "Parameters": {
        "fileCountSum.$": "States.MathAdd($.fileCountSum, $.currentFileCountValue.downloadedFileCount)",
        "fileCountIndex.$": "States.MathAdd($.fileCountIndex, 1)",
        "fileCountArray.$": "$.fileCountArray",
        "fileCountLength.$": "$.fileCountLength",
        "meta.$": "$.meta"
      },
      "ResultPath": "$",
      "Next": "File Count Sum Loop Choice"
    },
    "Check File Count": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.fileCountSum",
          "NumericGreaterThan": 0,
          "Next": "Send Message to SQS"
        }
      ],
      "Default": "FailWorkflowNoFiles"
    },
    "FailWorkflowNoFiles": {
      "Type": "Pass",
      "ResultPath": "$.statusPayload",
      "Parameters": {
        "status": "FAILED",
        "logMessage": {
          "error": {
            "jobId.$": "$.meta.jobId",
            "jobExecutionId.$": "$.meta.jobExecutionId",
            "errorDetails": "Process failed because no files were downloaded (totalDownloadedFileCount = 0)"
          }
        }
      },
      "Next": "UpdateJobStatusAPI"
    },
    "Send Message to SQS": {
      "End": true,
      "Type": "Task",
      "ResultPath": null,
      "Resource": "arn:aws:states:::sqs:sendMessage",
      "Catch": [
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "Next": "UpdateJobStatusToFailed",
          "ResultPath": "$.error"
        }
      ],
      "Parameters": {
        "QueueUrl": "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-etl-glue-job-sqs-v1",
        "MessageBody": {
          "connectionId.$": "$$.Execution.Input.connectionId",
          "tenantId.$": "$$.Execution.Input.tenantId",
          "jobExecutionId.$": "$$.Execution.Input.jobExecutionId",
          "tenantDomain.$": "$$.Execution.Input.tenantDomain",
          "jobId.$": "$$.Execution.Input.jobId",
          "totalDownloadedFileCount.$": "$.meta.totalDownloadedFileCount"
        }
      }
    }
  }
}
   EOF
  }
  "sfn_003" = {
    name                     = "qs-prd-ec1-evaluation-processing-stf-v1"
    role_arn                 = "arn:aws:iam::597088029926:role/qs-prd-ec1-evaluation-processing-stf-iam-role-v1"
    log_group_name           = "qs-prd-ec1-evaluation-processing-stf-log-v1"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
  {
  "Comment": "Evaluation ETL Workflow with Ground Truth, Retrieval Response and Evaluation Jobs",
  "StartAt": "FetchJobInfo",
  "States": {
    "FetchJobInfo": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "GET",
        "path.$": "States.Format('https://api.internal.octonomy.ai/etl/api/v1/job/{}/evaluations/{}', $.jobId, $.evaluationId)",
        "headers": {
          "x-service-type": "etl",
          "accept": "*/*",
          "x-tenant-id.$": "$.tenantId",
          "Content-Type": "application/json"
        }
      },
      "Next": "Initialize",
      "ResultPath": "$.ResponseBody"
    },
    "Initialize": {
      "Type": "Pass",
      "Next": "GroundTruthDataStarted",
      "Parameters": {
        "jobId.$": "States.Format('{}', $.jobId)",
        "evaluationId.$": "States.Format('{}', $.evaluationId)",
        "tenantId.$": "States.Format('{}', $.tenantId)",
        "tenantS3Bucket.$": "States.Format('{}', $.ResponseBody.data.context.default.s3BucketName)",
        "apiProxyUrl": "https://api.internal.octonomy.ai",
        "apiProxyArn": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
        "envMode": "prd",
        "credUrl": "https://api.internal.octonomy.ai/integration/api/v1/",
        "etlApiUrl.$": "States.Format('https://api.internal.octonomy.ai/etl/api/v1/job/{}/evaluations', $.jobId)",
        "GroundTruthDataPayload": {
          "status": "EVALUATING"
        },
        "headers": {
          "x-service-type": "etl",
          "accept": "*/*",
          "x-tenant-id.$": "$.tenantId",
          "Content-Type": "application/json"
        }
      }
    },
    "HandleCustomError": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/evaluations/{}', $.apiProxyUrl, $.jobId, $.evaluationId)",
        "body.$": "States.JsonToString($.JobFailedDataParsed.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Next": "JobFail"
    },
    "ReportFailure": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/evaluations/{}', $.apiProxyUrl, $.jobId, $.evaluationId)",
        "body.$": "States.JsonToString($.FailedData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Next": "JobFail"
    },
    "GroundTruthDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.GroundTruthStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/evaluations/{}', $.apiProxyUrl, $.jobId, $.evaluationId)",
        "body.$": "States.JsonToString($.GroundTruthDataPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "GroundTruth"
    },
    "GroundTruth": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-GroundTruth-glue-v1",
        "Arguments": {
          "--ETL_JOB_ID.$": "$.evaluationId",
          "--TENANT_ID.$": "$.tenantId",
          "--CRED_URL.$": "$.credUrl",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl"
        }
      },
      "TimeoutSeconds": 14400,
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "RetrieverResponsePreparation",
      "ResultPath": "$.ground_truth_created"
    },
    "JobFailureInputPreparation": {
      "Type": "Pass",
      "Next": "ParseRequiredData",
      "Parameters": {
        "Error.$": "$.errorInfo.Error",
        "ParsedCause.$": "States.StringToJson($.errorInfo.Cause)"
      },
      "ResultPath": "$.JobFailedData"
    },
    "ParseRequiredData": {
      "Type": "Pass",
      "Next": "HandleCustomError",
      "Parameters": {
        "LambdaPayload": {
          "status": "FAILED",
          "endTime.$": "$$.State.EnteredTime"
        }
      },
      "ResultPath": "$.JobFailedDataParsed"
    },
    "RetrieverResponsePreparation": {
      "Type": "Pass",
      "Next": "RetrieverResponseStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "EVALUATING"
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.evaluationId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl",
          "--TENANT_ID.$": "$.tenantId"
        }
      },
      "ResultPath": "$.RetrieveData"
    },
    "RetrieverResponseStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.RetrieverStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/evaluations/{}', $.apiProxyUrl, $.jobId, $.evaluationId)",
        "body.$": "States.JsonToString($.RetrieveData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "RetrieveResponse"
    },
    "RetrieveResponse": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-RetrieveResponse-glue-v1",
        "Arguments.$": "$.RetrieveData.GluePayload"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "EvaluationInputPreparation",
      "ResultPath": "$.retrieved"
    },
    "FailureInputPreparation": {
      "Type": "Pass",
      "Next": "ReportFailure",
      "ResultPath": "$.FailedData",
      "Parameters": {
        "LambdaPayload": {
          "status": "FAILED",
          "endTime.$": "$$.State.EnteredTime",
          "context": {
            "error": {
              "Error.$": "$.errorInfo.Error",
              "ErrorMessage.$": "$.errorInfo.Cause"
            }
          }
        }
      }
    },
    "EvaluationInputPreparation": {
      "Type": "Pass",
      "Next": "EvaluationStarted",
      "Parameters": {
        "LambdaPayload": {
          "status": "EVALUATING"
        },
        "GluePayload": {
          "--ETL_JOB_ID.$": "$.evaluationId",
          "--TENANT_ID.$": "$.tenantId",
          "--API_PROXY_ARN.$": "$.apiProxyArn",
          "--ENV_MODE.$": "$.envMode",
          "--ETL_API_URL.$": "$.etlApiUrl",
          "--CRED_URL.$": "$.credUrl"
        }
      },
      "ResultPath": "$.EvaluationStartedData"
    },
    "EvaluationStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.EvaluationPayload",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/evaluations/{}', $.apiProxyUrl, $.jobId, $.evaluationId)",
        "body.$": "States.JsonToString($.EvaluationStartedData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "Next": "Evaluation"
    },
    "Evaluation": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-prd-ec1-EvaluationSummary-glue-v1",
        "Arguments.$": "$.EvaluationStartedData.GluePayload"
      },
      "ResultPath": "$.storeResult",
      "TimeoutSeconds": 14400,
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed",
            "States.Timeout"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "IntervalSeconds": 60,
          "MaxAttempts": 2,
          "BackoffRate": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "Glue.ConcurrentModificationException",
            "Glue.ConcurrentRunsExceededException",
            "Glue.InternalServiceException",
            "Glue.ResourceNotReadyException",
            "Glue.OperationTimeoutException",
            "Glue.ResourceNumberLimitExceededException",
            "Glue.ThrottlingException"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "JobFailureInputPreparation"
        },
        {
          "ErrorEquals": [
            "States.ALL"
          ],
          "ResultPath": "$.errorInfo",
          "Next": "FailureInputPreparation"
        }
      ],
      "Next": "JobCompletedInputPreparation"
    },
    "JobCompletedInputPreparation": {
      "Type": "Pass",
      "Next": "JobCompleted",
      "Parameters": {
        "LambdaPayload": {
          "status": "COMPLETED",
          "endTime.$": "$$.State.EnteredTime"
        }
      },
      "ResultPath": "$.JobCompletedData"
    },
    "JobCompleted": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:597088029926:function:qs-prd-ec1-internal-api-proxy-lambda-v1",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/evaluations/{}', $.apiProxyUrl, $.jobId, $.evaluationId)",
        "body.$": "States.JsonToString($.JobCompletedData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2,
          "JitterStrategy": "FULL"
        }
      ],
      "End": true
    },
    "JobFail": {
      "Type": "Fail",
      "Error": "JobFailed",
      "Cause": "ETL steps failed after retries."
    }
  }
}
EOF
  }
}

#################################
##### SECRETS MANAGER    #######
#################################

secret = {
  "secret_001" = {
    connection_name = "qs-prd-ec1-customer0001-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0001-v1"
    username        = "glueetluser"
  }
  "secret_002" = {
    connection_name = "qs-prd-ec1-customer0002-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0002-v1"
    username        = "glueetluser"
  }
  "secret_003" = {
    connection_name = "qs-prd-ec1-customer0003-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0003-v1"
    username        = "glueetluser"
  }
  "secret_004" = {
    connection_name = "qs-prd-ec1-customer0004-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0004-v1"
    username        = "glueetluser"
  }
  "secret_005" = {
    connection_name = "qs-prd-ec1-customer0005-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0005-v1"
    username        = "glueetluser"
  }
  "secret_006" = {
    connection_name = "qs-prd-ec1-customer0006-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0006-v1"
    username        = "glueetluser"
  }
  "secret_010" = {
    connection_name = "qs-prd-ec1-customer0010-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0010-v1"
    username        = "glueetluser"
  }
  "secret_011" = {
    connection_name = "qs-prd-ec1-customer0015-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0015-v1"
    username        = "glueetluser"
  }
  "secret_012" = {
    connection_name = "qs-prd-ec1-customer0014-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0014-v1"
    username        = "glueetluser"
  }
  "secret_013" = {
    connection_name = "qs-prd-ec1-customer0013-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0013-v1"
    username        = "glueetluser"
  }
  "secret_014" = {
    connection_name = "qs-prd-ec1-customer0008-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0008-v1"
    username        = "glueetluser"
  }
  "secret_015" = {
    connection_name = "qs-prd-ec1-customer0022-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0022-v1"
    username        = "glueetluser"
  }
  "secret_016" = {
    connection_name = "qs-prd-ec1-customer0007-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0007-v1"
    username        = "glueetluser"
  }
  "secret_017" = {
    connection_name = "qs-prd-ec1-customer0025-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0025-v1"
    username        = "glueetluser"
  }
  "secret_018" = {
    connection_name = "qs-prd-ec1-customer0016-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0016-v1"
    username        = "glueetluser"
  }
  "secret_019" = {
    connection_name = "qs-prd-ec1-customer0020-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0020-v1"
    username        = "glueetluser"
  }
  "secret_020" = {
    connection_name = "qs-prd-ec1-customer0026-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0026-v1"
    username        = "glueetluser"
  }
  "secret_020" = {
    connection_name = "qs-prd-ec1-customer0018-glue-v1"
    secret_name     = "qs-prd-ec1-glue-data-customer0018-v1"
    username        = "glueetluser"
  }
}

#################################
##### ETL GLUE CONNECTION #######
#################################

data_connection = {
  connection_001 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0001"
    connection_name    = "qs-prd-ec1-customer0001-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0001-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_002 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0002"
    connection_name    = "qs-prd-ec1-customer0002-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0002-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_003 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0003"
    connection_name    = "qs-prd-ec1-customer0003-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0003-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_004 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0004"
    connection_name    = "qs-prd-ec1-customer0004-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0004-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_005 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0005"
    connection_name    = "qs-prd-ec1-customer0005-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0005-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_006 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0006"
    connection_name    = "qs-prd-ec1-customer0006-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0006-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_010 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0010"
    connection_name    = "qs-prd-ec1-customer0010-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0010-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_010 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0010"
    connection_name    = "qs-prd-ec1-customer0010-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0010-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_011 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0015"
    connection_name    = "qs-prd-ec1-customer0015-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0015-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_012 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0014"
    connection_name    = "qs-prd-ec1-customer0014-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0014-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_013 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0013"
    connection_name    = "qs-prd-ec1-customer0013-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0013-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_008 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0008"
    connection_name    = "qs-prd-ec1-customer0008-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0008-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_022 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0022"
    connection_name    = "qs-prd-ec1-customer0022-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0022-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_023 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0007"
    connection_name    = "qs-prd-ec1-customer0007-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0007-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_024 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0025"
    connection_name    = "qs-prd-ec1-customer0025-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0025-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_025 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0016"
    connection_name    = "qs-prd-ec1-customer0016-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0016-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_026 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0020"
    connection_name    = "qs-prd-ec1-customer0020-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0020-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_027 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0026"
    connection_name    = "qs-prd-ec1-customer0026-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0026-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
  connection_028 = {
    glue_subnets_name  = "qs-prd-ec1-private-sne-rds-01a-v1"
    security_group_rds = "qs-prd-ec1-rds-nsg-customer0018"
    connection_name    = "qs-prd-ec1-customer0018-glue-v1"
    rds_cluster_name   = "qs-prd-ec1-customer0018-rds-v1"
    availability_zone  = "eu-central-1a"
    database_name      = "masterdb"
    database_type      = "postgresql"
  }
}

#################################
#########   ETL GLUE  ##########
#################################

glue_jobs = {
  etl_job_001 = {
    connections_use           = true
    connection_name           = ["qs-prd-ec1-customer0001-glue-v1", "qs-prd-ec1-customer0002-glue-v1", "qs-prd-ec1-customer0003-glue-v1", "qs-prd-ec1-customer0004-glue-v1", "qs-prd-ec1-customer0005-glue-v1", "qs-prd-ec1-customer0006-glue-v1", "qs-prd-ec1-customer0010-glue-v1", "qs-prd-ec1-customer0015-glue-v1", "qs-prd-ec1-customer0014-glue-v1", "qs-prd-ec1-customer0013-glue-v1", "qs-prd-ec1-customer0008-glue-v1", "qs-prd-ec1-customer0022-glue-v1", "qs-prd-ec1-customer0007-glue-v1", "qs-prd-ec1-customer0025-glue-v1", "qs-prd-ec1-customer0016-glue-v1", "qs-prd-ec1-customer0020-glue-v1", "qs-prd-ec1-customer0026-glue-v1", "qs-prd-ec1-customer0018-glue-v1"]
    default_arguments         = {}
    description               = "qs-prd-ec1-vectorload-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-vectorload-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-vectorload-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-vectorload-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_002 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-prd-ec1-Translation-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-Translation-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-Translation-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-Translation-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_003 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-prd-ec1-KnowledgeCreation-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-KnowledgeCreation-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-KnowledgeCreation-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-KnowledgeCreation-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_004 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-prd-ec1-Chunking-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-Chunking-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-Chunking-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-Chunking-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_005 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-prd-ec1-Cleaning-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-Cleaning-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-Cleaning-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-Cleaning-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_006 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-prd-ec1-Extraction-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-Extraction-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-Extraction-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-Extraction-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_007 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-prd-ec1-ChunkEnhancement-glue-v1"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-prd-ec1-ChunkEnhancement-glue-v1"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::597088029926:role/qs-prd-ec1-glue-iam-role-v1"
    security_configuration    = null
    tags                      = { workload = "qs-prd-ec1-ChunkEnhancement-glue-v1" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-prd-ec1-gluescript-s3-v1/scripts/qs-prd-ec1-ChunkEnhancement-glue-v1.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
}


alarms = {
  "alarm0001" = {
    alarm_name                = "qs-prd-ec1-alarm-sqs-full-load-messagesvisible-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 80
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    dimensions = {
      QueueName = "qs-prd-ec1-etl-full-load-sqs-v1"
    }
  }
  "alarm0002" = {
    alarm_name                = "qs-prd-ec1-alarm-sqs-full-load-dlq-messagesvisible-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 80
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    dimensions = {
      QueueName = "qs-prd-ec1-etl-full-load-dead-letter-sqs-v1"
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-prd-ec1-alarm-sqs-incremental-load-messagesvisible-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 80
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    dimensions = {
      QueueName = "qs-prd-ec1-etl-incremental-load-sqs-v1"
    }
  }
  "alarm0004" = {
    alarm_name                = "qs-prd-ec1-alarm-sqs-incremental-load-dlq-messagesvisible-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Average"
    threshold                 = 80
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    dimensions = {
      QueueName = "qs-prd-ec1-etl-incremental-dead-letter-sqs-v1"
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-prd-ec1-alarm-sqs-glue-job-messagesvisible-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 80
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    dimensions = {
      QueueName = "qs-prd-ec1-etl-glue-job-sqs-v1"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-prd-ec1-alarm-sqs-glue-job-dlq-messagesvisible-v1"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 80
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-prd-ec1-sns-alert-v1"
    dimensions = {
      QueueName = "qs-prd-ec1-etl-glue-job-sqs-dead-letter-sqs-v1"
    }
  }
}
environment                        = "prd"
sns_topic                          = "qs-prd-ec1-sns-alert-v1"
image_uri                          = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
lambdas                            = ["qs-prd-rds-snapshot-lambda", "qs-prd-ec1-etl-incremental-load-dlq-process-lambda-v1", "qs-prd-ec1-etl-incremental-load-process-lambda-v1", "qs-prd-ec1-etl-full-load-process-lambda-v1", "qs-prd-ec1-etl-glue-job-process-lambda-v1", "qs-prd-ec1-etl-full-load-dlq-process-lambda-v1", "qs-prd-ec1-post-signup-trigger-lambda-v1", "qs-prd-ec1-internal-api-proxy-lambda-v1"]
lambda_period                      = 60
sf_period                          = 60
ps_role_arn                        = "arn:aws:iam::597088029926:role/qs-prd-ec1-trigger-lambda-iam-role"
ps_image_uri                       = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-50-a2be567"
ps_db_data_migration_sqs_queue_url = "https://sqs.eu-central-1.amazonaws.com/597088029926/qs-prd-ec1-cognito-user-sync-sqs-v1"
################# DA ####################
da_glue_jobs = {
  rds-standard-bronze-agent = {
    name        = "rds-standard-bronze-agent"
    config_path = "bronze"
    file        = "rds_agent_bronze.yaml"
  }
  rds-standard-silver-agent = {
    name        = "rds-standard-silver-agent"
    config_path = "silver"
    file        = "rds_agent_silver.yaml"
  }
  rds-standard-bronze-state-execution = {
    name        = "rds-standard-bronze-state-execution"
    config_path = "bronze"
    file        = "rds_state_execution_bronze.yaml"

  }
  rds-standard-silver-state-execution = {
    name        = "rds-standard-silver-state-execution"
    config_path = "silver"
    file        = "rds_state_execution_silver.yaml"

  }
  rds-standard-bronze-user = {
    name        = "rds-standard-bronze-user"
    config_path = "bronze"
    file        = "rds_user_bronze.yaml"

  }
  rds-standard-silver-user = {
    name        = "rds-standard-silver-user"
    config_path = "silver"
    file        = "rds_user_silver.yaml"
  }
  rds-standard-bronze-user-role = {
    name        = "rds-standard-bronze-user-role"
    config_path = "bronze"
    file        = "rds_user_role_bronze.yaml"
  }
  rds-standard-silver-user-role = {
    name        = "rds-standard-silver-user-role"
    config_path = "silver"
    file        = "rds_user_role_silver.yaml"
  }
  rds-standard-bronze-role = {
    name        = "rds-standard-bronze-role"
    config_path = "bronze"
    file        = "rds_role_bronze.yaml"
  }
  rds-standard-silver-role = {
    name        = "rds-standard-silver-role"
    config_path = "silver"
    file        = "rds_role_silver.yaml"

  }
  rds-standard-bronze-domain = {
    name        = "rds-standard-bronze-domain"
    config_path = "bronze"
    file        = "rds_domain_bronze.yaml"

  }
  rds-standard-silver-domain = {
    name        = "rds-standard-silver-domain"
    config_path = "silver"
    file        = "rds_domain_silver.yaml"
  }
  rds-standard-bronze-tool = {
    name        = "rds-standard-bronze-tool"
    config_path = "bronze"
    file        = "rds_tool_bronze.yaml"

  }
  rds-standard-silver-tool = {
    name        = "rds-standard-silver-tool"
    config_path = "silver"
    file        = "rds_tool_silver.yaml"
  }
  rds-standard-bronze-conversation-grp = {
    name        = "rds-standard-bronze-conversation-grp"
    config_path = "grouping"
    file        = "rds_conversation_grouping.yaml"
  }
  rds-standard-intent-creation-taxanomy = {
    name        = "rds-standard-intent-creation-taxanomy"
    config_path = "taxonomy_config/creation"
    file        = "rds_intent_creation_taxonomy.yaml"
  }
  rds-standard-topic-creation-taxanomy = {
    name        = "rds-standard-topic-creation-taxanomy"
    config_path = "taxonomy_config/creation"
    file        = "rds_topic_creation_taxonomy.yaml"
  }
  rds-standard-gap-creation-taxanomy = {
    name        = "rds-standard-gap-creation-taxanomy"
    config_path = "taxonomy_config/creation"
    file        = "rds_gap_creation_taxonomy.yaml"
  }
  rds-standard-intent-batch-processing-taxanomy = {
    name              = "rds-standard-intent-batch-processing-taxanomy"
    config_path       = "taxonomy_config/process"
    file              = "rds_intent_process_taxonomy.yaml"
    worker_type       = "G.2X"
    number_of_workers = 10
    timeout           = 2880
  }
  rds-standard-topic-batch-processing-taxanomy = {
    name                = "rds-standard-topic-batch-processing-taxanomy"
    config_path         = "taxonomy_config/process"
    file                = "rds_topic_process_taxonomy.yaml"
    worker_type         = "G.2X"
    number_of_workers   = 10
    timeout             = 2880
    max_concurrent_runs = 3

  }
  rds-standard-gap-batch-processing-taxanomy = {
    name                = "rds-standard-gap-batch-processing-taxanomy"
    config_path         = "taxonomy_config/process"
    file                = "rds_gap_process_taxonomy.yaml"
    worker_type         = "G.2X"
    number_of_workers   = 10
    timeout             = 2880
    max_retries         = 2
    max_concurrent_runs = 3

  }
  rds-standard-intent-flatten-gold = {
    name        = "rds-standard-intent-flatten-gold"
    config_path = "taxonomy_config/flatten"
    file        = "rds_intent_gold_taxonomy.yaml"
  }
  rds-standard-topic-flatten-gold = {
    name        = "rds-standard-topic-flatten-gold"
    config_path = "taxonomy_config/flatten"
    file        = "rds_topic_gold_taxonomy.yaml"
  }
  rds-standard-gap-flatten-gold = {
    name        = "rds-standard-gap-flatten-gold"
    config_path = "taxonomy_config/flatten"
    file        = "rds_gap_gold_taxonomy.yaml"
  }
  rds-standard-gold-conversation-grp = {
    name        = "rds-standard-gold-conversation-grp"
    config_path = "silver"
    file        = "rds_conversation_grouping_gold.yaml"
  }
  rds-standard-silver-conversation = {
    name        = "rds-standard-silver-conversation"
    config_path = "silver"
    file        = "rds_conversation_silver.yaml"
  }
  rds-standard-bronze-conversation = {
    name        = "rds-standard-bronze-conversation"
    config_path = "bronze"
    file        = "rds_conversation_bronze.yaml"
  }
  db-data-dump = {
    name        = "db-data-dump"
    config_path = "DevOps"
    file        = ""
  }
  rds-standard-state-execution-table-size = {
    name        = "rds-standard-state-execution-table-size"
    config_path = "bronze"
    file        = "rds_standard_bronze.py"
  }
  rds-standard-manifest-delta-load = {
    name        = "rds-standard-manifest-delta-load"
    config_path = "silver"
    file        = "rds_standard_silver.py"
  }
}
cw_log_retention_days        = 90
create_da_stf                = true
da_sns_endpoint              = ["jaisankar.vinoba@talentship.io"]
da_subnet_id                 = "subnet-0114061506b685099" #bastion host subnet id
glue_connection_subnet_id    = "subnet-0c6efe9ea92078b94" #private-sne-rds-01a-v1
glue_connection_c4_sg_id     = "sg-0ceda2e9dfc84e753"
glue_connection_c5_sg_id     = "sg-0c31c9a74e3a06e9d"
glue_connection_c6_sg_id     = "sg-02941814af40468f0"
glue_connection_c13_sg_id    = "sg-0af77117af754fa76"
glue_connection_c14_sg_id    = "sg-00ab19df6354e7c5c"
glue_connection_common_sg_id = "sg-060f3e4501e32b321"
c4_jdbc_host                 = "qs-prd-ec1-customer0004-rds-v1.czeq2gec4fg2.eu-central-1.rds.amazonaws.com"
c5_jdbc_host                 = "qs-prd-ec1-customer0005-rds-v1.czeq2gec4fg2.eu-central-1.rds.amazonaws.com"
c6_jdbc_host                 = "qs-prd-ec1-customer0006-rds-v1.czeq2gec4fg2.eu-central-1.rds.amazonaws.com"
c13_jdbc_host                = "qs-prd-ec1-customer0013-rds-v1.czeq2gec4fg2.eu-central-1.rds.amazonaws.com"
c14_jdbc_host                = "qs-prd-ec1-customer0014-rds-v1.czeq2gec4fg2.eu-central-1.rds.amazonaws.com"
common_jdbc_host             = "qs-prd-ec1-common-rds-v1.czeq2gec4fg2.eu-central-1.rds.amazonaws.com"
da_ssh_pub_key               = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDnNzPYcxcYkbLxwBpgIxed4QIvamEG9I8YaUM/fvzCz8QotdCWhNfYbShGiENN7qhd1MVrItFAB0ABwjBimFbOhNImkgSeKACgty6lK1lMRLoN7/LDxEJORzrAUA5hcXG8Au3DiBkgcbMQL3wIqoG7+I1UHcN62N4Ij2r42CQW7ZKyyI94iVnzpwRXuZr1jKqmrsV0vit9vWdyE0o23wIZF7gLCOrkkVzc/SjebPhmjNz2ZRG9NJLsJEF+VKBWMuOGU9e6x2pm74h4p11HT0JdOKSjm5A84NpR7SVi94gkMzjSxQ115ji7Gm80LoIacBkuZdRpounPAz3IS304Ipdgu0o4WoRdc0eILs3icm5N97dzp7Gd5L1fGgxSOIs3chJiS2T1SCI066ApKxpQFsYsibDN0r/chBhWwvd2/Svp55siGHseCSvo8B4ajP1fpgWT2Ur0bUEmi5om1JeY24qdghYM6ag+j3CqZMl1Y4acd3Z8rl5svxCLwfR+t7lcabT3//okGDk/TwTXM4Bmdx8G/T/TwBtuqbedPUNf9i3Of9IuSjHfiXWJsSDQPEDI7L5eGYjT5aZesKN5uXPUZ0sJnJm6xKlQJQMTqFAYAOAyUCcpJRQ/9rOzlBCHakGVmn0jrMPOELjojl3YKYfHgXOt+2Wt//dR7URAdX6+3NwVNw=="