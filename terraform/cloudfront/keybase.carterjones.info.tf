module "keybase_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "keybase.carterjones.info"
}

output "keybase_carterjones_info_distribution_domain_name" {
  value = module.keybase_carterjones_info.distribution_domain_name
}

output "keybase_carterjones_info_distribution_hosted_zone_id" {
  value = module.keybase_carterjones_info.distribution_hosted_zone_id
}
