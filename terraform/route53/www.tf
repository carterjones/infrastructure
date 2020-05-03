resource "aws_route53_record" "www_a" {
  zone_id = aws_route53_zone.carterjones-info.zone_id
  name    = "www.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.www-carterjones-info-distribution-domain-name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.www-carterjones-info-distribution-hosted-zone-id
    evaluate_target_health = false
  }
}
