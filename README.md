# Terraform S3 Remote Backend Configuration

This Terraform configuration sets up an S3 bucket as the remote backend for storing the terraform.tfstate file.

## Backend Configuration

terraform {
  required_version = ">= 1.7.0"

  backend "s3" {
    bucket = "bucket-bucket-lucket"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}

## Requirements

- The S3 bucket (bucket-bucket-lucket) must exist before running terraform init.
- Terraform will use this bucket to store the remote state file at the key path state.tfstate.
- Backend blocks cannot use variables, data sources, or resource references — all values must be hardcoded.

## Optional: Enable State Locking

To avoid concurrent modifications to the state, create a DynamoDB table for state locking:

aws dynamodb create-table \
  --table-name terraform-lock-table \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

Then add the following to the backend block:

dynamodb_table = "terraform-lock-table"

## Usage

1. Create the S3 bucket:

aws s3api create-bucket --bucket bucket-bucket-lucket --region us-east-1

2. (Optional) Create the DynamoDB table (see above).

3. Initialize Terraform:

terraform init

4. Terraform will detect the S3 backend and configure state management accordingly.

## Notes

- The backend configuration is required at the top-level terraform block and cannot be dynamically generated.
- Remote state is essential for collaboration, CI/CD pipelines, and state safety.
- Always secure the S3 bucket with proper IAM policies and enable versioning/encryption.