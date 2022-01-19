resource "aws_acm_certificate" "blog_carterjones_info" {
  provider          = aws.useast1
  domain_name       = "blog.carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "carterjones_info" {
  provider          = aws.useast1
  domain_name       = "carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "mail_carterjones_info" {
  provider          = aws.useast1
  domain_name       = "mail.carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "keybase_carterjones_info" {
  provider          = aws.useast1
  domain_name       = "keybase.carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "public_carterjones_info" {
  provider          = aws.useast1
  domain_name       = "public.carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "resume_carterjones_info" {
  provider          = aws.useast1
  domain_name       = "resume.carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "www_carterjones_info" {
  provider          = aws.useast1
  domain_name       = "www.carterjones.info"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
