module "blog_carterjones_info" {
  source              = "../modules/s3_bucket"
  bucket_name         = "blog.carterjones.info"
  block_public_access = false
  html_page           = "index.html"
}
