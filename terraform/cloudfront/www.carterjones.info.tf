module "www-carterjones-info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "www.carterjones.info"
}
