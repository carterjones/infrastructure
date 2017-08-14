terraform {
    backend "s3" {
        bucket = "carterjones-terraform-state-prod"
        key    = "terraform.state"
        region = "us-west-2"
    }
}

provider "aws" {
    region = "us-west-2"
}
