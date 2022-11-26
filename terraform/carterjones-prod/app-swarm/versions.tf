terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket         = "carterjones-prod-tf-state-us-west-2"
    key            = "app-swarm/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "us-west-2"
    encrypt        = "true"
  }
}
