output "gaming_sg_id" {
  value = aws_security_group.allow_all_inbound_rdp.id
}

output "egress_sg_id" {
  value = aws_security_group.allow_egress.id
}
