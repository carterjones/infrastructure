module "mail_carterjones_info" {
  source      = "../modules/s3_bucket"
  bucket_name = "mail.carterjones.info"
  redirect    = "https://mail.google.com/a/carterjones.info"
}
