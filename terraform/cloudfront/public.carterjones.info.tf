module "public_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "public.carterjones.info"
}

output "public_carterjones_info_distribution_domain_name" {
  value = module.public_carterjones_info.distribution_domain_name
}

output "public_carterjones_info_distribution_hosted_zone_id" {
  value = module.public_carterjones_info.distribution_hosted_zone_id
}
