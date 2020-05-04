resource "aws_route53_record" "rei_a" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "rei.carterjones.info"
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.rei_carterjones_info.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.rei_carterjones_info.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_api_gateway_domain_name" "rei_carterjones_info" {
  provider        = aws.uswest2
  domain_name     = "rei.carterjones.info"
  certificate_arn = data.aws_acm_certificate.rei_carterjones_info.arn
}

data "aws_acm_certificate" "rei_carterjones_info" {
  domain   = "rei.carterjones.info"
  statuses = ["ISSUED"]
}
