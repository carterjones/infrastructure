# Private buckets.

module "carterjones_terraform_state_ci_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "carterjones-terraform-state-ci"
}

module "carterjones_terraform_state_dev_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "carterjones-terraform-state-dev"
}

module "carterjones_terraform_state_prod_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "carterjones-terraform-state-prod"
}

module "carterjones_info_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "carterjones.info"
  redirect    = "www.carterjones.info"
}

module "git_carterjones_info_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "git.carterjones.info"
}

module "keybase_carterjones_info_s3" {
  source            = "../../modules/s3_bucket"
  bucket_name       = "keybase.carterjones.info"
  redirect          = "carterjones.keybase.pub"
  versioning_status = "Suspended"
}

module "mail_carterjones_info_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "mail.carterjones.info"
}

module "res_carterjones_info_s3" {
  source      = "../../modules/s3_bucket"
  bucket_name = "res.carterjones.info"
}

# Public buckets.

module "blog_carterjones_info_s3" {
  source              = "../../modules/s3_bucket"
  bucket_name         = "blog.carterjones.info"
  block_public_access = false
  html_page           = "index.html"
}

module "public_carterjones_info_s3" {
  source              = "../../modules/s3_bucket"
  bucket_name         = "public.carterjones.info"
  block_public_access = false
  html_page           = "index.html"
  versioning_status   = "Suspended"
}

module "resume_carterjones_info_s3" {
  source              = "../../modules/s3_bucket"
  bucket_name         = "resume.carterjones.info"
  versioning_status   = "Enabled"
  block_public_access = false
  html_page           = "Carter Jones - Resume.pdf"
}

module "secure_linux_update_s3" {
  source              = "../../modules/s3_bucket"
  bucket_name         = "secure-linux-update"
  block_public_access = false
}

module "secure_windows_update_s3" {
  source              = "../../modules/s3_bucket"
  bucket_name         = "secure-windows-update"
  block_public_access = false
}

module "www_carterjones_info_s3" {
  source              = "../../modules/s3_bucket"
  bucket_name         = "www.carterjones.info"
  block_public_access = false
  html_page           = "index.html"
}
