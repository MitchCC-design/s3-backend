# Terraform: S3 Bucket with Randomized Unique Name

This project provisions an AWS S3 bucket using Terraform, incorporating a randomly generated suffix to ensure the bucket name is globally unique.

## Overview

This configuration demonstrates:

- Use of the **AWS provider** for managing S3 resources.
- Use of the **Random provider** to generate a unique suffix.
- Construction of a dynamic S3 bucket name using Terraform interpolation.
- Output of the final bucket name after provisioning.

## Terraform Blocks Used

### Terraform Block

Specifies required Terraform version and providers:

```hcl
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}