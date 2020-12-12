resource "aws_instance" "gaming" {
  ami           = data.aws_ami.gaming.id
  ebs_optimized = "true"
  instance_type = "g4dn.xlarge"
  key_name      = "primary"
  subnet_id     = data.aws_subnet.subnet.id

  # Use provisioned IOPS storage to increase hard drive performance.
  root_block_device {
    volume_type = "io1"
    iops        = "7500"
  }

  # This allows me to take a snapshot of the instance and delete the
  # provisioned volume.
  #
  # Note: if you shut a *spot* instance down from the operating system, it will
  # terminate the instance. The only way to prevent this is to stop spot
  # instances from outside the OS, such as the AWS console or CLI.
  instance_initiated_shutdown_behavior = "stop"

  vpc_security_group_ids = [
    data.aws_security_group.egress.id,
    data.aws_security_group.inbound_rdp.id,
  ]

  tags = {
    Name = "gaming"
  }
}

output "ip" {
  value = aws_instance.gaming.public_ip
}
