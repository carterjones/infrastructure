locals {
  canonical_account_number = "099720109477"
}

data "aws_ami" "ubuntu_20_04" {
  most_recent = true
  owners      = [local.canonical_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "downloaders"
  instance_count = 1

  ami                    = data.aws_ami.ubuntu_20_04.id
  instance_type          = "m5.large"
  key_name               = "yubikey-5c"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.downloaders.id]
  subnet_id              = module.vpc.public_subnets[0]
  iam_instance_profile   = aws_iam_instance_profile.upload_to_public_carterjones_info.name

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

resource "aws_iam_instance_profile" "upload_to_public_carterjones_info" {
  name = "upload_to_public_carterjones_info"
  role = "upload_to_public_carterjones_info"
}
