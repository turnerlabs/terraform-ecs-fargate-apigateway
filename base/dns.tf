variable "zone" {
  type        = string
  description = "The Route53 zone in which to add the DNS entry"
}

# base zone for all environments
resource "aws_route53_zone" "main" {
  name = var.zone
  tags = var.tags
}
