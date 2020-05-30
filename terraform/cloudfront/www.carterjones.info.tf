module "www_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "www.carterjones.info"
}

output "www_carterjones_info_distribution_domain_name" {
  value = module.www_carterjones_info.distribution_domain_name
}

output "www_carterjones_info_distribution_hosted_zone_id" {
  value = module.www_carterjones_info.distribution_hosted_zone_id
}
