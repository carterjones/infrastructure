module "www_carterjones_info" {
  source              = "../modules/s3_bucket"
  bucket_name         = "www.carterjones.info"
  block_public_access = false
  html_page           = "index.html"
}
