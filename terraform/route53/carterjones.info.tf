resource "aws_route53_record" "carterjones_info_a" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "carterjones_info_mx" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "carterjones.info"
  type    = "MX"
  ttl     = 3600

  records = [
    "1 ASPMX.L.GOOGLE.COM.",
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
    "10 ALT3.ASPMX.L.GOOGLE.COM.",
    "10 ALT4.ASPMX.L.GOOGLE.COM.",
  ]
}
