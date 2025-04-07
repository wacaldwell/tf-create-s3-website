variable "domain_name" {
  type = string
}

variable "site_subdomain" {
  type = string
}

variable "alb_subdomain" {
  type = string
}

variable "cloudfront_domain_name" {
  type    = string
  default = ""
}

variable "alb_dns_name" {
  type    = string
  default = ""
}

variable "alb_zone_id" {
  type    = string
  default = ""
}

variable "hosted_zone_id" {
  type = string
}