module "s3" {
  source         = "../modules/s3"
  domain_name    = var.domain_name
  site_subdomain = var.site_subdomain
}

module "cert" {
  source          = "../modules/cert"
  domain_name     = var.domain_name
  site_subdomain  = var.site_subdomain
  alb_subdomain   = var.alb_subdomain
  hosted_zone_id  = var.hosted_zone_id
}

module "route53" {
  source                 = "../modules/route53"
  domain_name            = var.domain_name
  site_subdomain         = var.site_subdomain
  alb_subdomain          = var.alb_subdomain
  cloudfront_domain_name = ""
  alb_dns_name           = ""
  alb_zone_id            = ""
  hosted_zone_id         = var.hosted_zone_id
}
