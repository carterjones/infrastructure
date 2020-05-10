module "carterjones_terraform_state_prod" {
  source      = "../modules/s3_bucket"
  bucket_name = "carterjones-terraform-state-prod"
}
