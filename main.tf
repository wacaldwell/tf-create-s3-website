provider "aws" {
  region = var.region
}

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
  source              = "./modules/alb"
  alb_subdomain       = var.alb_subdomain
  certificate_arn     = module.acm.certificate_arn
  hosted_zone_id      = var.hosted_zone_id
  domain_name         = var.domain_name
  vpc_id              = "vpc-021ed2459953ad688"
  public_subnets      = [
    "subnet-087d4a11148279855",
    "subnet-05a49ed7ef973b26f",
  ]
  ssh_security_group_id = "sg-01b2513b1f8443f0f"
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