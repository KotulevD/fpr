provider "aws" {
  region = "eu-central-1"

  # Allow any 2.x version of the AWS provider
  #version = "~> 2.0"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-tfstate-store11223344"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-backend-state-locks11223344"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
