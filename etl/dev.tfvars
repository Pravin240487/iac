key = "dev/etl/terraform.tfstate"

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
vpc_name               = "qs-dev-ec1-main-vpc-v2"
subnet_name            = "qs-dev-ec1-private-sne-lambda-01a-v2"
wss_alb_security_group = "dev-qs-nsg-wss-alb-01"
lambda_security_group  = "qs-dev-ec1-nsg-ETLlamda"

# #################################
# ######## IAM POLICY  ############
# #################################

iam_policies = {
  "iam_001" = {
    name        = "GlueJobRunManagementFullAccessPolicy_v2"
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
    name        = "XRayAccessPolicy_v2"
    description = "XRayAccessPolicy"
    statements = [{
      Action = [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords",
        "xray:GetSamplingTargets"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_003" = {
    name        = "ETLApiProxyLambdaExecutionRoleDefaultPolicy-v2"
    description = "ETLApiProxyLambdaExecutionRoleDefaultPolicy-v2"
    statements = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-central-1:905418116080:log-group:/aws/lambda/*"]
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
        Resource = ["arn:aws:ecr:eu-central-1:905418116080:repository/qs-lambda/core"]
    }]
  }
  "iam_004" = {
    name        = "ETLExtractLambdaExecutionRoleDefaultPolicy-v2"
    description = "ETLExtractLambdaExecutionRoleDefaultPolicy-v2"
    statements = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = ["arn:aws:logs:eu-central-1:905418116080:log-group:/aws/lambda/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ReceiveMessage",
          "sqs:SendMessage",
          "lambda:InvokeFunction"
        ]
        Resource = [
          "arn:aws:sqs:eu-central-1:905418116080:qs-dev-ec1-etl-incremental-dead-letter-sqs-v2",
          "arn:aws:sqs:eu-central-1:905418116080:qs-dev-ec1-etl-glue-job-sqs-v2",
          "arn:aws:sqs:eu-central-1:905418116080:qs-dev-ec1-etl-glue-job-sqs-dead-letter-sqs-v2"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ReceiveMessage"
        ]
        Resource = [
          "arn:aws:sqs:eu-central-1:905418116080:qs-dev-ec1-etl-full-load-dead-letter-sqs-v2",
          "arn:aws:sqs:eu-central-1:905418116080:qs-dev-ec1-etl-full-load-sqs-v2",
          "arn:aws:sqs:eu-central-1:905418116080:qs-dev-ec1-etl-incremental-load-sqs-v2"
        ]
      },
      {
        Effect = "Allow"
        Action = ["states:StartExecution"]
        Resource = [
          "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-etl-full-load-stf-v2",
          "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-confluence-data-processing-stf-v2",
          "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-evaluation-processing-stf-v2"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["lambda:InvokeFunction"]
        Resource = ["arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2"]
      }
    ]
  }
  "iam_005" = {
    name        = "ETLLambda-ecr-role-policy-v2"
    description = "ETLLambda-ecr-role-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:eu-central-1:905418116080:log-group:/aws/lambda/*"]
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
        Resource = ["arn:aws:ecr:eu-central-1:905418116080:repository/qs-lambda/core"]
      }
    ]
  }
  "iam_006" = {
    name        = "StepFunctionsRoleDefaultPolicy-v2"
    description = "StepFunctionsRoleDefaultPolicy-v2"
    statements = [{
      Action = [
        "lambda:InvokeFunction"
      ]
      Effect = "Allow"
      Resource = ["arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
        "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2:*"
      ]
      }
    ]
  }
  "iam_007" = {
    name        = "LambdaInvokeScopedAccessPolicy-v2"
    description = "LambdaInvokeScopedAccessPolicy-v2"
    statements = [{
      Action = [
        "lambda:InvokeFunction"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2"]
      }
    ]
  }
  "iam_008" = {
    name        = "GrafanaCloudWatchLogs-ReadList-Access-v2"
    description = "GrafanaCloudWatchLogs-ReadList-Access-v2"
    statements = [{
      Action = [
        "logs:DescribeLogGroups",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListTags*",
        "logs:StartQuery",
        "cloudwatch:ListEntitiesForMetric",
        "cloudwatch:ListMetrics",
        "cloudwatch:ListServiceLevelObjectives",
        "cloudwatch:ListServices",
        "cloudwatch:ListTagsForResource",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetQueryResults",
        "logs:GetQueryResults",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetMetricWidgetImage",
        "cloudwatch:GetService*",
        "cloudwatch:GetTopology*",
        "logs:FilterLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_009" = {
    name        = "Athena-s3-v2"
    description = "Athena-s3-v2"
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
          "arn:aws:s3:::qs-dev-ec1-query-result-athena-s3-v2",
          "arn:aws:s3:::qs-dev-ec1-query-result-athena-s3-v2/*"
        ]
      }
    ]
  }
  "iam_010" = {
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
  "iam_011" = {
    name        = "qs-dev-ec1-observability-handler-policy-v2"
    description = "qs-dev-ec1-observability-handler-policy-v2"
    statements = [{
      Action = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "cloudwatch:PutMetricData",
        "sqs:ChangeMessageVisibility"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_012" = {
    name        = "AWSLambda-policy-v2"
    description = "AWSLambda-policy-v2"
    statements = [{
      Action = [
        "lambda:DisableReplication",
        "lambda:EnableReplication",
        "lambda:Invoke*",
        "lambda:ListTags",
        "lambda:TagResource",
        "lambda:UntagResource",
        "lambda:UpdateFunctionCodeSigningConfig",
        "logs:DescribeLogGroups",
        "xray:GetTraceSummaries",
        "xray:BatchGetTraces"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "logs:StopLiveTail"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:*:*:log-group:/aws/lambda/*"
        ]
      }
    ]
  }
  "iam_013" = {
    name        = "qs-dev-ec1-CloudWatchEvents-glue-iam-policy-v2"
    description = "qs-dev-ec1-CloudWatchEvents-glue-iam-policy-v2"
    statements = [{
      Action = [
        "secretsmanager:CreateSecret",
        "secretsmanager:DeleteSecret",
        "secretsmanager:GetSecretValue"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:secretsmanager:*:*:secret:events!*"]
    }]
  }
  "iam_014" = {
    name        = "qs-dev-ec1-AWSLambda-glue-iam-policy-v2"
    description = "qs-dev-ec1-AWSLambda-glue-iam-policy-v2"
    statements = [{
      Action = [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "lambda:DisableReplication",
        "lambda:EnableReplication",
        "lambda:Invoke*",
        "lambda:ListTags",
        "lambda:TagResource",
        "lambda:UntagResource",
        "lambda:UpdateFunctionCodeSigningConfig"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "logs:StopLiveTail"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:*:*:log-group:/aws/lambda/*"
        ]
      }
    ]
  }
  "iam_015" = {
    name        = "qs-dev-ec1-AmazonVPC-glue-iam-policy-v2"
    description = "qs-dev-ec1-AmazonVPC-glue-iam-policy-v2"
    statements = [{
      Action = [
        "ec2:CreateNetworkInterface",
        "ec2:CreateTags",
        "ec2:DeleteNetworkInterface",
        "ec2:DeleteTags",
        "ec2:DescribeInstances",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVpcEndpoints",
        "ec2:DescribeVpcs"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_016" = {
    name        = "qs-dev-ec1-AmazonS3-glue-iam-policy-v2"
    description = "qs-dev-ec1-AmazonS3-glue-iam-policy-v2"
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
  "iam_017" = {
    name        = "qs-dev-ec1-SecretsManager-glue-iam-policy-v2"
    description = "qs-dev-ec1-SecretsManager-glue-iam-policy-v2"
    statements = [{
      Action = [
        "secretsmanager:BatchGetSecretValue",
        "secretsmanager:CreateSecret",
        "secretsmanager:DeleteSecret",
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutResourcePolicy",
        "secretsmanager:TagResource",
        "secretsmanager:UntagResource",
        "secretsmanager:UpdateSecretVersionStage",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = ["lambda:InvokeFunction"],
        Effect = "Allow"
        Resource = [
          "arn:aws:lambda:*:*:function:SecretsManager*"
        ]
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
  "iam_018" = {
    name        = "qs-dev-ec1-AWSGlueConsole-glue-iam-policy-v2"
    description = "qs-dev-ec1-AWSGlueConsole-glue-iam-policy-v2"
    statements = [
      {
        Sid    = "BaseAppPermissions"
        Effect = "Allow"
        Action = [
          "glue:*",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeRouteTables",
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "s3:ListBucket",
          "cloudwatch:GetMetricData"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::aws-glue-*/*",
          "arn:aws:s3:::*/*aws-glue-*/*",
          "arn:aws:s3:::aws-glue-*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["logs:GetLogEvents"]
        Resource = ["arn:aws:logs:*:*:/aws-glue/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ]
        Resource = ["arn:aws:ec2:*:*:instance/*"]
        Condition = {
          StringEquals = {
            "ec2:ResourceTag/aws:cloudformation:logical-id" = "ZeppelinInstance"
          }
          StringLike = {
            "ec2:ResourceTag/aws:cloudformation:stack-id" = "arn:aws:cloudformation:*:*:stack/aws-glue-*/*"
          }
        }
      }
    ]
  }
  "iam_019" = {
    name        = "qs-dev-ec1-AmazonRDS-glue-iam-policy-v2"
    description = "qs-dev-ec1-AmazonRDS-glue-iam-policy-v2"
    statements = [{
      Action = [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "ec2:DescribeLocalGatewayRouteTablePermissions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "logs:GetLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_020" = {
    name        = "qs-dev-ec1-CloudWatch-glue-iam-policy-v2"
    description = "qs-dev-ec1-CloudWatch-glue-iam-policy-v2"
    statements = [{
      Action = [
        "cloudwatch:Batch*",
        "cloudwatch:CreateServiceLevelObjective",
        "cloudwatch:DeleteServiceLevelObjective",
        "cloudwatch:EnableTopologyDiscovery",
        "cloudwatch:Generate*",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetMetricWidgetImage",
        "cloudwatch:GetService*",
        "cloudwatch:GetTopology*",
        "cloudwatch:Link",
        "cloudwatch:ListEntitiesForMetric",
        "cloudwatch:ListMetrics",
        "cloudwatch:ListServiceLevelObjectives",
        "cloudwatch:ListServices",
        "cloudwatch:ListTagsForResource",
        "cloudwatch:PutMetricData",
        "cloudwatch:TagResource",
        "cloudwatch:UntagResource",
        "cloudwatch:UpdateServiceLevelObjective",
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
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_021" = {
    name        = "qs-dev-ec1-CloudWatch-evaluation-processing-stf-iam-policy-v2"
    description = "qs-dev-ec1-CloudWatch-evaluation-processing-stf-iam-policy-v2"
    statements = [{
      Action = [
        "logs:CreateLogDelivery",
        "logs:DeleteAccountPolicy",
        "logs:DeleteLogDelivery",
        "logs:DescribeLogGroups",
        "logs:DescribeResourcePolicies",
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
        "logs:PutResourcePolicy",
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
  "iam_022" = {
    name        = "qs-dev-ec1-CloudWatch-evaluation-processing-stf-iam-policy-1-v2"
    description = "qs-dev-ec1-CloudWatch-evaluation-processing-stf-iam-policy-1-v2"
    statements = [{
      Action = [
        "cloudwatch:BatchGet*",
        "cloudwatch:GenerateQuery",
        "cloudwatch:GetMetricData",
        "cloudwatch:GetMetricWidgetImage",
        "cloudwatch:GetService*",
        "cloudwatch:GetTopology*",
        "cloudwatch:ListEntitiesForMetric",
        "cloudwatch:ListMetrics",
        "cloudwatch:ListServiceLevelObjectives",
        "cloudwatch:ListServices",
        "cloudwatch:ListTagsForResource",
        "logs:GetLogDelivery",
        "logs:GetLogEvents",
        "logs:GetQueryResults",
        "logs:ListEntitiesForLogGroup",
        "logs:ListLogDeliveries",
        "logs:ListLogGroups",
        "logs:ListLogGroupsForEntity",
        "logs:ListTags*",
        "logs:StartQuery",
        "logs:DescribeLogGroups",
        "logs:FilterLogEvents",
        "logs:StopLiveTail",
        "oam:ListSinks"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = ["oam:ListAttachedLinks"],
        Effect = "Allow"
        Resource = [
          "arn:aws:oam:*:*:sink/*"
        ]
    }]
  }
}

# #################################
# ######## IAM ROLE  ##############
# #################################

iam_role = {
  "iam_role_001" = {
    name         = "StepFunctions-qs-dev-etl-pipeline-v2-data-processing-role-v2"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/GlueJobRunManagementFullAccessPolicy_v2",
      "arn:aws:iam::905418116080:policy/XRayAccessPolicy_v2",
      "arn:aws:iam::905418116080:policy/AWSLambda-policy-v2",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  "iam_role_002" = {
    name         = "qs-dev-ec1-full-load-dlq-trigger-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/ETLLambda-ecr-role-policy-v2",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
    ]
  }
  "iam_role_003" = {
    name         = "qs-dev-ec1-etl-extract-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/ETLExtractLambdaExecutionRoleDefaultPolicy-v2"
    ]
  }
  "iam_role_004" = {
    name         = "qs-dev-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/ETLApiProxyLambdaExecutionRoleDefaultPolicy-v2"
    ]
  }
  "iam_role_005" = {
    name         = "qs-dev-ec1-etl-stf-iam-role-v2"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/StepFunctionsRoleDefaultPolicy-v2",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
  "iam_role_006" = {
    name         = "qs-dev-ec1-glue-iam-role-v2"
    type         = "Service"
    service_type = ["glue.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-AmazonRDS-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-AmazonS3-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-AmazonVPC-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-AWSGlueConsole-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-AWSLambda-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-CloudWatchEvents-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-CloudWatch-glue-iam-policy-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-SecretsManager-glue-iam-policy-v2"
    ]
  }
  "iam_role_007" = {
    name         = "qs-dev-ec1-evaluation-processing-stf-iam-role-v2"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/LambdaInvokeScopedAccessPolicy-v2",
      "arn:aws:iam::905418116080:policy/GlueJobRunManagementFullAccessPolicy_v2",
      "arn:aws:iam::905418116080:policy/XRayAccessPolicy_v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-CloudWatch-evaluation-processing-stf-iam-policy-v2"
    ]
  }
  "iam_role_008" = {
    name         = "qs-dev-ec1-GrafanaCloudWatchLogs-ReadList-iam-role-v2"
    type         = "AWS"
    service_type = ["arn:aws:iam::654654596584:root"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/GrafanaCloudWatchLogs-ReadList-Access-v2",
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-CloudWatch-evaluation-processing-stf-iam-policy-1-v2"
    ]
  }
  "iam_role_009" = {
    name         = "qs-dev-ec1-Athena-grafana-iam-role-v2"
    type         = "AWS"
    service_type = ["arn:aws:iam::654654596584:root"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/Athena-s3-v2"
    ]
  }
  "iam_role_010" = {
    name         = "qs-dev-ec1-waf-logging-iam-role-v2"
    type         = "Service"
    service_type = ["waf.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::905418116080:policy/AwsKms_v2",
      "arn:aws:iam::905418116080:policy/Athena-s3-v2",
      "arn:aws:iam::905418116080:policy/waf_logging"
    ]
  }
  "iam_role_011" = {
    name         = "qs-dev-ec1-observability-handler-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::905418116080:policy/qs-dev-ec1-observability-handler-policy-v2",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_012" = {
    name         = "qs-dev-ec1-queue-handler-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
      "arn:aws:iam::905418116080:policy/AmazonSSM-api-Policy-v2"
    ]
  }
}

# #################################
# ######## Lambda    ##############
# #################################

lambda = {
  lambda001 = {
    function_name       = "qs-dev-ec1-etl-full-load-dlq-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-full-load-dlq-trigger-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-etl-full-load-dead-letter-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-etl-full-load-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
  lambda002 = {
    function_name       = "qs-dev-ec1-etl-full-load-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-etl-extract-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    variables = {
      ACTION                       = "fullLoad"
      SQS_QUEUE_URL                = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-etl-full-load-sqs-v2"
      STEP_FUNCTION_ARN            = "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-etl-full-load-stf-v2"
      EVALUATION_STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-evaluation-processing-stf-v2"
      LAMBDA_TYPE                  = "etl"
    }
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
  lambda003 = {
    function_name       = "qs-dev-ec1-etl-incremental-load-dlq-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-etl-extract-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-etl-incremental-dead-letter-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-etl-full-load-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
  lambda004 = {
    function_name       = "qs-dev-ec1-etl-incremental-load-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-etl-extract-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-etl-incremental-load-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:905418116080:stateMachine:qs-dev-ec1-etl-full-load-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
  lambda005 = {
    function_name       = "qs-dev-ec1-internal-api-proxy-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    timeout             = 360
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
  lambda006 = {
    function_name       = "qs-dev-ec1-etl-glue-job-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-etl-extract-lambda-iam-role-v2" //"qs-dev-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    variables = {
      ACTION            = "glueJob"
      SQS_QUEUE_URL     = ""
      STEP_FUNCTION_ARN = ""
      LAMBDA_TYPE       = "etl"
    }
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
  lambda007 = {
    function_name       = "qs-dev-ec1-observability-handler-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
    role_name           = "qs-dev-ec1-observability-handler-iam-role-v2" //"qs-dev-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    subnet_name         = ["qs-dev-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-dev-ec1-nsg-ETLlamda"]
    variables = {
      CLOUDWATCH_METRIC_NAMESPACE        = "Octonomy"
      SQS_QUEUE_URL                      = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-observability-sqs-v2"
      ACTION                             = "observabilityHandler"
      CLOUDWATCH_LOG_GROUP_AGENT_RUNTIME = "qs-dev-ec1-observability-agent-runtime"
      CLOUDWATCH_LOG_GROUP_API           = "qs-dev-ec1-observability-api"
      LAMBDA_TYPE                        = "etl"
    }
    tags = {
      "Project"     = "qs"
      "Environment" = "dev"
      "Terraformed" = true
      "Owner"       = "Octonomy.devops@talentship.io"
      "Version"     = "V2"
    }
  }
}

## Post Sign Up Variables
ps_function_name                   = "qs-dev-ec1-post-signup-trigger-v3"
ps_image_uri                       = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-65-a2be567"
ps_role_arn                        = "arn:aws:iam::905418116080:role/qs-dev-ec1-trigger-lambda-iam-role"
ps_db_data_migration_sqs_queue_url = "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-cognito-user-sync-sqs-v2"

lambda_zip = {
  lambda01 = {
    function_name = "qs-dev-ec1-queue-handler-lambda-v2"
    role_name     = "qs-dev-ec1-queue-handler-lambda-iam-role"
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.12"
  }
}

# #################################
# ########   SQS     ##############
# #################################
sqs = {
  sqs001 = {
    name          = "qs-dev-ec1-etl-full-load-sqs-v2"
    enable_dlq    = true
    dlq_name      = "qs-dev-ec1-etl-full-load-dead-letter-sqs-v2"
    delay_seconds = 0
  }
  sqs002 = {
    name          = "qs-dev-ec1-etl-incremental-load-sqs-v2"
    enable_dlq    = true
    dlq_name      = "qs-dev-ec1-etl-incremental-dead-letter-sqs-v2"
    delay_seconds = 0
  }
  sqs003 = {
    name          = "qs-dev-ec1-etl-glue-job-sqs-v2"
    enable_dlq    = true
    dlq_name      = "qs-dev-ec1-etl-glue-job-sqs-dead-letter-sqs-v2"
    delay_seconds = 0
  }
  sqs004 = {
    name = "qs-dev-ec1-observability-sqs-v2"
  }
}

#################################
#######   Step Function  #######
#################################

sfn = {
  "sfn_001" = {
    name                     = "qs-dev-ec1-confluence-data-processing-stf-v2"
    role_arn                 = "arn:aws:iam::905418116080:role/StepFunctions-qs-dev-etl-pipeline-v2-data-processing-role-v2"
    log_group_name           = "qs-dev-ec1-confluence-data-processing-stf-log-v2"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
{
  "Comment": "ETL Workflow with Extract, Clean, Transform, and Store Embedding",
  "StartAt": "FetchJobInfo",
  "States": {
    "FetchJobInfo": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "GET",
        "path.$": "States.Format('https://api.internal.dev.octonomy.ai/etl/api/v1/job/{}', $.jobId)",
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
      "Next": "TransformationDataStarted",
      "Parameters": {
        "jobId.$": "States.Format('{}', $.ResponseBody.data.id)",
        "tenantId.$": "States.Format('{}', $.tenantId)",
        "jobExecutionId.$": "States.Format('{}', $.jobExecutionId)",
        "tenantS3Bucket.$": "States.Format('{}', $.ResponseBody.data.context.default.s3BucketName)",
        "srcPath.$": "States.Format('{}', $.ResponseBody.data.context.default.srcPath)",
        "dataSourceType.$": "States.Format('{}', $.ResponseBody.data.context.default.dataSourceType)",
        "extractData.$": "$.ResponseBody.data.context.extract",
        "cleaningData.$": "$.ResponseBody.data.context.cleaning",
        "chunking.$": "$.ResponseBody.data.context.chunking",
        "embeddingAndVectorLoad.$": "$.ResponseBody.data.context.vectorization",
        "apiProxyUrl": "https://api.internal.dev.octonomy.ai",
        "llmCredentialStoreUrl": "https://api.internal.dev.octonomy.ai/integration/api/v1/custom/genai",
        "pgvectorCredentialStoreUrl": "https://api.internal.dev.octonomy.ai/integration/api/v1/custom/kms",
        "apiProxyArn": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
        "envMode": "dev",
        "credUrl": "https://api.internal.dev.octonomy.ai/integration/api/v1/",
        "etlApiUrl": "https://api.internal.dev.octonomy.ai/etl/api/v1/job",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('{}/etl/api/v1/job/{}/executions/{}', $.apiProxyUrl, $.jobId, $.jobExecutionId)",
        "body.$": "States.JsonToString($.FailedData.LambdaPayload)",
        "headers.$": "$.headers"
      },
      "Next": "JobFail"
    },
    "TransformationDataStarted": {
      "Type": "Task",
      "OutputPath": "$",
      "ResultPath": "$.ExtractionStatusPayload",
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
      "Next": "Transformation"
    },
    "Transformation": {
      "Type": "Task",
      "Resource": "arn:aws:states:::glue:startJobRun.sync",
      "Parameters": {
        "JobName": "qs-dev-ec1-Transform-glue-v2",
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
          "Next": "ErrorParsePreparation"
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
    "ErrorParsePreparation": {
      "Type": "Pass",
      "ResultPath": "$.parsedError",
      "Parameters": {
        "ErrorJson.$": "States.StringToJson($.errorInfo.Cause)"
      },
      "Next": "JobFailureInputPreparation"
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
              "ErrorMessage.$": "$.parsedError.ErrorJson.ErrorMessage"
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-ConfluenceClean-glue-v2",
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
          "Next": "ErrorParsePreparation"
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-Chunking-glue-v2",
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
          "Next": "ErrorParsePreparation"
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-ChunkEnhancement-glue-v2",
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
          "Next": "ErrorParsePreparation"
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-EmbeddingVectorload-glue-v2",
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
          "Next": "ErrorParsePreparation"
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
    name                     = "qs-dev-ec1-etl-full-load-stf-v2"
    role_arn                 = "arn:aws:iam::905418116080:role/qs-dev-ec1-etl-stf-iam-role-v2"
    log_group_name           = "qs-dev-ec1-etl-full-load-stf-log-v2"
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
        "jobId.$": "$.jobId",
        "tenantId.$": "$.tenantId",
        "jobExecutionId.$": "$.jobExecutionId",
        "tenantDomain.$": "$.tenantDomain",
        "connectorType.$": "$.connectorType",
        "integrationType.$": "$.integrationType",
        "uri.$": "$.uri",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('https://api.internal.dev.octonomy.ai/etl/api/v1/job/{}/executions/{}', $.meta.jobId, $.meta.jobExecutionId)",
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
        "uri": "https://api.internal.dev.octonomy.ai/integration/api/v1/stf/custom/storage/sharepoint",
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
            "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "uri": "https://api.internal.dev.octonomy.ai/integration/api/v1/stf/custom/kms/coda",
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
            "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
            "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
            "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "uri": "https://api.internal.dev.octonomy.ai/integration/api/v1/stf/custom/kms/atlassianconfluence/get_pages_by_space_id",
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
            "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "QueueUrl": "https://sqs.eu-central-1.amazonaws.com/905418116080/qs-dev-ec1-etl-glue-job-sqs-v2",
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
    name                     = "qs-dev-ec1-evaluation-processing-stf-v2"
    role_arn                 = "arn:aws:iam::905418116080:role/qs-dev-ec1-evaluation-processing-stf-iam-role-v2"
    log_group_name           = "qs-dev-ec1-evaluation-processing-stf-log-v2"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
{
  "Comment": "Evaluation ETL Workflow with Ground Truth, Retrieval Response and Evaluation Jobs",
  "StartAt": "FetchJobInfo",
  "States": {
    "FetchJobInfo": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "GET",
        "path.$": "States.Format('https://api.internal.dev.octonomy.ai/etl/api/v1/job/{}/evaluations/{}', $.jobId, $.evaluationId)",
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
        "apiProxyUrl": "https://api.internal.dev.octonomy.ai",
        "apiProxyArn": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
        "envMode": "dev",
        "credUrl": "https://api.internal.dev.octonomy.ai/integration/api/v1/",
        "etlApiUrl.$": "States.Format('https://api.internal.dev.octonomy.ai/etl/api/v1/job/{}/evaluations', $.jobId)",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-ArtificialGroundTruthCreate-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-RetrieveResponse-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-dev-ec1-EvaluationSummary-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:905418116080:function:qs-dev-ec1-internal-api-proxy-lambda-v2",
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
    connection_name = "qs-dev-ec1-connection-glue-v2"
    secret_name     = "qs-dev-ec1-glue-data-connection-v2"
    username        = "glueuser1"
  }
}

#################################
##### ETL GLUE CONNECTION #######
#################################

data_connection = {
  connection_001 = {
    glue_subnets_name  = "qs-dev-ec1-private-sne-rds-01a-v2"
    security_group_rds = "qs-dev-ec1-rds-nsg-dev"
    connection_name    = "qs-dev-ec1-connection-glue-v2"
    rds_cluster_name   = "qs-dev-ec1-dev-rds-v2"
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
    connection_name           = ["qs-dev-ec1-connection-glue-v2"]
    default_arguments         = {}
    description               = "qs-dev-ec1-EmbeddingVectorload-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-EmbeddingVectorload-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-EmbeddingVectorload-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-EmbeddingVectorload-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_004 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-dev-ec1-Chunking-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-Chunking-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-Chunking-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-Chunking-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_005 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-dev-ec1-ConfluenceClean-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-ConfluenceClean-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-ConfluenceClean-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-ConfluenceClean-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_006 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-dev-ec1-Transform-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-Transform-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-Transform-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-Transform-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_007 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-dev-ec1-ChunkEnhancement-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-ChunkEnhancement-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-ChunkEnhancement-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-ChunkEnhancement-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_008 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-dev-ec1-ArtificialGroundTruthCreate-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-ArtificialGroundTruthCreate-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-ArtificialGroundTruthCreate-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-ArtificialGroundTruthCreate-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_009 = {
    connections_use           = true
    connection_name           = ["qs-dev-ec1-connection-glue-v2"]
    default_arguments         = {}
    description               = "qs-dev-ec1-RetrieveResponse-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-RetrieveResponse-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-RetrieveResponse-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-RetrieveResponse-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
  etl_job_010 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-dev-ec1-EvaluationSummary-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-dev-ec1-EvaluationSummary-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::905418116080:role/qs-dev-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags = { Terraformed = true,
    Owner = "Octonomy.devops@talentship.io", workload = "qs-dev-ec1-EvaluationSummary-glue-v2" }
    timeout             = 2880
    worker_type         = null
    command_name        = "pythonshell"
    python_version      = "3.9"
    script_location     = "s3://qs-dev-ec1-gluescript-s3-v2/scripts/qs-dev-ec1-EvaluationSummary-glue-v2.py"
    max_concurrent_runs = 10
    max_retries         = 0
  }
}


alarms = {
  "alarm0001" = {
    alarm_name                = "qs-dev-ec1-alarm-sqs-full-load-messagesvisible-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 100
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    actions_enabled           = true

    dimensions = {
      QueueName = "qs-dev-ec1-etl-full-load-sqs-v2"
    }
  }
  "alarm0002" = {
    alarm_name                = "qs-dev-ec1-alarm-sqs-full-load-dlq-messagesvisible-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 100
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      QueueName = "qs-dev-ec1-etl-full-load-dead-letter-sqs-v2"
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-dev-ec1-alarm-sqs-incremental-load-messagesvisible-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 100
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      QueueName = "qs-dev-ec1-etl-incremental-load-sqs-v2"
    }
  }
  "alarm0004" = {
    alarm_name                = "qs-dev-ec1-alarm-sqs-incremental-load-dlq-messagesvisible-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 100
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    actions_enabled           = true
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    dimensions = {
      QueueName = "qs-dev-ec1-etl-incremental-dead-letter-sqs-v2"
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-dev-ec1-alarm-sqs-glue-job-messagesvisible-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 100
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      QueueName = "qs-dev-ec1-etl-glue-job-sqs-v2"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-dev-ec1-alarm-sqs-glue-job-dlq-messagesvisible-v2"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 1
    metric_name               = "ApproximateNumberOfMessagesVisible"
    namespace                 = "AWS/SQS"
    period                    = 300
    statistic                 = "Sum"
    threshold                 = 100
    alarm_description         = "Alarm for SQS ApproximateNumberOfMessagesVisible"
    treat_missing_data        = "notBreaching"
    insufficient_data_actions = []
    sns_name                  = "qs-dev-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      QueueName = "qs-dev-ec1-etl-glue-job-sqs-dead-letter-sqs-v2"
    }
  }
}
environment             = "dev"
sns_topic               = "qs-dev-ec1-sns-alert-v2"
image_uri               = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:dev-165-676f1f8"
sf_threshold            = 10
lambda_errors_threshold = 20
lambdas                 = ["qs-dev-ec1-etl-incremental-load-dlq-process-lambda-v2", "qs-dev-ec1-etl-glue-job-process-lambda-v2", "qs-dev-rds-snapshot-lambda", "qs-dev-ec1-post-signup-trigger-lambda-v2", "qs-dev-ec1-internal-api-proxy-lambda-v2", "qs-dev-ec1-cloud-watch-metrics-log-process-lambda-v2", "qs-dev-ec1-etl-full-load-process-lambda-v2", "qs-dev-ec1-etl-incremental-load-process-lambda-v2", "qs-dev-ec1-etl-full-load-dlq-process-lambda-v2", "qs-dev-ec1-cw-log-sqs-lambda"]


#####################
##### SES_DOMAIN ####
#####################

ses_domain = {
  "ses0001" = {
    ses_domain_name          = "octonomy.ai"
    ses_identity_policy_name = "Policy-1746453319894"
    notification_type        = ["Bounce", "Complaint"]
    topic_arn                = "arn:aws:sns:eu-central-1:905418116080:qs-dev-ec1-sns-alert-v2"
    ses_domain_identity_policy = {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "ControlAction",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "905418116080"
          },
          "Action" : [
            "ses:SendEmail",
            "ses:SendRawEmail"
          ],
          "Resource" : "arn:aws:ses:eu-central-1:905418116080:identity/octonomy.ai",
          "Condition" : {}
        }
      ]
    }
  }
}
#####################
##### SES_EMAILS ####
#####################

ses_emails = [
  "dev-support@octonomy.ai"
]

ses_email_identity_policy = [
  {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ses.amazonaws.com"
        }
        Action = [
          "SES:SendEmail",
          "SES:SendRawEmail"
        ]
        Resource = "arn:aws:ses:eu-central-1:905418116080:identity/dev-support@octonomy.ai"
        Condition = {
          StringEquals = {
            "ses:FromAddress" = "dev-support@octonomy.ai"
          }
        }
      }
    ]
  }
]
###################################################
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
}
cw_log_retention_days        = 30
create_da_stf                = true
da_sns_endpoint              = ["jaisankar.vinoba@talentship.io"]
da_subnet_id                 = "subnet-09decf876edf394ce" #bastion host subnet id
da_ssh_pub_key               = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDI2GuyKoOXn1hniIVrscxncbHfBN5/CfU61psLg5L5vqpKUfVsMj7b7t/MfuwGDfUx/0BHPmgMM3XTlTL9GTNA1Q2biOw5pQAiSt/zH4iheBq1TjU2dyC52MppHh5L1AFan3Y/8SaMYSd3lRASGKoz3uEctRhOOGUpyncSF8iJGyXMJ6LxTNqPHZlnGBfiutqIucScOL3tEM/azEQFWPyGcqBCJ079XP1YYhR7Gu41CzlY0aakywGgI35EF6p3FDC6DTzdKXGQdBA4NnPHrmQCirv41CvsZBPGzzLUK92tgxWrJJEkvT28LqQ/0IlZh7RftnbZdEwS6XajGwdM8UpgkLKCNL7usULsoAYX9DjVesgOrQL9/FcUdYe+4Ox44jsm8X70cBHCeIpbU5zYZqr3dsLokeeTogrukaKo3A+VbK8/axd/cabTuX7Py2zKu0IsJRvOxrPvnO4xduOYXf7P6gsBI3+xFA8GRKlop7RTus4RKqu+3125SFJUMzVpVqbVZetDdXfSVTPol2lnPnqYVqOdyEDaPSAXEiPxutJXrq5ExFn1Ry+66Z9g/KZ0yj8nq9ZL4IS5+GK/0tiQ80MmbSJPNK4yzD3moneBJzEEtp0AbRs7zfvDl92s5vn12uNvVXSiUVOZkvFEYsN8hsuQd/ViBQ0C/+FwfBCAZYfggw=="
glue_connection_subnet_id    = "subnet-0bf21cf77f17d463a" #private-sne-rds-01a-v1
glue_connection_common_sg_id = "sg-09801e6895db2b047"
common_jdbc_host             = "qs-dev-ec1-dev-rds-v2.cncgagkqsmqo.eu-central-1.rds.amazonaws.com"
