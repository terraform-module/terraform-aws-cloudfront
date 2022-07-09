locals {
  origin_access_identity  = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
  origin_id               = aws_cloudfront_origin_access_identity.this.id
  response_headers_policy = var.default_cache_behavior != null && try(var.default_cache_behavior["response_headers_policy_id"], null) != null
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = var.comment
}

resource "aws_cloudfront_distribution" "this" {

  enabled         = var.enabled
  aliases         = var.aliases
  price_class     = var.price_class
  is_ipv6_enabled = var.is_ipv6_enabled
  comment         = var.comment

  default_root_object = var.default_root_object

  dynamic "origin" {

    for_each = [for i in var.s3_origin_config : {
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

  dynamic "default_cache_behavior" {
    iterator = i
    for_each = [var.default_cache_behavior]

    content {
      allowed_methods  = lookup(i.value, "allowed_methods", ["GET", "HEAD", "OPTIONS"])
      cached_methods   = lookup(i.value, "cached_methods", ["GET", "HEAD"])
      target_origin_id = lookup(i.value, "target_origin_id", local.origin_id)
      compress         = lookup(i.value, "compress", null)

      response_headers_policy_id = join("", data.aws_cloudfront_response_headers_policy.this.*.id)

      forwarded_values {
        query_string = lookup(i.value, "query_string", false)
        cookies {
          forward = lookup(i.value, "cookies_forward", "none")
        }
        headers = lookup(i.value, "headers", null)
      }

      viewer_protocol_policy = lookup(i.value, "viewer_protocol_policy", "allow-all")

      min_ttl     = lookup(i.value, "min_ttl", 0)
      default_ttl = lookup(i.value, "default_ttl", 3600)
      max_ttl     = lookup(i.value, "max_ttl", 86400)
    }
  }

  viewer_certificate {
    acm_certificate_arn            = lookup(var.viewer_certificate, "acm_certificate_arn", null)
    cloudfront_default_certificate = lookup(var.viewer_certificate, "cloudfront_default_certificate", null)
    iam_certificate_id             = lookup(var.viewer_certificate, "iam_certificate_id", null)

    minimum_protocol_version = lookup(var.viewer_certificate, "minimum_protocol_version", "TLSv1")
    ssl_support_method       = lookup(var.viewer_certificate, "ssl_support_method", null)
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
