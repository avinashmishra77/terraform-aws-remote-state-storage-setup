####################################################################
# This TF script to setup remote backend storage to store TF state #
####################################################################
# Provider
provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = {
      CreatedBy = "terraform"
    }
  }
}

# S3 bucket to store TF state used as remote backend
resource "aws_s3_bucket" "tf_state" {
  bucket = var.s3_bucket_name
}

# Enable verision so we can see the full revision history of our state files
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [
    aws_s3_bucket.tf_state
  ]
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption_config" {
  bucket = aws_s3_bucket.tf_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

  depends_on = [
    aws_s3_bucket.tf_state
  ]
}

# DynamoDB table to use for locking TF state files
# => supports strongly-consistent reads and conditional writes
# => serverless, its completely managed, don't have to provision infrastucture to manage it
# => inexpensive
resource "aws_dynamodb_table" "tf_locks" {
  name = var.dynamodb_table_name

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
