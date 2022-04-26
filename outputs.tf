# Output

output "s3_tf_bucket_name" {
  value = aws_s3_bucket.tf_state.bucket
}

output "dynamo_db_tf_lock_table_name" {
  value = aws_dynamodb_table.tf_locks.name
}