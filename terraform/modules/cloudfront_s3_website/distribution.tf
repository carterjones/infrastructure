# tfsec:ignore:aws-cloudfront-enable-logging
# tfsec:ignore:aws-cloudfront-enable-waf
resource "aws_cloudfront_distribution" "distribution" {
  provider        = aws.useast1
  aliases         = [var.fqdn]
  enabled         = true
  is_ipv6_enabled = true

  origin {
    domain_name = data.aws_s3_bucket.bucket.website_endpoint
    origin_id   = local.origin_id

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = local.origin_id
    trusted_signers        = []
    viewer_protocol_policy = "redirect-to-https"

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
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

data "aws_acm_certificate" "certificate" {
  provider    = aws.useast1
  domain      = var.fqdn
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_s3_bucket" "bucket" {
  provider = aws.uswest2
  bucket   = var.fqdn
}

locals {
  origin_id = "s3-static-website-${var.fqdn}"
}
