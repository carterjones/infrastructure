output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.gaming.id
}

output "public_ip" {
  description = "Public IP"
  value       = aws_instance.gaming.public_ip
}
