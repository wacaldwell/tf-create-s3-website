##########################################
# File: ephemeral/main.tf
##########################################

data "terraform_remote_state" "persistent" {
  backend = "s3"
  config = {
    bucket = "tf-state-bucket-digitalclownshow"
    key    = "persistent/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

module "cloudfront" {
  source            = "../modules/cloudfront"
  s3_bucket_name    = data.terraform_remote_state.persistent.outputs.bucket_name
  certificate_arn   = data.terraform_remote_state.persistent.outputs.certificate_arn
  domain_name       = data.terraform_remote_state.persistent.outputs.domain_name
  site_subdomain    = data.terraform_remote_state.persistent.outputs.site_subdomain
}

module "alb" {
  source                = "../modules/alb"
  alb_subdomain         = data.terraform_remote_state.persistent.outputs.alb_subdomain
  certificate_arn       = data.terraform_remote_state.persistent.outputs.certificate_arn
  hosted_zone_id        = data.terraform_remote_state.persistent.outputs.hosted_zone_id
  domain_name           = data.terraform_remote_state.persistent.outputs.domain_name
  vpc_id                = "vpc-021ed2459953ad688"
  public_subnets        = [
    "subnet-087d4a11148279855",
    "subnet-05a49ed7ef973b26f"
  ]
  ssh_security_group_id = "sg-01b2513b1f8443f0f"
}

module "route53" {
  source                 = "../modules/route53"
  domain_name            = data.terraform_remote_state.persistent.outputs.domain_name
  site_subdomain         = data.terraform_remote_state.persistent.outputs.site_subdomain
  alb_subdomain          = data.terraform_remote_state.persistent.outputs.alb_subdomain
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  alb_dns_name           = module.alb.alb_dns_name
  alb_zone_id            = module.alb.alb_zone_id
  hosted_zone_id         = data.terraform_remote_state.persistent.outputs.hosted_zone_id
}
