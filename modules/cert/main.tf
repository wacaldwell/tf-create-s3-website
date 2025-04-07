locals {
  site_fqdn = "${var.site_subdomain}.${var.domain_name}"
  alb_fqdn  = "${var.alb_subdomain}.${var.domain_name}"
}

resource "aws_acm_certificate" "cert" {
  domain_name               = local.site_fqdn
  subject_alternative_names = [local.alb_fqdn]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "site_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.site_validation : record.fqdn]
}