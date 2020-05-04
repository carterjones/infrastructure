module "blog_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "blog.carterjones.info"
}
