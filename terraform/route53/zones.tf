resource "aws_route53_zone" "carterjones_info" {
  name          = "carterjones.info"
  force_destroy = false
}

resource "aws_route53_zone" "carterjones_io" {
  name          = "carterjones.io"
  force_destroy = false
}
