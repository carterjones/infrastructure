module "carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "carterjones.info"
}

output "carterjones_info_distribution_domain_name" {
  value = module.carterjones_info.distribution_domain_name
}

output "carterjones_info_distribution_hosted_zone_id" {
  value = module.carterjones_info.distribution_hosted_zone_id
}
