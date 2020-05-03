output "blog-carterjones-info-distribution-domain-name" {
  value = module.blog-carterjones-info.distribution_domain_name
}

output "blog-carterjones-info-distribution-hosted-zone-id" {
  value = module.blog-carterjones-info.distribution_hosted_zone_id
}

output "carterjones-info-distribution-domain-name" {
  value = module.carterjones-info.distribution_domain_name
}

output "carterjones-info-distribution-hosted-zone-id" {
  value = module.carterjones-info.distribution_hosted_zone_id
}

output "rei-carterjones-info-distribution-domain-name" {
  value = aws_cloudfront_distribution.cdn-rei-carterjones-info.domain_name
}

output "rei-carterjones-info-distribution-hosted-zone-id" {
  value = aws_cloudfront_distribution.cdn-rei-carterjones-info.hosted_zone_id
}

output "mail-carterjones-info-distribution-domain-name" {
  value = module.mail-carterjones-info.distribution_domain_name
}

output "mail-carterjones-info-distribution-hosted-zone-id" {
  value = module.mail-carterjones-info.distribution_hosted_zone_id
}

output "resume-carterjones-info-distribution-domain-name" {
  value = module.resume-carterjones-info.distribution_domain_name
}

output "resume-carterjones-info-distribution-hosted-zone-id" {
  value = module.resume-carterjones-info.distribution_hosted_zone_id
}

output "www-carterjones-info-distribution-domain-name" {
  value = module.www-carterjones-info.distribution_domain_name
}

output "www-carterjones-info-distribution-hosted-zone-id" {
  value = module.www-carterjones-info.distribution_hosted_zone_id
}
