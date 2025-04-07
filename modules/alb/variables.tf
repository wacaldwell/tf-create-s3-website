variable "alb_subdomain" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "ssh_security_group_id" {
  type = string
}