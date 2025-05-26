
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
}
#Resource block

# Random id resource to generate a unique suffix for the S3 bucket name because S3 bucket names must be globally unique.
resource "random_id" "bucket_suffix" {
  byte_length = 6  
}

# Create an S3 bucket with a unique name using the random_id resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-${random_id.bucket_suffix.hex}" # Using random_id to create a unique bucket name 
}

# Shows the output of the S3 bucket name
output "bucket_name" {
  value = aws_s3_bucket.example_bucket.bucket # Output the ID of the created S3 bucket
}