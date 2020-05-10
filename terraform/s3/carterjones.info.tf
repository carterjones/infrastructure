module "carterjones_info" {
  source      = "../modules/s3_bucket"
  bucket_name = "carterjones.info"
  redirect    = "https://www.carterjones.info"
}
