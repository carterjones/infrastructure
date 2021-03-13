terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = "~> 3.0"
  }

  backend "s3" {
    bucket         = "carterjones-org-root-tf-state-us-west-2"
    key            = "bootstrap/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "us-west-2"
    encrypt        = "true"
  }
}
