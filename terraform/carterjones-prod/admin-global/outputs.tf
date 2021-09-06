output "blog_carterjones_info_dns_validation" {
  value = aws_acm_certificate.blog_carterjones_info.domain_validation_options
}

output "carterjones_info_dns_validation" {
  value = aws_acm_certificate.carterjones_info.domain_validation_options
}

output "mail_carterjones_info_dns_validation" {
  value = aws_acm_certificate.mail_carterjones_info.domain_validation_options
}

output "keybase_carterjones_info_dns_validation" {
  value = aws_acm_certificate.keybase_carterjones_info.domain_validation_options
}

output "public_carterjones_info_dns_validation" {
  value = aws_acm_certificate.public_carterjones_info.domain_validation_options
}

output "resume_carterjones_info_dns_validation" {
  value = aws_acm_certificate.resume_carterjones_info.domain_validation_options
}

output "www_carterjones_info_dns_validation" {
  value = aws_acm_certificate.www_carterjones_info.domain_validation_options
}
