#terraform {
#  required_version = ">= 0.12, < 0.13"
#}

provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    #This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    #manually, uncomment and fill in the config below.

    bucket         = "my-tfstate-store11223344"
    key            = "global/stage/data-store/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-backend-state-locks11223344"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "stage-db"
  engine              = "postgres"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = "mydbuser"
  password            = var.db_password
  skip_final_snapshot = true
}
