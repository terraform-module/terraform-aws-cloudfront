locals {
  origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
  origin_id              = aws_cloudfront_origin_access_identity.this.id
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = var.comment
}

resource "aws_cloudfront_distribution" "this" {

  enabled = var.enabled

  dynamic "origin" {

    for_each = [for i in var.dynamic_s3_origin_config : {
      name          = i.domain_name
      id            = lookup(i, "origin_id", local.origin_id)
      identity      = lookup(i, "origin_access_identity", null)
      path          = lookup(i, "origin_path", null)
      custom_header = lookup(i, "custom_header", null)
    }]

    content {
      domain_name = origin.value.name
      origin_id   = origin.value.id
      origin_path = origin.value.path

      dynamic "custom_header" {
        for_each = origin.value.custom_header == null ? [] : [for i in origin.value.custom_header : {
          name  = i.name
          value = i.value
        }]
        content {
          name  = custom_header.value.name
          value = custom_header.value.value
        }
      }
      dynamic "s3_origin_config" {
        for_each = origin.value.identity == null ? [local.origin_access_identity] : [origin.value.identity]
        content {
          origin_access_identity = s3_origin_config.value
        }
      }
    }
  }

  is_ipv6_enabled = var.is_ipv6_enabled
  comment         = var.comment

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = var.price_class

  dynamic "viewer_certificate" {

    iterator = i
    for_each = var.viewer_certificate == null ? [{
      cloudfront_default_certificate = true
      minimum_protocol_version       = "TLSv1"
    }] : [var.viewer_certificate]

    content {
      cloudfront_default_certificate = i.value.cloudfront_default_certificate
      minimum_protocol_version       = i.value.minimum_protocol_version
      ssl_support_method             = lookup(i, "ssl_support_method", null)
      acm_certificate_arn            = lookup(i, "acm_certificate_arn", null)
      iam_certificate_id             = lookup(i, "iam_certificate_id", null)
    }
  }

  restrictions {
    dynamic "geo_restriction" {
      iterator = e
      for_each = var.geo_restrictions == null ? [] : var.geo_restrictions

      content {
        locations        = e.value.locations
        restriction_type = e.value.restriction_type
      }
    }
  }

  tags = var.tags
}
