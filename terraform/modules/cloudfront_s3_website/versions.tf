terraform {
  required_version = ">= 0.16"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6"
    }
  }
}
