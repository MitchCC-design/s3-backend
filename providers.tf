
#Terraform block
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # Random provider for generating random values
    # This is useful for creating unique names or passwords.
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  # Backend configuration for Terraform state
  # This configuration uses an S3 bucket to store the Terraform state file.
  # The S3 bucket must be created before using it as a backend.
  # The bucket name, key, and region must be specified.
  backend "s3" {
    bucket = "bucket-bucket-lucket"
    key    = "state.tfstate"
    region = "us-east-1" # Specify the AWS region where the S3 bucket is located, does not have to be the same as the provider region.
  }
}
# Provider configuration for AWS
## This specifies the AWS region where resources will be created.
provider "aws" {
  region = "us-east-1"
}