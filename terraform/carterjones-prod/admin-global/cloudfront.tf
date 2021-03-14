module "blog_carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "blog.carterjones.info"
}

module "carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "carterjones.info"
}

module "keybase_carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "keybase.carterjones.info"
}

module "mail_carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "mail.carterjones.info"
}

module "public_carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "public.carterjones.info"
}

module "resume_carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "resume.carterjones.info"
}

module "www_carterjones_info" {
  source = "../../modules/cloudfront_s3_website"
  fqdn   = "www.carterjones.info"
}
