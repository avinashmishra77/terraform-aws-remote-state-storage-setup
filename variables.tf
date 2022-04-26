# Input variable
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