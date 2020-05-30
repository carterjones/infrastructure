module "mail_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "mail.carterjones.info"
}

output "mail_carterjones_info_distribution_domain_name" {
  value = module.mail_carterjones_info.distribution_domain_name
}

output "mail_carterjones_info_distribution_hosted_zone_id" {
  value = module.mail_carterjones_info.distribution_hosted_zone_id
}
