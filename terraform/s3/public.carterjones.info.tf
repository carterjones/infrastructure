module "public_carterjones_info" {
  source              = "../modules/s3_bucket"
  bucket_name         = "public.carterjones.info"
  block_public_access = false
  html_page           = "index.html"
}
