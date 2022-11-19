locals {
  # NVIDIA Gaming PC - Windows Server 2019
  nvidia_amis = {
    "us-west-1" : "ami-002d9909d820c7db7",
  }
}
resource "aws_instance" "gaming" {
  ami = lookup(local.nvidia_amis, local.region, "fail")

  ebs_optimized        = "true"
  instance_type        = "g4dn.xlarge"
  key_name             = "ec2-${local.region}"
  subnet_id            = module.vpc.public_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.gaming.id

  # Use provisioned IOPS storage to increase hard drive performance.
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 100
    volume_type           = "gp3"
  }

  vpc_security_group_ids = [
    aws_security_group.gaming.id,
  ]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "gaming"
  }
}
