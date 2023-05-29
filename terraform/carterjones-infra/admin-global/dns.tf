#########
# Zones #
#########

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

resource "aws_route53_zone" "carterjones_me" {
  name = "carterjones.me"
}

output "carterjones_me_nameservers" {
  value = aws_route53_zone.carterjones_me.name_servers
}

####################
# carterjones.info #
####################

resource "aws_route53_record" "prod_carterjones_info" {
  allow_overwrite = true
  name            = "prod.carterjones.info"
  ttl             = 172800
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
  ttl     = 172800

  records = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch.",
  ]
}

resource "aws_route53_record" "carterjones_info_txt_protonmail" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "carterjones.info"
  type    = "TXT"
  ttl     = 172800
  records = [
    "protonmail-verification=899925db5737132194d21148d8cf7d7445bd5275",
    "v=spf1 include:_spf.protonmail.ch mx ~all",
  ]
}

resource "aws_route53_record" "carterjones_info_dmarc" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_dmarc.carterjones.info"
  type    = "TXT"
  ttl     = 172800
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
  ttl = 172800
}

resource "aws_route53_record" "carterjones_info_dkim2" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "protonmail2._domainkey.carterjones.info"
  type    = "CNAME"
  records = [
    "protonmail2.domainkey.ddd22q4jtadwip3fbvp43dv5iokimcahazdp4vk6e3srebrf4qpfq.domains.proton.ch.",
  ]
  ttl = 172800
}

resource "aws_route53_record" "carterjones_info_dkim3" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "protonmail3._domainkey.carterjones.info"
  type    = "CNAME"
  records = [
    "protonmail3.domainkey.ddd22q4jtadwip3fbvp43dv5iokimcahazdp4vk6e3srebrf4qpfq.domains.proton.ch.",
  ]
  ttl = 172800
}

resource "aws_route53_record" "blog_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "blog.carterjones.info"
  type    = "CNAME"
  records = ["blog.prod.carterjones.info"]
  ttl     = 172800
}

resource "aws_route53_record" "dm_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "dm.carterjones.info"
  type    = "CNAME"
  records = ["profile.direct.me"]
  ttl     = 172800
}

resource "aws_route53_record" "public_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "public.carterjones.info"
  type    = "CNAME"
  records = ["public.prod.carterjones.info"]
  ttl     = 172800
}

resource "aws_route53_record" "resume_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "resume.carterjones.info"
  type    = "CNAME"
  records = ["resume.prod.carterjones.info"]
  ttl     = 172800
}

resource "aws_route53_record" "www_carterjones_info" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "www.carterjones.info"
  type    = "CNAME"
  records = ["www.prod.carterjones.info"]
  ttl     = 172800
}

# ACM validation records.

resource "aws_route53_record" "blog_carterjones_info_acm" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_6b33d83f44143cbfd7029e9d54394f5a.blog.carterjones.info."
  type    = "CNAME"
  records = ["_b41fba7f7a20923f6283651752d26702.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 172800
}

resource "aws_route53_record" "carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_668c8cb47c168219a61e0701b90ff8fa.carterjones.info."
  type    = "CNAME"
  records = ["_543a0c3c0ee64dd49e42ae9d7f3adad6.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 172800
}

resource "aws_route53_record" "public_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_199dd41d4fbcec45974ab9d7bb2fb74a.public.carterjones.info."
  type    = "CNAME"
  records = ["_82a8c22d4a1b6acfbb562788d5ae71c9.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 172800
}

resource "aws_route53_record" "resume_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_5b736b9fa9f53b84c4edef29e9558ab8.resume.carterjones.info."
  type    = "CNAME"
  records = ["_6b9767250ee7d1e01c07722bc69f7d49.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 172800
}

resource "aws_route53_record" "www_carterjones_info_dns_validation" {
  zone_id = aws_route53_zone.carterjones_info.zone_id
  name    = "_3a9cee763740ef90c527fdff762f486b.www.carterjones.info."
  type    = "CNAME"
  records = ["_e0f2f56b3e4ee858e4aa4abd3e93764a.lkwmzfhcjn.acm-validations.aws."]
  ttl     = 172800
}

#######################
# carterjones.io #
#######################

resource "aws_route53_record" "carterjones_io_txt" {
  zone_id = aws_route53_zone.carterjones_io.zone_id
  name    = "carterjones.io"
  type    = "TXT"
  ttl     = 172800
  records = [
    "sl-verification=fxtnezpppxjqnuslstckmszeqlafgl",
    "v=spf1 include:simplelogin.co ~all",
  ]
}

resource "aws_route53_record" "carterjones_io_mx" {
  zone_id = aws_route53_zone.carterjones_io.zone_id
  name    = "carterjones.io"
  type    = "MX"
  ttl     = 172800

  records = [
    "10 mx1.simplelogin.co.",
    "20 mx2.simplelogin.co.",
  ]
}

resource "aws_route53_record" "carterjones_io_dkim1" {
  zone_id = aws_route53_zone.carterjones_io.zone_id
  name    = "dkim._domainkey.carterjones.io"
  type    = "CNAME"
  records = [
    "dkim._domainkey.simplelogin.co.",
  ]
  ttl = 172800
}

resource "aws_route53_record" "carterjones_io_dkim2" {
  zone_id = aws_route53_zone.carterjones_io.zone_id
  name    = "dkim02._domainkey.carterjones.io"
  type    = "CNAME"
  records = [
    "dkim02._domainkey.simplelogin.co.",
  ]
  ttl = 172800
}

resource "aws_route53_record" "carterjones_io_dkim3" {
  zone_id = aws_route53_zone.carterjones_io.zone_id
  name    = "dkim03._domainkey.carterjones.io"
  type    = "CNAME"
  records = [
    "dkim03._domainkey.simplelogin.co.",
  ]
  ttl = 172800
}

resource "aws_route53_record" "carterjones_io_dmarc" {
  zone_id = aws_route53_zone.carterjones_io.zone_id
  name    = "_dmarc.carterjones.io"
  type    = "TXT"
  ttl     = 172800
  records = [
    "v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s",
  ]
}

##################
# carterjones.me #
##################

resource "aws_route53_record" "carterjones_me_txt_protonmail" {
  zone_id = aws_route53_zone.carterjones_me.zone_id
  name    = "carterjones.me"
  type    = "TXT"
  ttl     = 172800
  records = [
    "protonmail-verification=8607a7acf74aa5dc9b5fa41c38b70665fb690312",
  ]
}

resource "aws_route53_record" "carterjones_me_mx" {
  zone_id = aws_route53_zone.carterjones_me.zone_id
  name    = "carterjones.me"
  type    = "MX"
  ttl     = 172800

  records = [
    "10 mail.protonmail.ch.",
    "20 mailsec.protonmail.ch.",
  ]
}
