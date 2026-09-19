variable "domain_name" {
  description = "The domain name"
  type        = string
}

variable "site_subdomain" {
  description = "The subdomain for the website"
  type        = string
}

variable "alb_subdomain" {
  description = "The subdomain for the ALB"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "The CloudFront distribution domain name"
  type        = string
}

variable "alb_dns_name" {
  description = "The ALB DNS name"
  type        = string
}

variable "alb_zone_id" {
  description = "The ALB zone ID"
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 hosted zone ID"
  type        = string
}