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
    "v=DMARC1; p=reject; pct=100; rua=mailto:ypzqn2df@ag.dmarcian.com;",
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

# ACM validation records.

resource "aws_route53_record" "blog_carterjones_info_acm" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_6b33d83f44143cbfd7029e9d54394f5a.blog.carterjones.info."
  type    = "CNAME"
  records = ["_b41fba7f7a20923f6283651752d26702.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}

resource "aws_route53_record" "carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_668c8cb47c168219a61e0701b90ff8fa.carterjones.info."
  type    = "CNAME"
  records = ["_543a0c3c0ee64dd49e42ae9d7f3adad6.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}

resource "aws_route53_record" "keybase_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_9bdd3608960cb2c68500805e749fe2f4.keybase.carterjones.info."
  type    = "CNAME"
  records = ["_0deb8ff079549c3125101c0f3abe046c.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}

resource "aws_route53_record" "mail_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_adbb8550810052758a1311fd62ba882c.mail.carterjones.info."
  type    = "CNAME"
  records = ["_427c13d3066f3a835c8610111e2c1e7a.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}

resource "aws_route53_record" "public_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_199dd41d4fbcec45974ab9d7bb2fb74a.public.carterjones.info."
  type    = "CNAME"
  records = ["_82a8c22d4a1b6acfbb562788d5ae71c9.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}

resource "aws_route53_record" "resume_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_5b736b9fa9f53b84c4edef29e9558ab8.resume.carterjones.info."
  type    = "CNAME"
  records = ["_6b9767250ee7d1e01c07722bc69f7d49.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}

resource "aws_route53_record" "www_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_3a9cee763740ef90c527fdff762f486b.www.carterjones.info."
  type    = "CNAME"
  records = ["_e0f2f56b3e4ee858e4aa4abd3e93764a.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 60
}
