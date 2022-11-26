locals {
  region = "us-west-2"
}

# tfsec:ignore:aws-dynamodb-table-customer-key
# tfsec:ignore:aws-s3-encryption-customer-key
module "bootstrap" {
  source  = "trussworks/bootstrap/aws"
  version = "~> 3.0.0"

  region        = local.region
  account_alias = "carterjones-infra"

  log_bucket_versioning = "Suspended"
}
