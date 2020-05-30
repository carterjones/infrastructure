module "resume_carterjones_info" {
  source = "../modules/cloudfront_s3_website"
  fqdn   = "resume.carterjones.info"
}

output "resume_carterjones_info_distribution_domain_name" {
  value = module.resume_carterjones_info.distribution_domain_name
}

output "resume_carterjones_info_distribution_hosted_zone_id" {
  value = module.resume_carterjones_info.distribution_hosted_zone_id
}
