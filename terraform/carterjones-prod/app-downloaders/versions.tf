terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = "~> 3.0"
  }

  backend "s3" {
    bucket         = "carterjones-prod-tf-state-us-west-2"
    key            = "app-downloaders/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "us-west-2"
    encrypt        = "true"
  }
}
