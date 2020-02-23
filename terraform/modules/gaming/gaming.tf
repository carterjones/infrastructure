data "aws_ami" "gaming" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["gaming-*"]
  }
}

resource "aws_launch_template" "gaming" {
  name = "gaming"

  ebs_optimized                        = "false"
  image_id                             = data.aws_ami.gaming.id
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "g4dn.xlarge"
  key_name                             = "primary"
  vpc_security_group_ids = [
    var.gaming_sg_id,
    var.egress_sg_id,
  ]
}
