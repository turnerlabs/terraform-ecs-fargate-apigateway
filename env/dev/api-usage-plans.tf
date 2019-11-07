variable "api_usage_quota_limit" {
  type        = number
  default     = 1000
  description = "The maximum number of requests that can be made in a given time period"
}

variable "api_usage_quota_offset" {
  type        = number
  default     = 5
  description = "The number of requests subtracted from the given limit in the initial time period"
}

variable "api_usage_quota_period" {
  type        = string
  default     = "DAY"
  description = "The time period in which the limit applies. Valid values are 'DAY, 'WEEK' or 'MONTH'"
}

variable "api_usage_burst_limit" {
  type        = number
  default     = 10
  description = "The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity"
}

variable "api_usage_rate_limit" {
  type        = number
  default     = 20
  description = "The API request steady-state rate limit"
}

resource "aws_api_gateway_usage_plan" "main" {
  name        = local.namespace
  description = "default usage plan for ${local.namespace}"

  api_stages {
    api_id = aws_api_gateway_rest_api.main.id
    stage  = aws_api_gateway_deployment.main.stage_name
  }

  quota_settings {
    limit  = var.api_usage_quota_limit
    offset = var.api_usage_quota_offset
    period = var.api_usage_quota_period
  }

  throttle_settings {
    burst_limit = var.api_usage_burst_limit
    rate_limit  = var.api_usage_rate_limit
  }
}
