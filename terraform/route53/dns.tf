resource "aws_route53_zone" "prod_carterjones_info" {
  name = "prod.carterjones.info"
}

output "prod_carterjones_info_nameservers" {
  value = aws_route53_zone.prod_carterjones_info.name_servers
}

resource "aws_route53_record" "blog_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "blog.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.blog_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.blog_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "keybase_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "keybase.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.keybase_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.keybase_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mail_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "mail.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.mail_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.mail_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "public.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.public_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.public_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "resume_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "resume.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.resume_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.resume_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "www.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.www_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.www_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}
