# Configure Terraform backend to store state in an S3 bucket
terraform {
  backend "s3" {
    bucket  = "tf-state-159729213779"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true

     # Configure DynamoDB table for state locking
    dynamodb_table = "terraform-state-lock"
  }
}
