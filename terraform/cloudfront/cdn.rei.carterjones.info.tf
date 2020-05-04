resource "aws_cloudfront_distribution" "cdn_rei_carterjones_info" {
  aliases         = ["cdn.rei.carterjones.info"]
  enabled         = true
  is_ipv6_enabled = true

  origin {
    domain_name = "rei.carterjones.info.s3.amazonaws.com"
    origin_id   = local.origin_id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = local.origin_id
    trusted_signers        = []
    viewer_protocol_policy = "https-only"

    forwarded_values {
      headers      = []
      query_string = false

      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.certificate.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.1_2016"
    ssl_support_method             = "sni-only"
  }
}

data "aws_acm_certificate" "certificate" {
  domain   = "cdn.rei.carterjones.info"
  statuses = ["ISSUED"]
}

locals {
  origin_id = "s3-bucket-rei.carterjones.info"
}
