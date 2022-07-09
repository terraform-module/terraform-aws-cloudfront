################################################################################
# WEBSITE
################################################################################
output "website" {
  description = "Configuration for S3 website"
  value       = { for k, v in module.website : k => v }
}

################################################################################
# CONTENT DELIVERY NETWORK
################################################################################
output "cdn" {
  description = "CDN configuration for S3 website"
  value       = { for k, v in module.cdn : k => v }
}

################################################################################
# ACM
################################################################################
output "acm" {
  description = "AWS ACM certificate resources"
  value       = { for k, v in module.acm : k => v if contains(["distinct_domain_names", "acm_certificate_arn", "acm_certificate_status"], k) }
}
