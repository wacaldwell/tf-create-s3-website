variable "domain_name" {
  type = string
}

variable "site_subdomain" {
  type    = string
  default = "www"
}

variable "alb_subdomain" {
  type    = string
  default = "api"
}

variable "hosted_zone_id" {
  type = string
}