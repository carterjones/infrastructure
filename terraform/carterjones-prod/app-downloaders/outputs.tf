output "public_ips" {
  description = "Public IPs"
  value       = module.ec2_cluster.public_ip
}
