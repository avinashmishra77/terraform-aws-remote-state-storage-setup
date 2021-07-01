# terraform-aws-remote-state-storage-setup

> Add the below block in your TF configuration file to enable remote state storage,
> Make sure, the S3 bucket and DynamoDB tables are already created
```sh
# Terraform configuration
terraform{

  # remote backend to store TF state
  backend "s3" {
    bucket = "<insert-s3-bucket-name>"
    key = "<insert-s3-key-used-to-store-state>"
    region = "us-east-1"

    dynamodb_table = "<insert-dynamodb-tf-state-table>"
    encrypt = true
  }
}

