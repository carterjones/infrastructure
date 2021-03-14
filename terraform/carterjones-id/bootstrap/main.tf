locals {
  region = "us-west-2"
}

module "bootstrap" {
  source = "trussworks/bootstrap/aws"

  region        = local.region
  account_alias = "carterjones-id"
}
