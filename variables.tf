variable "tags" {
  default     = {}
  description = "A mapping of tags to assign to the object."
  type        = map
}

variable "enabled" {
  default     = "true"
  description = "Set to false to prevent the module from creating any resources."
  type        = bool
}

variable "comment" {
  default     = "Managed by Terraform"
  description = "Any comments you want to include about the distribution."
  type        = string
}

variable "dynamic_s3_origin_config" {
  default     = []
  description = "Configuration for the s3 origin config to be used in dynamic block."
  type        = list(map(string))
}

variable "price_class" {
  default     = "PriceClass_100"
  description = "The price class for this distribution. Values: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`."
  type        = string
}

variable "is_ipv6_enabled" {
  default     = "false"
  description = "State of CloudFront IPv6"
  type        = bool
}

variable "geo_restrictions" {
  default = [{
    locations        = []
    restriction_type = "none"
  }]
  description = "The method that you want to use to restrict distribution of your content by country."
  type = list(object({
    locations        = list(string)
    restriction_type = string
  }))
}

variable "viewer_certificate" {
  default = {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = null
    acm_certificate_arn            = null
    iam_certificate_id             = null
  }
  description = "The SSL configuration for this distribution (maximum one)."
  type = object({
    cloudfront_default_certificate = bool
    minimum_protocol_version       = string
    ssl_support_method             = string
    acm_certificate_arn            = string
    iam_certificate_id             = string
  })
}
