# terraform-aws-cloudfront

Terraform Module that implements a CloudFront Distribution (CDN) for a custom origin (e.g. website or video streaming)

![](https://github.com/terraform-module/terraform-aws-cloudfront/workflows/release/badge.svg)
![](https://github.com/terraform-module/terraform-aws-cloudfront/workflows/commit-check/badge.svg)
![](https://github.com/terraform-module/terraform-aws-cloudfront/workflows/labeler/badge.svg)

[![](https://img.shields.io/github/license/terraform-module/terraform-aws-cloudfront)](https://github.com/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/github/v/tag/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/issues/github/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/github/issues/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/github/issues-closed/terraform-module/terraform-aws-cloudfront)
[![](https://img.shields.io/github/languages/code-size/terraform-module/terraform-aws-cloudfront)](https://github.com/terraform-module/terraform-aws-cloudfront)
[![](https://img.shields.io/github/repo-size/terraform-module/terraform-aws-cloudfront)](https://github.com/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/github/languages/top/terraform-module/terraform-aws-cloudfront?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/github/contributors/terraform-module/terraform-aws-cloudfront)
![](https://img.shields.io/github/last-commit/terraform-module/terraform-aws-cloudfront)
[![Maintenance](https://img.shields.io/badge/Maintenu%3F-oui-green.svg)](https://GitHub.com/terraform-module/terraform-aws-cloudfront/graphs/commit-activity)
[![GitHub forks](https://img.shields.io/github/forks/terraform-module/terraform-aws-cloudfront.svg?style=social&label=Fork)](https://github.com/terraform-module/terraform-aws-cloudfront)

## Documentation

- [TFLint Rules](https://github.com/terraform-linters/tflint/tree/master/docs/rules)
- [AWS CDN Price classes](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html)
- [AWS CDN Origins](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DownloadDistS3AndCustomOrigins.html)

### Terraform resources

- [Cloudfront Distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)
- [Origin Access Identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity)

### References

- [CDN with S3](https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn)
- [CDN jmg](https://github.com/jmgreg31/terraform-aws-cloudfront)
- [CDN Cloudposse](https://github.com/cloudposse/terraform-aws-cloudfront-cdn)

## Usage example

IMPORTANT: The master branch is used in source just as an example. In your code, do not pin to master because there may be breaking changes between releases. Instead pin to the release tag (e.g. ?ref=tags/x.y.z) of one of our [latest releases](https://github.com/terraform-module/terraform-aws-cloudfront/releases).

```hcl
module cloudfront {
  source  = "terraform-module/cloudfront/aws"
  version = "0.12.2"

  tags = { Environment = "dev" }
  comment = "dev"
  dynamic_s3_origin_config = [{
    domain_name = "media-assets.s3.us-west-2.amazonaws.com"
  }]
}
```

## Assumptions

## Available features

## Module Variables

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 2.67 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.67 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/2.67/docs/resources/cloudfront_distribution) |
| [aws_cloudfront_origin_access_identity](https://registry.terraform.io/providers/hashicorp/aws/2.67/docs/resources/cloudfront_origin_access_identity) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| comment | Any comments you want to include about the distribution. | `string` | `"Managed by Terraform"` | no |
| default\_cache\_behavior | Default Cache Behviors to be used in dynamic block. | `any` | <pre>{<br>  "allowed_methods": [<br>    "GET",<br>    "HEAD",<br>    "OPTIONS"<br>  ],<br>  "default_ttl": 3600,<br>  "max_ttl": 86400,<br>  "min_ttl": 0<br>}</pre> | no |
| enabled | Set to false to prevent the module from creating any resources. | `bool` | `"true"` | no |
| geo\_restrictions | The method that you want to use to restrict distribution of your content by country. | <pre>list(object({<br>    locations        = list(string)<br>    restriction_type = string<br>  }))</pre> | <pre>[<br>  {<br>    "locations": [],<br>    "restriction_type": "none"<br>  }<br>]</pre> | no |
| is\_ipv6\_enabled | State of CloudFront IPv6 | `bool` | `"false"` | no |
| price\_class | The price class for this distribution. Values: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`. | `string` | `"PriceClass_100"` | no |
| s3\_origin\_config | Configuration for the s3 origin config to be used in dynamic block. | `list(map(string))` | `[]` | no |
| tags | A mapping of tags to assign to the object. | `map` | `{}` | no |
| viewer\_certificate | The SSL configuration for this distribution (maximum one). | <pre>object({<br>    cloudfront_default_certificate = bool<br>    minimum_protocol_version       = string<br>    ssl_support_method             = string<br>    acm_certificate_arn            = string<br>    iam_certificate_id             = string<br>  })</pre> | <pre>{<br>  "acm_certificate_arn": null,<br>  "cloudfront_default_certificate": true,<br>  "iam_certificate_id": null,<br>  "minimum_protocol_version": "TLSv1",<br>  "ssl_support_method": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| ai\_iam\_arn | Access identity pre-generated ARN for use in S3 bucket policies |
| ai\_id | Access identity identifier for the distribution.  For example: EDFDVBD632BHDS5 |
| ai\_path | Access identity shortcut to the full path for the origin access identity to use in CloudFron |
| cf\_arn | ARN of AWS CloudFront distribution |
| cf\_domain\_name | Domain name corresponding to the distribution |
| cf\_etag | Current version of the distribution's information |
| cf\_hosted\_zone\_id | CloudFront Route 53 zone ID |
| cf\_id | ID of AWS CloudFront distribution |
| cf\_status | Current status of the distribution |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Commands

<!-- START makefile-doc -->
```
$ make help 
hooks                          Commit hooks setup
validate                       Validate with pre-commit hooks
changelog                      Update changelog 
```
<!-- END makefile-doc -->

### :memo: Guidelines

 - :memo: Use a succinct title and description.
 - :bug: Bugs & feature requests can be be opened
 - :signal_strength: Support questions are better asked on [Stack Overflow](https://stackoverflow.com/)
 - :blush: Be nice, civil and polite ([as always](http://contributor-covenant.org/version/1/4/)).

## License

Copyright 2019 Ivan Katliarhcuk

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## How to Contribute

Submit a pull request

# Authors

Currently maintained by [Ivan Katliarchuk](https://github.com/ivankatliarchuk) and these [awesome contributors](https://github.com/terraform-module/terraform-aws-cloudfront/graphs/contributors).

[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)

## Terraform Registry

- [Module](https://registry.terraform.io/modules/terraform-module/todo/aws)
