provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    key    = "s3.state"
    bucket = "carterjones-terraform-state-prod"
    region = "us-west-2"
  }
}

data "aws_caller_identity" "current" {}
