module "keybase_carterjones_info" {
  source      = "../modules/s3_bucket"
  bucket_name = "keybase.carterjones.info"
  redirect    = "https://carterjones.keybase.pub"
}
