# Input variables
variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile to use to perform the operation"
  default     = "default"
}

variable "s3_bucket_name" {
  type        = string
  description = "Unique name for the S3 bucket to store terraform state."
  default     = "shastra-tf-state"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table to implement locking"
  default     = "tf-state-locks"
}