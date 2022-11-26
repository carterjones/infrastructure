# Prod Zone.

resource "aws_route53_zone" "prod_carterjones_info" {
  name = "prod.carterjones.info"
}

output "prod_carterjones_info_nameservers" {
  value = aws_route53_zone.prod_carterjones_info.name_servers
}

# Records.

resource "aws_route53_record" "blog_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "blog.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = module.blog_carterjones_info.distribution_domain_name
    zone_id                = module.blog_carterjones_info.distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "keybase_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "keybase.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = module.keybase_carterjones_info.distribution_domain_name
    zone_id                = module.keybase_carterjones_info.distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "public.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = module.public_carterjones_info.distribution_domain_name
    zone_id                = module.public_carterjones_info.distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "resume_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "resume.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = module.resume_carterjones_info.distribution_domain_name
    zone_id                = module.resume_carterjones_info.distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_prod_carterjones_info" {
  zone_id = aws_route53_zone.prod_carterjones_info.zone_id
  name    = "www.prod.carterjones.info"
  type    = "A"

  alias {
    name                   = module.www_carterjones_info.distribution_domain_name
    zone_id                = module.www_carterjones_info.distribution_hosted_zone_id
    evaluate_target_health = false
  }
}
