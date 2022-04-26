# Terraform configuration
terraform {
  # TF required minimum version (Tested=1.1.9)
  required_version = "~>1.1"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.11.0"
    }
  }
}