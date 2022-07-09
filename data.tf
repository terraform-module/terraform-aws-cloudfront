data "aws_cloudfront_response_headers_policy" "this" {
  count = local.response_headers_policy ? 1 : 0
  name  = lookup(var.default_cache_behavior, "response_headers_policy_id")
}
