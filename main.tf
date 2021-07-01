####################################################################
# This TF script to setup remote backend storage to store TF state #
####################################################################
# Provider
provider "aws" {
  region = "us-east-1"
  profile = "terraform"

  default_tags {
    tags = {
      Name = "tf-example"
    }   
  }
}

# Input variable
variable "s3_bucket_name" {
  type = string
  description = "Unique name for the S3 bucket to store terraform state."
}

# S3 bucket to store TF state used as remote backend
resource "aws_s3_bucket" "tf_state" {
  bucket = var.s3_bucket_name

  # Enable verision so we can see the full revision history of our state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Input variable
variable "dynamodb_table_name" {
  type = string
  description = "Name of the DynamoDB table to implement locking"
  default = "tf-state-locks"
}

# DynamoDB table to use for locking TF state files
# => supports strongly-consistent reads and conditional writes
# => serverless, its completely managed, don't have to provision infrastucture to manage it
# => inexpensive
resource "aws_dynamodb_table" "tf_locks" {
  name = var.dynamodb_table_name

  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
