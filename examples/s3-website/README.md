# AWS CDN setup

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Parameters

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | terraform-aws-modules/acm/aws | ~> 4 |
| <a name="module_cdn"></a> [cdn](#module\_cdn) | ../../ | n/a |
| <a name="module_website"></a> [website](#module\_website) | terraform-aws-modules/s3-bucket/aws | ~> 3 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.ui_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm"></a> [acm](#output\_acm) | AWS ACM certificate resources |
| <a name="output_cdn"></a> [cdn](#output\_cdn) | CDN configuration for S3 website |
| <a name="output_website"></a> [website](#output\_website) | Configuration for S3 website |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
