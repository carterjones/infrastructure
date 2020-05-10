module "resume_carterjones_info" {
  source              = "../modules/s3_bucket"
  bucket_name         = "resume.carterjones.info"
  versioning_enabled  = true
  block_public_access = false
  html_page           = "index.html"
}
