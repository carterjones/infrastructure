provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    key    = "gaming-us-west-2-spot.state"
    bucket = "carterjones-terraform-state-prod"
    region = "us-west-2"
  }
}
