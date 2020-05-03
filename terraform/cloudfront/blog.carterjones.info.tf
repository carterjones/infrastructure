module "blog-carterjones-info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "blog.carterjones.info"
}
