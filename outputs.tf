# S3 outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting the website"
  value       = module.s3.bucket_name
}

# CloudFront outputs
output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_domain_name
}

# ACM outputs
output "certificate_arn" {
  description = "ARN of the SSL certificate"
  value       = module.acm.certificate_arn
}

# ALB outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Route53 zone ID of the Application Load Balancer"
  value       = module.alb.alb_zone_id
} 