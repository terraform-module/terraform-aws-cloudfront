locals {
  region      = "eu-west-1"
  domain_name = "terraform-aws-modules.tf"
  subdomain   = "frontend"
  bucket_name = "${local.subdomain}-terraform-aws-modules"
}

provider "aws" {
  region = local.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}

######
# ACM
######

data "aws_route53_zone" "this" {
  name = local.domain_name
}

# https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-invalid-viewer-certificate/
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4"

  providers = {
    aws = aws.useast1
  }

  domain_name               = local.domain_name
  zone_id                   = data.aws_route53_zone.this.id
  subject_alternative_names = ["${local.subdomain}.${local.domain_name}"]
}

#############
# S3
#############
module "website" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3"

  bucket        = local.ui_bucket_name
  acl           = "private"
  attach_policy = true
  policy        = data.aws_iam_policy_document.ui_bucket_policy.json

  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#############
# Cloudfront
#############
module "cdn" {
  source = "../../"

  comment             = format("%s.%s.com", var.prefix, var.env)
  aliases             = ["frontend.${local.domain_name}"]
  default_root_object = "index.html"

  s3_origin_config = [{
    domain_name = local.s3_region_domain
  }]

  viewer_certificate = {
    acm_certificate_arn = module.acm.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  default_cache_behavior = {
    min_ttl                    = 1000
    default_ttl                = 1000
    max_ttl                    = 1000
    cookies_forward            = "none"
    response_headers_policy_id = "Managed-SecurityHeadersPolicy"
    headers = [
      "Origin",
      "Access-Control-Request-Headers",
      "Access-Control-Request-Method"
    ]
  }
}
