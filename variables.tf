variable "region" {
  default = "us-east-1"
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "site_subdomain" {
  description = "Subdomain for the website (e.g. www)"
  default     = "www"
}

variable "alb_subdomain" {
  description = "Subdomain for the backend behind ALB (e.g. api)"
  default     = "api"
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}