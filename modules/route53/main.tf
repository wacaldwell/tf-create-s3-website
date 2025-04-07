locals {
  site_fqdn = "${var.site_subdomain}.${var.domain_name}"
  alb_fqdn  = "${var.alb_subdomain}.${var.domain_name}"
}

resource "aws_route53_record" "site" {
  count = var.cloudfront_domain_name != "" ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = local.site_fqdn
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = "Z2FDTNDATAQYW2" # CloudFront hosted zone ID
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alb" {
  count = var.alb_dns_name != "" ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = local.alb_fqdn
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
