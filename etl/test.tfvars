key = "test/etl/terraform.tfstate"

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
vpc_name               = "qs-test-ec1-main-vpc-v2"
subnet_name            = "qs-test-ec1-private-sne-lambda-01a-v2"
wss_alb_security_group = "test-qs-nsg-wss-alb-01"
lambda_security_group  = "qs-test-ec1-nsg-ETLlambda"

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
        "xray:GetSamplingRules",
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
      Resource = ["arn:aws:logs:eu-central-1:637423349055:log-group:/aws/lambda/*"]
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
        Resource = ["arn:aws:ecr:eu-central-1:637423349055:repository/qs-lambda/core"]
    }]
  }
  "iam_004" = {
    name        = "ETLExtractLambdaExecutionRoleDefaultPolicy-v2"
    description = "ETLExtractLambdaExecutionRoleDefaultPolicy-v2"
    statements = [{
      Action = [
        "execute-api:Invoke"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:execute-api:eu-central-1:637423349055:x997oqyuml/*/*/*"]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:logs:eu-central-1:637423349055:log-group:/aws/lambda/*"]
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
        Resource = ["arn:aws:ecr:eu-central-1:637423349055:repository/qs-lambda/core"]
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
        Resource = ["arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-incremental-dead-letter-sqs-v2",
          "arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-glue-job-sqs-v2",
          "arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-glue-job-sqs-dead-letter-sqs-v2"
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
          "arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-full-load-dead-letter-sqs-v2",
          "arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-full-load-sqs-v2",
          "arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-incremental-load-sqs-v2"
          //"arn:aws:sqs:eu-central-1:637423349055:qs-test-ec1-etl-partial-load-sqs-v2"
        ]
      },
      {
        Action = [
          "states:StartExecution"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-etl-full-load-stf-v2",
          "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-confluence-data-processing-stf-v2",
          "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-evaluation-processing-stf-v2"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["lambda:InvokeFunction"]
        Resource = ["arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2"]
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
      Resource = ["arn:aws:logs:eu-central-1:637423349055:log-group:/aws/lambda/*"]
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
        Resource = ["arn:aws:ecr:eu-central-1:637423349055:repository/qs-lambda/core"]
      }
    ]
  }
  "iam_006" = {
    name        = "StepFunctionsRoleDefaultPolicy-v2"
    description = "StepFunctionsRoleDefaultPolicy-v2"
    statements = [{
      Action = [
        "execute-api:Invoke"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:execute-api:eu-central-1:637423349055:x997oqyuml/*"]
      },
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
          "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2:*"
        ]
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:ecr:eu-central-1:637423349055:repository/qs-lambda/core"]
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
      Resource = ["arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2"]
      }
    ]
  }
  "iam_008" = {
    name        = "GrafanaCloudWatchLogs-ReadList-Access-v2"
    description = "GrafanaCloudWatchLogs-ReadList-Access-v2"
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
          "arn:aws:s3:::qs-test-ec1-query-result-athena-s3-v2",
          "arn:aws:s3:::qs-test-ec1-query-result-athena-s3-v2/*"
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
    name        = "qs-test-ec1-observability-handler-policy-v2"
    description = "qs-test-ec1-observability-handler-policy-v2"
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
  "iam_012" = {
    name        = "qs-test-ec1-etl-stf-sqs-iam-policy-v2"
    description = "qs-test-ec1-etl-stf-sqs-iam-policy-v2"
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
  "iam_013" = {
    name        = "qs-test-ec1-etl-stf-lambda-iam-policy-v2"
    description = "qs-test-ec1-etl-stf-lambda-iam-policy-v2"
    statements = [{
      Action = [
        "execute-api:Invoke"
      ]
      Effect   = "Allow"
      Resource = ["arn:aws:execute-api:eu-central-1:637423349055:x997oqyuml/*"]
      },
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
          "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2:*"
        ]
      },
      {
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:ecr:eu-central-1:637423349055:repository/qs-lambda/core"]
      }
    ]
  }
  "iam_014" = {
    name        = "qs-test-ec1-athena-grafana-cloudwatch-iam-policy-v2"
    description = "qs-test-ec1-athena-grafana-cloudwatch-iam-policy-v2"
    statements = [{
      Action = [
        "s3:GetBucketLocation"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:s3:::*"]
    }]
  }
  "iam_015" = {
    name        = "qs-test-ec1-athena-grafana-kms-iam-policy-v2"
    description = "qs-test-ec1-athena-grafana-kms-iam-policy-v2"
    statements = [{
      Action = [
        "kms:Decrypt"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:kms:eu-central-1:637423349055:key/*"]
    }]
  }
  "iam_016" = {
    name        = "qs-test-ec1-athena-grafana-iam-policy-v2"
    description = "qs-test-ec1-athena-grafana-iam-policy-v2"
    statements = [{
      Action = [
        "athena:CancelQueryExecution",
        "athena:GetCatalogs",
        "athena:GetExecution*",
        "athena:GetNamespace",
        "athena:GetNamespaces",
        "athena:GetQueryExecution",
        "athena:GetQueryExecutions",
        "athena:GetQueryResults",
        "athena:GetTable",
        "athena:GetTables",
        "athena:GetWorkGroup",
        "athena:ListTagsForResource",
        "athena:RunQuery",
        "athena:StartQueryExecution",
        "athena:TagResource",
        "athena:UntagResource"
      ]
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "glue:CreateDatabase",
          "glue:DeleteDatabase",
          "glue:GetCatalog",
          "glue:GetCatalogs",
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:UpdateDatabase",
          "glue:CreateTable",
          "glue:DeleteTable",
          "glue:BatchDeleteTable",
          "glue:UpdateTable",
          "glue:GetTable",
          "glue:GetTables",
          "glue:BatchCreatePartition",
          "glue:CreatePartition",
          "glue:DeletePartition",
          "glue:BatchDeletePartition",
          "glue:UpdatePartition",
          "glue:GetPartition",
          "glue:GetPartitions",
          "glue:BatchGetPartition",
          "glue:StartColumnStatisticsTaskRun",
          "glue:GetColumnStatisticsTaskRun",
          "glue:GetColumnStatisticsTaskRuns",
          "glue:GetCatalogImportStatus"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload",
          "s3:PutObject"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::aws-athena-query-results-*"
        ]
      },
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::athena-examples*"
        ]
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      }
    ]
  }
  "iam_017" = {
    name        = "qs-test-ec1-observability-cloudwatch-evidently-iam-policy-v2"
    description = "qs-test-ec1-observability-cloudwatch-evidently-iam-policy-v2"
    statements = [{
      Action = [
        "cloudwatch:GetMetricData",
        "cloudwatch:ListTagsForResource"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "cloudwatch:TagResource",
          "cloudwatch:UnTagResource"
        ],
        Effect   = "Allow"
        Resource = ["arn:aws:cloudwatch:*:*:alarm:*"]
    }]
  }
  "iam_018" = {
    name        = "qs-test-ec1-observability-cloudwatch-iam-policy-v2"
    description = "qs-test-ec1-observability-cloudwatch-iam-policy-v2"
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
  "iam_019" = {
    name        = "qs-test-ec1-glue-lambda-iam-policy-v2"
    description = "qs-test-ec1-glue-lambda-iam-policy-v2"
    statements = [{
      Action = [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "lambda:DisableReplication",
        "lambda:EnableReplication",
        "lambda:Invoke*",
        "lambda:ListTags",
        "lambda:TagResource",
        "lambda:UntagResource",
        "lambda:UpdateFunctionCodeSigningConfig"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "logs:StopLiveTail"
        ],
        Effect   = "Allow"
        Resource = ["arn:aws:logs:*:*:log-group:/aws/lambda/*"]
      }
    ]
  }
  "iam_020" = {
    name        = "qs-test-ec1-glue-vpc-iam-policy-v2"
    description = "qs-test-ec1-glue-vpc-iam-policy-v2"
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
        "ec2:DescribeVpcEndpoints"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      }
    ]
  }
  "iam_021" = {
    name        = "qs-test-ec1-glue-s3-iam-policy-v2"
    description = "qs-test-ec1-glue-s3-iam-policy-v2"
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
  "iam_022" = {
    name        = "qs-test-ec1-glue-secretsmanager-iam-policy-v2"
    description = "qs-test-ec1-glue-secretsmanager-iam-policy-v2"
    statements = [{
      Action = [
        "secretsmanager:BatchGetSecretValue",
        "secretsmanager:GetSecretValue",
        "secretsmanager:TagResource",
        "secretsmanager:UntagResource",
        "secretsmanager:UpdateSecretVersionStage",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ],
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "lambda:InvokeFunction"
        ],
        Effect   = "Allow"
        Resource = ["arn:aws:lambda:*:*:function:SecretsManager*"]
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
  "iam_023" = {
    name        = "qs-test-ec1-glue-glueconsole-iam-policy-v2"
    description = "qs-test-ec1-glue-glueconsole-iam-policy-v2"
    statements = [{
      Action = [
        "glue:*",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcEndpoints",
        "ec2:DescribeRouteTables",
        "ec2:DescribeInstances",
        "ec2:DescribeImages",
        "s3:ListBucket",
        "cloudwatch:GetMetricData"
      ],
      Effect   = "Allow"
      Resource = ["*"]
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::aws-glue-*/*",
          "arn:aws:s3:::*/*aws-glue-*/*",
          "arn:aws:s3:::aws-glue-*"
        ]
      },
      {
        Action = [
          "logs:GetLogEvents"
        ],
        Effect   = "Allow"
        Resource = ["arn:aws:logs:*:*:/aws-glue/*"]
      },
      {
        Action = [
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ],
        Effect   = "Allow"
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
  "iam_024" = {
    name        = "qs-test-ec1-glue-rds-iam-policy-v2"
    description = "qs-test-ec1-glue-rds-iam-policy-v2"
    statements = [{
      Action = [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData",
        "ec2:DescribeLocalGatewayRouteTablePermissions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "logs:GetLogEvents"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_025" = {
    name        = "qs-test-ec1-glue-cloudwatch-iam-policy-v2"
    description = "qs-test-ec1-glue-cloudwatch-iam-policy-v2"
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
  "iam_026" = {
    name        = "qs-test-ec1-glue-etl-data-processing-lambda-iam-policy-v2"
    description = "qs-test-ec1-glue-etl-data-processing-lambda-iam-policy-v2"
    statements = [{
      Action = [
        "lambda:DisableReplication",
        "lambda:EnableReplication",
        "lambda:Invoke*",
        "lambda:ListTags",
        "lambda:TagResource",
        "lambda:UntagResource",
        "lambda:UpdateFunctionCodeSigningConfig",
        "xray:GetTraceSummaries",
        "xray:BatchGetTraces"
      ],
      Effect   = "Allow"
      Resource = ["*"]
    }]
  }
  "iam_027" = {
    name        = "qs-test-ec1-glue-cloudwatchevents-iam-policy-v2"
    description = "qs-test-ec1-glue-cloudwatchevents-iam-policy-v2"
    statements = [{
      Action = [
        "secretsmanager:GetSecretValue"
      ],
      Effect   = "Allow"
      Resource = ["arn:aws:secretsmanager:*:*:secret:events!*"]
      }
    ]
  }
}

# #################################
# ######## IAM ROLE  ##############
# #################################

iam_role = {
  "iam_role_001" = {
    name         = "StepFunctions-qs-etl-pipeline-v2-data-processing-role-v2"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/GlueJobRunManagementFullAccessPolicy_v2",
      "arn:aws:iam::637423349055:policy/XRayAccessPolicy_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-etl-data-processing-lambda-iam-policy-v2",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_002" = {
    name         = "qs-test-ec1-full-load-dlq-trigger-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/ETLLambda-ecr-role-policy-v2",
      "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
      "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
    ]
  }
  "iam_role_003" = {
    name         = "qs-test-ec1-etl-extract-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/ETLExtractLambdaExecutionRoleDefaultPolicy-v2"
    ]
  }
  "iam_role_004" = {
    name         = "qs-test-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/ETLApiProxyLambdaExecutionRoleDefaultPolicy-v2"
    ]
  }
  "iam_role_005" = {
    name         = "qs-test-ec1-etl-stf-iam-role-v2"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-etl-stf-lambda-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-etl-stf-sqs-iam-policy-v2",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_006" = {
    name         = "qs-test-ec1-glue-iam-role-v2"
    type         = "Service"
    service_type = ["glue.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-rds-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-s3-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-vpc-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-glueconsole-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-lambda-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-cloudwatch-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-secretsmanager-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-glue-cloudwatchevents-iam-policy-v2",
    ]
  }
  "iam_role_007" = {
    name         = "qs-test-ec1-evaluation-processing-stf-iam-role-v2"
    type         = "Service"
    service_type = ["states.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/LambdaInvokeScopedAccessPolicy-v2",
      "arn:aws:iam::637423349055:policy/GlueJobRunManagementFullAccessPolicy_v2",
      "arn:aws:iam::637423349055:policy/XRayAccessPolicy_v2",
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }
  "iam_role_008" = {
    name         = "qs-test-ec1-GrafanaCloudWatchLogs-ReadList-iam-role-v2"
    type         = "AWS"
    service_type = ["arn:aws:iam::654654596584:root"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/GrafanaCloudWatchLogs-ReadList-Access-v2"
    ]
  }
  "iam_role_009" = {
    name         = "qs-test-ec1-Athena-grafana-iam-role-v2"
    type         = "AWS"
    service_type = ["arn:aws:iam::654654596584:root"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-athena-grafana-cloudwatch-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-athena-grafana-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/Athena-s3-v2"
    ]
  }
  "iam_role_010" = {
    name         = "qs-test-ec1-waf-logging-iam-role-v2"
    type         = "Service"
    service_type = ["waf.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
      "arn:aws:iam::aws:policy/AmazonCloudWatchEvidentlyFullAccess",
      "arn:aws:iam::637423349055:policy/AwsKms_v2",
      "arn:aws:iam::637423349055:policy/Athena-s3-v2",
      "arn:aws:iam::637423349055:policy/waf_logging"
    ]
  }
  "iam_role_011" = {
    name         = "qs-test-ec1-observability-handler-iam-role-v2"
    type         = "Service"
    service_type = ["lambda.amazonaws.com"]
    permission_arn = [
      "arn:aws:iam::637423349055:policy/qs-test-ec1-observability-handler-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-observability-cloudwatch-iam-policy-v2",
      "arn:aws:iam::637423349055:policy/qs-test-ec1-observability-cloudwatch-evidently-iam-policy-v2"
    ]
  }
}

# #################################
# ######## Lambda    ##############
# #################################

lambda = {
  lambda001 = {
    function_name       = "qs-test-ec1-etl-full-load-dlq-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-full-load-dlq-trigger-lambda-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-full-load-dead-letter-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-etl-full-load-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
  }
  lambda002 = {
    function_name       = "qs-test-ec1-etl-full-load-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-etl-extract-lambda-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlambda"]
    variables = {
      ACTION                       = "fullLoad"
      SQS_QUEUE_URL                = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-full-load-sqs-v2"
      STEP_FUNCTION_ARN            = "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-etl-full-load-stf-v2"
      EVALUATION_STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-evaluation-processing-stf-v2"
      LAMBDA_TYPE                  = "etl"
    }
  }
  lambda003 = {
    function_name       = "qs-test-ec1-etl-incremental-load-dlq-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-etl-extract-lambda-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-incremental-dead-letter-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-etl-full-load-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
  }
  lambda004 = {
    function_name       = "qs-test-ec1-etl-incremental-load-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-etl-extract-lambda-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "fullLoad"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-incremental-load-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-etl-full-load-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
  }
  lambda005 = {
    function_name       = "qs-test-ec1-internal-api-proxy-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlambda"]
    timeout             = 360

  }
  lambda006 = {
    function_name       = "qs-test-ec1-etl-glue-job-process-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-etl-extract-lambda-iam-role-v2" //"qs-test-ec1-internal-etl-api-proxy-lambda-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlambda"]
    variables = {
      ACTION            = "glueJob"
      SQS_QUEUE_URL     = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-glue-job-sqs-v2"
      STEP_FUNCTION_ARN = "arn:aws:states:eu-central-1:637423349055:stateMachine:qs-test-ec1-confluence-data-processing-stf-v2"
      LAMBDA_TYPE       = "etl"
    }
  }
  lambda007 = {
    function_name       = "qs-test-ec1-observability-handler-lambda-v2"
    image_uri           = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
    role_name           = "qs-test-ec1-observability-handler-iam-role-v2"
    subnet_name         = ["qs-test-ec1-private-sne-lambda-01a-v2"]
    security_group_name = ["qs-test-ec1-nsg-ETLlamda"]
    variables = {
      CLOUDWATCH_METRIC_NAMESPACE        = "Octonomy"
      SQS_QUEUE_URL                      = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-observability-sqs-v2"
      ACTION                             = "observabilityHandler"
      CLOUDWATCH_LOG_GROUP_AGENT_RUNTIME = "qs-test-ec1-observability-agent-runtime"
      CLOUDWATCH_LOG_GROUP_API           = "qs-test-ec1-observability-api"
      LAMBDA_TYPE                        = "etl"
    }
  }
}

# #################################
# ########   Lambda ZIP  ##########
# #################################

lambda_zip = {
  lambda01 = {
    function_name = "qs-test-ec1-queue-handler-lambda-v2"
    role_name     = "qs-test-ec1-queue-handler-lambda-iam-role"
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.12"
  }
}

# #################################
# ########   SQS     ##############
# #################################
sqs = {
  sqs001 = {
    name          = "qs-test-ec1-etl-full-load-sqs-v2"
    enable_dlq    = true
    dlq_name      = "qs-test-ec1-etl-full-load-dead-letter-sqs-v2"
    delay_seconds = 0
  }
  sqs002 = {
    name          = "qs-test-ec1-etl-incremental-load-sqs-v2"
    enable_dlq    = true
    dlq_name      = "qs-test-ec1-etl-incremental-dead-letter-sqs-v2"
    delay_seconds = 0
  }
  sqs003 = {
    name          = "qs-test-ec1-etl-glue-job-sqs-v2"
    enable_dlq    = true
    dlq_name      = "qs-test-ec1-etl-glue-job-sqs-dead-letter-sqs-v2"
    delay_seconds = 0
  }
  sqs004 = {
    name = "qs-test-ec1-observability-sqs-v2"
  }
}

#################################
#######   Step Function  #######
#################################

sfn = {
  "sfn_001" = {
    name                     = "qs-test-ec1-confluence-data-processing-stf-v2"
    role_arn                 = "arn:aws:iam::637423349055:role/StepFunctions-qs-etl-pipeline-v2-data-processing-role-v2"
    log_group_name           = "qs-test-ec1-confluence-data-processing-stf-log-v2"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
{
  "Comment": "ETL Workflow with Extract, Clean, Transform, and Store Embedding",
  "StartAt": "FetchJobInfo",
  "States": {
    "FetchJobInfo": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "GET",
        "path.$": "States.Format('https://api.internal.test.octonomy.ai/etl/api/v1/job/{}', $.jobId)",
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
        "apiProxyUrl": "https://api.internal.test.octonomy.ai",
        "llmCredentialStoreUrl": "https://api.internal.test.octonomy.ai/integration/api/v1/custom/genai",
        "pgvectorCredentialStoreUrl": "https://api.internal.test.octonomy.ai/integration/api/v1/custom/kms",
        "apiProxyArn": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
        "envMode": "test",
        "credUrl": "https://api.internal.test.octonomy.ai/integration/api/v1/",
        "etlApiUrl": "https://api.internal.test.octonomy.ai/etl/api/v1/job",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-Extraction-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-Cleaning-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-Translation-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-KnowledgeCreation-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-Chunking-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-ChunkEnhancement-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-vectorload-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
    name                     = "qs-test-ec1-etl-full-load-stf-v2"
    role_arn                 = "arn:aws:iam::637423349055:role/qs-test-ec1-etl-stf-iam-role-v2"
    log_group_name           = "qs-test-ec1-etl-full-load-stf-log-v2"
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "PATCH",
        "path.$": "States.Format('https://api.internal.test.octonomy.ai/etl/api/v1/job/{}/executions/{}', $.meta.jobId, $.meta.jobExecutionId)",
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
        "uri": "https://api.internal.test.octonomy.ai/integration/api/v1/stf/custom/storage/sharepoint",
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
            "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "uri": "https://api.internal.test.octonomy.ai/integration/api/v1/stf/custom/kms/coda",
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
            "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
            "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
            "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "uri": "https://api.internal.test.octonomy.ai/integration/api/v1/stf/custom/kms/atlassianconfluence/get_pages_by_space_id",
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
            "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "QueueUrl": "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-etl-glue-job-sqs-v2",
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
    name                     = "qs-test-ec1-evaluation-processing-stf-v2"
    role_arn                 = "arn:aws:iam::637423349055:role/qs-test-ec1-evaluation-processing-stf-iam-role-v2"
    log_group_name           = "qs-test-ec1-evaluation-processing-stf-log-v2"
    include_execution_data   = "true"
    level                    = "ALL"
    state_machine_definition = <<EOF
{
  "Comment": "Evaluation ETL Workflow with Ground Truth, Retrieval Response and Evaluation Jobs",
  "StartAt": "FetchJobInfo",
  "States": {
    "FetchJobInfo": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
      "Parameters": {
        "httpMethod": "GET",
        "path.$": "States.Format('https://api.internal.test.octonomy.ai/etl/api/v1/job/{}/evaluations/{}', $.jobId, $.evaluationId)",
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
        "apiProxyUrl": "https://api.internal.test.octonomy.ai",
        "apiProxyArn": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
        "envMode": "test",
        "credUrl": "https://api.internal.test.octonomy.ai/integration/api/v1/",
        "etlApiUrl.$": "States.Format('https://api.internal.test.octonomy.ai/etl/api/v1/job/{}/evaluations', $.jobId)",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-GroundTruth-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-RetrieveResponse-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
        "JobName": "qs-test-ec1-EvaluationSummary-glue-v2",
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
      "Resource": "arn:aws:lambda:eu-central-1:637423349055:function:qs-test-ec1-internal-api-proxy-lambda-v2",
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
    connection_name = "qs-test-ec1-connection-glue-v2"
    secret_name     = "qs-test-ec1-glue-data-connection-v2"
    username        = "glueuser"
  }
}

#################################
##### ETL GLUE CONNECTION #######
#################################

data_connection = {
  connection_001 = {
    glue_subnets_name  = "qs-test-ec1-private-sne-rds-01a-v2"
    security_group_rds = "qs-test-ec1-rds-nsg-test"
    connection_name    = "qs-test-ec1-connection-glue-v2"
    rds_cluster_name   = "qs-test-ec1-test-rds-v2"
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
    connection_name           = ["qs-test-ec1-connection-glue-v2"]
    default_arguments         = {}
    description               = "qs-test-ec1-vectorload-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-vectorload-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-vectorload-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-vectorload-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_002 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-Translation-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-Translation-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-Translation-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-Translation-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_003 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-KnowledgeCreation-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-KnowledgeCreation-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-KnowledgeCreation-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-KnowledgeCreation-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_004 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-Chunking-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-Chunking-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-Chunking-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-Chunking-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_005 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-Cleaning-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-Cleaning-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-Cleaning-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-Cleaning-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_006 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-Extraction-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-Extraction-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-Extraction-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-Extraction-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_007 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-ChunkEnhancement-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-ChunkEnhancement-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-ChunkEnhancement-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-ChunkEnhancement-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_008 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-GroundTruth-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-GroundTruth-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-GroundTruth-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-GroundTruth-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_009 = {
    connections_use           = true
    connection_name           = ["qs-test-ec1-connection-glue-v2"]
    default_arguments         = {}
    description               = "qs-test-ec1-RetrieveResponse-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-RetrieveResponse-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-RetrieveResponse-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-RetrieveResponse-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
  etl_job_010 = {
    connections_use           = false
    default_arguments         = {}
    description               = "qs-test-ec1-EvaluationSummary-glue-v2"
    execution_class           = "STANDARD"
    glue_version              = "3.0"
    job_run_queuing_enabled   = false
    maintenance_window        = null
    max_retries               = 1
    name                      = "qs-test-ec1-EvaluationSummary-glue-v2"
    non_overridable_arguments = {}
    role_arn                  = "arn:aws:iam::637423349055:role/qs-test-ec1-glue-iam-role-v2"
    security_configuration    = null
    tags                      = { workload = "qs-test-ec1-EvaluationSummary-glue-v2" }
    timeout                   = 2880
    worker_type               = null
    command_name              = "pythonshell"
    python_version            = "3.9"
    script_location           = "s3://qs-test-ec1-gluescript-s3-v2/scripts/qs-test-ec1-EvaluationSummary-glue-v2.py"
    max_concurrent_runs       = 10
    max_retries               = 0
  }
}


alarms = {
  "alarm0001" = {
    alarm_name                = "qs-test-ec1-alarm-sqs-full-load-messagesvisible-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      QueueName = "qs-test-ec1-etl-full-load-sqs-v2"
    }
  }
  "alarm0002" = {
    alarm_name                = "qs-test-ec1-alarm-sqs-full-load-dlq-messagesvisible-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      QueueName = "qs-test-ec1-etl-full-load-dead-letter-sqs-v2"
    }
  }
  "alarm0003" = {
    alarm_name                = "qs-test-ec1-alarm-sqs-incremental-load-messagesvisible-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    actions_enabled           = true
    dimensions = {
      QueueName = "qs-test-ec1-etl-incremental-load-sqs-v2"
    }
  }
  "alarm0004" = {
    alarm_name                = "qs-test-ec1-alarm-sqs-incremental-load-dlq-messagesvisible-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      QueueName = "qs-test-ec1-etl-incremental-dead-letter-sqs-v2"
    }
  }
  "alarm0005" = {
    alarm_name                = "qs-test-ec1-alarm-sqs-glue-job-messagesvisible-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      QueueName = "qs-test-ec1-etl-glue-job-sqs-v2"
    }
  }
  "alarm0006" = {
    alarm_name                = "qs-test-ec1-alarm-sqs-glue-job-dlq-messagesvisible-v2"
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
    sns_name                  = "qs-test-ec1-sns-alert-v2"
    dimensions = {
      QueueName = "qs-test-ec1-etl-glue-job-sqs-dead-letter-sqs-v2"
    }
  }
}
environment             = "test"
sns_topic               = "qs-test-ec1-sns-alert-v2"
image_uri               = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
sf_threshold            = 5
lambda_errors_threshold = 5
lambdas                 = ["qs-test-ec1-cw-log-sqs-lambda", "qs-test-ec1-etl-full-load-process-lambda-v2", "qs-test-ec1-post-signup-trigger-lambda-v2", "qs-test-ec1-cw-metric-sqs-lambda", "qs-test-ec1-etl-incremental-load-process-lambda-v2", "qs-test-rds-snapshot-lambda", "qs-test-ec1-internal-api-proxy-lambda-v2", "qs-test-ec1-etl-full-load-dlq-process-lambda-v2", "qs-test-ec1-etl-incremental-load-dlq-process-lambda-v2", "qs-test-ec1-etl-glue-job-process-lambda-v2"]

#####################
##### SES_DOMAIN ####
#####################

ses_domain = {
  "ses0001" = {
    ses_domain_name          = "octonomy.ai"
    ses_identity_policy_name = "Policy-1746453319894"
    notification_type        = ["Bounce", "Complaint"]
    topic_arn                = "arn:aws:sns:eu-central-1:637423349055:qs-test-ec1-sns-alert-v2"
    ses_domain_identity_policy = {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "ControlAction",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "637423349055"
          },
          "Action" : [
            "ses:SendEmail",
            "ses:SendRawEmail"
          ],
          "Resource" : "arn:aws:ses:eu-central-1:637423349055:identity/octonomy.ai",
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
  "test-support@octonomy.ai"
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
        Resource = "arn:aws:ses:eu-central-1:637423349055:identity/test-support@octonomy.ai"
        Condition = {
          StringEquals = {
            "ses:FromAddress" = "test-support@octonomy.ai"
          }
        }
      }
    ]
  }
]

ps_function_name                   = "qs-test-ec1-post-signup-trigger-v3"
ps_image_uri                       = "654654596584.dkr.ecr.eu-central-1.amazonaws.com/lambda-core:release-v1.15.0-66-a2be567"
ps_role_arn                        = "arn:aws:iam::637423349055:role/qs-test-ec1-trigger-lambda-iam-role"
ps_db_data_migration_sqs_queue_url = "https://sqs.eu-central-1.amazonaws.com/637423349055/qs-test-ec1-cognito-user-sync-sqs-v2"
