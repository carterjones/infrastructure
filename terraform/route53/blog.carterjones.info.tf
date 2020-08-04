resource "aws_route53_record" "blog_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "blog.carterjones.info"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.blog_carterjones_info_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.blog_carterjones_info_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}
