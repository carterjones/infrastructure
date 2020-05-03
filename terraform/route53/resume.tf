resource "aws_route53_record" "resume_a" {
  zone_id = aws_route53_zone.carterjones-info.zone_id
  name    = "resume.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.resume-carterjones-info-distribution-domain-name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.resume-carterjones-info-distribution-hosted-zone-id
    evaluate_target_health = false
  }
}
