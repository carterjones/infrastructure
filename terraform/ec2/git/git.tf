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
    values = ["git"]
  }
  most_recent = true
}

resource "aws_instance" "git" {
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
    role = "git"
  }
}

resource "aws_ebs_volume" "git_state" {
  availability_zone = "us-west-2b"
  size = 1
}

resource "aws_volume_attachment" "git_state" {
  device_name = "/dev/xvdb"
  volume_id = "${aws_ebs_volume.git_state.id}"
  instance_id = "${aws_instance.git.id}"
}

resource "aws_eip" "git" {
  vpc = true
}

resource "aws_eip_association" "git" {
  instance_id = "${aws_instance.git.id}"
  allocation_id = "${aws_eip.git.id}"
}

output "ip" {
  value = "${aws_eip.git.public_ip}"
}
