# Terraform S3 Backend & AWS Provider Setup

This configuration sets up Terraform to use an S3 bucket as the remote backend for state management, and configures the AWS and Random providers.

## Configuration Details

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

  backend "s3" {
    bucket = "bucket-bucket-lucket"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

## Requirements

- The S3 bucket (bucket-bucket-lucket) must be created manually before running terraform init.
- Backend blocks cannot use variables, data sources, or resource references.
- AWS credentials must be configured via environment variables, credential profiles, or IAM roles.

## Optional: Enable State Locking

To enable state locking with DynamoDB:

aws dynamodb create-table \
  --table-name terraform-lock-table \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

Then add this to the backend block:

dynamodb_table = "terraform-lock-table"

## Usage

1. Create the S3 bucket:

aws s3api create-bucket --bucket bucket-bucket-lucket --region us-east-1

2. (Optional) Set up DynamoDB for state locking.

3. Initialize Terraform:

terraform init

4. Plan and apply:

terraform plan  
terraform apply

## Notes

- Terraform will store your state file in the specified S3 bucket.
- Use terraform fmt -recursive to format your code.