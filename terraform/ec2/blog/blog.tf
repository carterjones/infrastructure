provider "aws" {
  region = "us-west-2"
}

data "terraform_remote_state" "vpcs" {
    backend = "s3"
    config {
        bucket = "carterjones-terraform-state-prod"
        key = "vpc/terraform.tfstate"
        region = "us-west-2"
    }
}

data "terraform_remote_state" "sg_world" {
    backend = "s3"
    config {
        bucket = "carterjones-terraform-state-prod"
        key = "sg/world/terraform.tfstate"
        region = "us-west-2"
    }
}

data "aws_ami" "base" {
  filter {
    name = "state"
    values = ["available"]
  }
  filter {
    name = "tag:role"
    values = ["blog"]
  }
  most_recent = true
}

resource "aws_instance" "blog" {
  ami           = "${data.aws_ami.base.id}"
  availability_zone = "us-west-2b"
  instance_type = "t2.nano"
  key_name      = "primary"
  subnet_id     = "${data.terraform_remote_state.vpcs.subnet_main}"
  vpc_security_group_ids = [
    "${data.terraform_remote_state.sg_world.allow_all_inbound_ssh}",
    "${data.terraform_remote_state.sg_world.allow_all_inbound_http_and_https}"
#    "${data.terraform_remote_state.sg_world.block_egress}"
  ]
  tags = {
    role = "blog"
  }
}

resource "aws_ebs_volume" "blog_state" {
  availability_zone = "us-west-2b"
  size = 1
}

resource "aws_volume_attachment" "blog_state" {
  device_name = "/dev/xvdb"
  volume_id = "${aws_ebs_volume.blog_state.id}"
  instance_id = "${aws_instance.blog.id}"
}

resource "aws_eip" "blog" {
  vpc = true
}

resource "aws_eip_association" "blog" {
  instance_id = "${aws_instance.blog.id}"
  allocation_id = "${aws_eip.blog.id}"
}

output "ip" {
  value = "${aws_eip.blog.public_ip}"
}
