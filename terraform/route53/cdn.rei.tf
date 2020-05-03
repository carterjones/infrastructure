resource "aws_route53_record" "cdn_rei_a" {
  zone_id = aws_route53_zone.carterjones-info.zone_id
  name    = "cdn.rei.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.rei-carterjones-info-distribution-domain-name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.rei-carterjones-info-distribution-hosted-zone-id
    evaluate_target_health = false
  }
}
