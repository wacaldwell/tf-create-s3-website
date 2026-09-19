# Include modules
module "s3" {
  source         = "./modules/s3"
  domain_name    = var.domain_name
  site_subdomain = var.site_subdomain
}

module "acm" {
  source         = "./modules/cert"
  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  site_subdomain = var.site_subdomain
  alb_subdomain  = var.alb_subdomain
}

module "cloudfront" {
  source          = "./modules/cloudfront"
  s3_bucket_name  = module.s3.bucket_name
  certificate_arn = module.acm.certificate_arn
  domain_name     = var.domain_name
  site_subdomain  = var.site_subdomain
}

module "alb" {
  source                = "./modules/alb"
  alb_subdomain         = var.alb_subdomain
  certificate_arn       = module.acm.certificate_arn
  hosted_zone_id        = var.hosted_zone_id
  domain_name           = var.domain_name
  vpc_id                = var.alb.vpc_id
  public_subnets        = var.alb.public_subnets
  ssh_security_group_id = var.alb.ssh_security_group_id
}

module "dns" {
  source                 = "./modules/route53"
  domain_name            = var.domain_name
  site_subdomain         = var.site_subdomain
  alb_subdomain          = var.alb_subdomain
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  alb_dns_name           = module.alb.alb_dns_name
  alb_zone_id            = module.alb.alb_zone_id
  hosted_zone_id         = var.hosted_zone_id
}