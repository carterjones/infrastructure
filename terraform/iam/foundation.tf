provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    key    = "iam.state"
    bucket = "carterjones-terraform-state-prod"
    region = "us-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21.0"
    }
  }
}

data "aws_caller_identity" "current" {}
