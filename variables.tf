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

  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.price_class) ? true : false
    error_message = "The 'price class' value must be a valid value. Valid values: PriceClass_All, PriceClass_200, PriceClass_100."
  }
}

variable "is_ipv6_enabled" {
  default     = "false"
  description = "State of CloudFront IPv6"
  type        = bool
}
