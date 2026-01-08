# IP Set for allowed IPs to access /api/appconnect/docs
resource "aws_wafv2_ip_set" "allowed_ips_for_docs" {
  name               = "qs-${var.environment}-ec1-allowed-ips-docs"
  description        = "IP set for allowed IPs to access /api/appconnect/docs"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"

  addresses = [
    "14.194.184.67/32" # Example IP range - replace with actual IPs
    # Add your specific IP addresses here
  ]

  tags = {
    Name        = "qs-${var.environment}-ec1-allowed-ips-docs"
    Environment = var.environment
  }
}

resource "aws_wafv2_web_acl" "this" {
  name        = "qs-${var.environment}-ec1-web-acl-alb"
  description = "Web ACL for ALB in ${var.environment} environment"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # Rate limiting rule
  rule {
    name     = "qs-${var.environment}-ec1-rate-limit-rule"
    priority = 0

    action {
      count {}
    }

    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "qs-${var.environment}-ec1-rate-limit-rule-metric"
      sampled_requests_enabled   = false
    }
  }

  # F5 OWASP Managed Rule Group
  rule {
    name     = "F5-OWASP_Managed"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "OWASP_Managed"
        vendor_name = "F5"

        dynamic "rule_action_override" {
          for_each = [
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
          content {
            name = rule_action_override.value
            action_to_use {
              count {}
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "F5-OWASP_Managed"
      sampled_requests_enabled   = false
    }
  }

  # URL Block Rule for /api/appconnect/docs - Only allow specific IPs
  rule {
    name     = "qs-${var.environment}-ec1-url-block-waf-rule"
    priority = 2

    action {
      block {
        custom_response {
          response_code            = 403
          custom_response_body_key = "403-response-page"
        }
      }
    }

    statement {
      and_statement {
        statement {
          byte_match_statement {
            search_string         = "/api/appconnect/docs"
            positional_constraint = "CONTAINS"
            field_to_match {
              uri_path {}
            }
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              ip_set_reference_statement {
                arn = aws_wafv2_ip_set.allowed_ips_for_docs.arn
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "qs-${var.environment}-ec1-url-block-waf-rule"
      sampled_requests_enabled   = false
    }
  }

  # Country allow rule
  rule {
    name     = "qs-${var.environment}-ec1-country-restrictions-allow-waf-rule"
    priority = 3

    action {
      allow {}
    }

    statement {
      geo_match_statement {
        country_codes = [
          "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
          "VA", "HU", "IS", "IN", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT", "MD", "MC", "ME", "NL",
          "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "UA", "GB", "US"
        ]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "qs-${var.environment}-ec1-country-restrictions-allow-waf-rule"
      sampled_requests_enabled   = false
    }
  }

  # Country block rule - 1
  rule {
    name     = "qs-${var.environment}-ec1-country-restrictions-block-waf-rule"
    priority = 4

    action {
      block {
        custom_response {
          response_code            = 403
          custom_response_body_key = "403-response-page"
        }
      }
    }

    statement {
      geo_match_statement {
        country_codes = [
          "AF", "DZ", "AS", "AD", "AO", "AI", "AQ", "AG", "AR", "AM", "AW", "AU", "AZ", "BS", "BH", "BD",
          "BB", "BY", "BZ", "BJ", "BM", "BT", "BO", "BQ", "BA", "BW", "BV", "BR", "IO", "BN", "KH", "CM",
          "CA", "CV", "KY", "CF", "TD", "CL", "CN", "CX", "CC", "CO", "KM", "CG", "CD", "CK", "CR", "CI",
          "CU", "CW"
        ]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "qs-${var.environment}-ec1-country-restrictions-block-waf-rule"
      sampled_requests_enabled   = false
    }
  }

  # Country block rule - 2
  rule {
    name     = "qs-${var.environment}-ec1-country-restrictions-block-waf-rule-2"
    priority = 5

    action {
      block {
        custom_response {
          response_code            = 403
          custom_response_body_key = "403-response-page"
        }
      }
    }

    statement {
      geo_match_statement {
        country_codes = [
          "DJ", "DM", "DO", "EC", "EG", "SV", "GQ", "ER", "ET", "FK", "FO", "FJ", "GA", "GM", "GH", "GI",
          "GP", "GU", "GT", "GG", "GN", "GW", "GY", "HT", "HM", "VA", "HN", "HK", "IS", "ID", "IR", "IQ",
          "JP", "JE", "JO", "KZ", "KE", "KI", "KP", "KR", "KW", "GL", "GD", "IL", "JM", "LB", "LR", "RU",
          "KG", "LA"
        ]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "qs-${var.environment}-ec1-country-restrictions-block-waf-rule-2"
      sampled_requests_enabled   = false
    }
  }

  # Custom Response Body for 403
  custom_response_body {
    key = "403-response-page"

    content_type = "TEXT_HTML"
    content      = <<HTML
<!DOCTYPE html>
<html>
<head><title>403 Forbidden</title></head>
<body>
  <h1>403 Forbidden</h1>
  <p>Your request has been blocked by AWS WAF.</p>
</body>
</html>
HTML
  }


  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "qs-${var.environment}-stg-ec1-country-restrictions-allow-waf-rule"
    sampled_requests_enabled   = false
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  token_domains = ["mywebsite.com", "myotherwebsite.com"]
}

module "waf_cloudwatch_log_group" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name = "aws-waf-logs-${var.environment}-ec1-web-acl-alb-${var.project_version}"
  tags           = var.tags
}

resource "aws_wafv2_web_acl_logging_configuration" "this" {
  log_destination_configs = [module.waf_cloudwatch_log_group.arn]
  resource_arn            = aws_wafv2_web_acl.this.arn
}