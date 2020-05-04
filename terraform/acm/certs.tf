resource "aws_acm_certificate" "blog_carterjones_info" {
  domain_name       = "blog.carterjones.info"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate" "carterjones_info" {
  domain_name       = "carterjones.info"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate" "cdn_rei_carterjones_info" {
  domain_name       = "cdn.rei.carterjones.info"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate" "mail_carterjones_info" {
  domain_name       = "mail.carterjones.info"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate" "rei_carterjones_info" {
  domain_name       = "rei.carterjones.info"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate" "resume_carterjones_info" {
  domain_name       = "resume.carterjones.info"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate" "www_carterjones_info" {
  domain_name       = "www.carterjones.info"
  validation_method = "EMAIL"
}
