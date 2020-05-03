resource "aws_route53_record" "rei_a" {
  zone_id = aws_route53_zone.carterjones-info.zone_id
  name    = "rei.carterjones.info"
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.rei-carterjones-info.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.rei-carterjones-info.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_api_gateway_domain_name" "rei-carterjones-info" {
  provider        = aws.us-west-2
  domain_name     = "rei.carterjones.info"
  certificate_arn = data.aws_acm_certificate.rei-carterjones-info.arn
}

data "aws_acm_certificate" "rei-carterjones-info" {
  domain   = "rei.carterjones.info"
  statuses = ["ISSUED"]
}
