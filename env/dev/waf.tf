resource "aws_wafregional_web_acl" "main" {
  name        = local.namespace
  metric_name = "tfWebACL"

  default_action {
    type = "ALLOW"
  }
}

resource "aws_wafregional_web_acl_association" "main" {
  web_acl_id   = aws_wafregional_web_acl.main.id
  resource_arn = "arn:aws:apigateway:${var.region}::/restapis/${aws_api_gateway_rest_api.main.id}/stages/${aws_api_gateway_deployment.main.stage_name}"
}