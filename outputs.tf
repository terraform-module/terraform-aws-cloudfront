##
# CDN Access Identity
##
output "ai_id" {
  description = "Access identity identifier for the distribution.  For example: EDFDVBD632BHDS5"
  value       = aws_cloudfront_origin_access_identity.this.id
}

output "ai_iam_arn" {
  description = "Access identity pre-generated ARN for use in S3 bucket policies"
  value       = aws_cloudfront_origin_access_identity.this.iam_arn
}

output "ai_path" {
  description = "Access identity shortcut to the full path for the origin access identity to use in CloudFron"
  value       = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
}

output "cf_id" {
  description = "ID of AWS CloudFront distribution"
  value       = aws_cloudfront_distribution.this.id
}

output "cf_arn" {
  description = "ARN of AWS CloudFront distribution"
  value       = aws_cloudfront_distribution.this.arn
}

output "cf_status" {
  description = "Current status of the distribution"
  value       = aws_cloudfront_distribution.this.status
}

output "cf_domain_name" {
  description = "Domain name corresponding to the distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cf_etag" {
  description = "Current version of the distribution's information"
  value       = aws_cloudfront_distribution.this.etag
}

output "cf_hosted_zone_id" {
  description = "CloudFront Route 53 zone ID"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}
