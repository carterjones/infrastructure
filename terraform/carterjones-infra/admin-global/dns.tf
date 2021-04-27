resource "aws_route53_zone" "carterjones_info" {
  name = "carterjones.info"
}

output "carterjones_info_nameservers" {
  value = aws_route53_zone.carterjones_info.name_servers
}

resource "aws_route53_zone" "carterjones_io" {
  name = "carterjones.io"
}

output "carterjones_io_nameservers" {
  value = aws_route53_zone.carterjones_io.name_servers
}

resource "aws_route53_record" "prod_carterjones_info" {
  allow_overwrite = true
  name            = "prod.carterjones.info"
  ttl             = 3600
  type            = "NS"
  zone_id         = aws_route53_zone.carterjones_info.zone_id

  records = [
    "ns-1049.awsdns-03.org.",
    "ns-1946.awsdns-51.co.uk.",
    "ns-246.awsdns-30.com.",
    "ns-696.awsdns-23.net.",
  ]
}

resource "aws_route53_record" "carterjones_info_a" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "carterjones.info"
  type    = "A"

  alias {
    name                   = "d4j9fvli203fw.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "carterjones_info_mx" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "carterjones.info"
  type    = "MX"
  ttl     = 3600

  records = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch.",
  ]
}

resource "aws_route53_record" "carterjones_info_txt_protonmail" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "carterjones.info"
  type    = "TXT"
  ttl     = 3600
  records = [
    "protonmail-verification=899925db5737132194d21148d8cf7d7445bd5275",
    "v=spf1 include:_spf.protonmail.ch mx ~all",
  ]
}

resource "aws_route53_record" "carterjones_info_dmarc" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_dmarc.carterjones.info"
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=DMARC1; p=none",
  ]
}

resource "aws_route53_record" "carterjones_info_dkim1" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "protonmail._domainkey.carterjones.info"
  type    = "CNAME"
  records = [
    "protonmail.domainkey.ddd22q4jtadwip3fbvp43dv5iokimcahazdp4vk6e3srebrf4qpfq.domains.proton.ch.",
  ]
  ttl = 3600
}

resource "aws_route53_record" "carterjones_info_dkim2" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "protonmail2._domainkey.carterjones.info"
  type    = "CNAME"
  records = [
    "protonmail2.domainkey.ddd22q4jtadwip3fbvp43dv5iokimcahazdp4vk6e3srebrf4qpfq.domains.proton.ch.",
  ]
  ttl = 3600
}

resource "aws_route53_record" "carterjones_info_dkim3" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "protonmail3._domainkey.carterjones.info"
  type    = "CNAME"
  records = [
    "protonmail3.domainkey.ddd22q4jtadwip3fbvp43dv5iokimcahazdp4vk6e3srebrf4qpfq.domains.proton.ch.",
  ]
  ttl = 3600
}

resource "aws_route53_record" "blog_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "blog.carterjones.info"
  type    = "CNAME"
  records = ["blog.prod.carterjones.info"]
  ttl     = 3600
}

resource "aws_route53_record" "keybase_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "keybase.carterjones.info"
  type    = "CNAME"
  records = ["keybase.prod.carterjones.info"]
  ttl     = 3600
}

resource "aws_route53_record" "mail_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "mail.carterjones.info"
  type    = "CNAME"
  records = ["mail.prod.carterjones.info"]
  ttl     = 3600
}

resource "aws_route53_record" "public_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "public.carterjones.info"
  type    = "CNAME"
  records = ["public.prod.carterjones.info"]
  ttl     = 3600
}

resource "aws_route53_record" "resume_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "resume.carterjones.info"
  type    = "CNAME"
  records = ["resume.prod.carterjones.info"]
  ttl     = 3600
}

resource "aws_route53_record" "www_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "www.carterjones.info"
  type    = "CNAME"
  records = ["www.prod.carterjones.info"]
  ttl     = 3600
}
