terraform {
  backend "s3" {
    key = "terraform.state"
  }
}

provider "aws" {
  # This region is defined specifically for the S3 backend. Other modules can use whatever region
  # they want.
  region = "us-west-2"
}
