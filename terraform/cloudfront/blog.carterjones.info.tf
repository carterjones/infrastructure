module "blog_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "blog.carterjones.info"
}

output "blog_carterjones_info_distribution_domain_name" {
  value = module.blog_carterjones_info.distribution_domain_name
}

output "blog_carterjones_info_distribution_hosted_zone_id" {
  value = module.blog_carterjones_info.distribution_hosted_zone_id
}
