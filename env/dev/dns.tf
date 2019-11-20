variable "zone" {
  type        = string
  description = "The Route53 zone in which to add the DNS entry"
}

variable "domain" {
  type        = string
  description = "The domain name for your API Gateway endpoint"
}

data "aws_route53_zone" "main" {
  name = var.zone
}

resource "aws_api_gateway_domain_name" "main" {
  domain_name              = var.domain
  regional_certificate_arn = aws_acm_certificate.main.arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = aws_api_gateway_domain_name.main.domain_name
  type    = "CNAME"
  records = [aws_api_gateway_domain_name.main.regional_domain_name]
  ttl     = "60"
}
