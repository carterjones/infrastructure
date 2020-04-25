provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    key    = "vpc-us-west-2.state"
    bucket = "carterjones-terraform-state-prod"
    region = "us-west-2"
  }
}
