locals {
  region = "us-west-2"
}

module "bootstrap" {
  source  = "trussworks/bootstrap/aws"
  version = "~> 2.0.0"

  region        = local.region
  account_alias = "carterjones-id"
}
