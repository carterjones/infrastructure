locals {
  region = "us-west-2"
}

module "bootstrap" {
  source  = "trussworks/bootstrap/aws"
  version = "~> 3.0.0"

  region        = local.region
  account_alias = "carterjones-id"

  log_bucket_versioning = "Suspended"
}
