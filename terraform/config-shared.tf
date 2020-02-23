terraform {
    backend "s3" {
        key = "terraform.state"
    }
}

variable "aws_region" {
    type    = string
    default = "us-west-2"
}

variable "tier" {
    type    = string
    default = "prod"
}

provider "aws" {
    region = var.aws_region
}

variable "key_name" {
    type    = string
    default = "primary"
}
