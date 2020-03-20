output "subnet_id" {
  value = aws_subnet.main.id
}

output "gaming_sg_id" {
  value = aws_security_group.allow_all_inbound_rdp.id
}

output "egress_sg_id" {
  value = aws_security_group.allow_egress.id
}

output "gaming_eip_allocation_id" {
  value = aws_eip.gaming.id
}
