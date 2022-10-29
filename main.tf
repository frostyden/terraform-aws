provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-up-and-running-state-for-denizkin"
  acl = "private"
  # force_destroy = true


  lifecycle {
    prevent_destroy = true
  }

  # server_side_encryption_configuration {
  #   rule {
  #     bucket_key_enabled = true
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "aws:kms"
  #     }
  #   }
  # }
}

# resource "aws_s3_bucket_public_access_block" "this" {
#     block_public_acls       = true
#     block_public_policy     = true
#     bucket                  = aws_s3_bucket.terraform_state_bucket.bucket
#     ignore_public_acls      = true
#     restrict_public_buckets = true
# }

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.terraform_state_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# This code is not used for S3 bucket creation, research why it is bring used at all
# resource "aws_s3_object" "s3_object_publish" {
#   bucket = aws_s3_bucket.terraform_state_bucket.bucket
#   key = "terraform.tfstate"
#   source = "/Users/frosty/Documents/DevOps/DevOps2/terraform.tfstate"

# }

# Commenting this since this configuration is initialized in backend.hcl file
# terraform {
#   backend "s3" {
#     bucket = "terraform-up-and-running-state-for-denizkin"
#     key = "terraform.tfstate"
#     region = "eu-central-1"
#    
#    # dynamodb_table = "terraform-up-and-running-lock-for-denizkin"
#   }
# }

# resource "aws_dynamodb_table" "IlhamGayDynamoDB" {
#   name = "terraform-up-and-running-lock-for-denizkin"
#   hash_key = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   read_capacity  = 20
#   write_capacity = 20

# }

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state_bucket.arn
  
}