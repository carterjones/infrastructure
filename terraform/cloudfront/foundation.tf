provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    key    = "cloudfront.state"
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
