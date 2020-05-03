resource "aws_route53_record" "mail_a" {
  zone_id = aws_route53_zone.carterjones-info.zone_id
  name    = "mail.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.mail-carterjones-info-distribution-domain-name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.mail-carterjones-info-distribution-hosted-zone-id
    evaluate_target_health = false
  }
}
