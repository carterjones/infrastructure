module "carterjones_terraform_state_ci" {
  source      = "../modules/s3_bucket"
  bucket_name = "carterjones-terraform-state-ci"
}
