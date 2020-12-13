provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "uswest2"
}

terraform {
  backend "s3" {
    key    = "route53.state"
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

data "terraform_remote_state" "cloudfront" {
  backend = "s3"

  config = {
    key    = "cloudfront.state"
    bucket = "carterjones-terraform-state-prod"
    region = "us-west-2"
  }
}
