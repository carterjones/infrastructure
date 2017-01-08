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

data "aws_ami" "dev" {
  filter {
    name = "state"
    values = ["available"]
  }
  filter {
    name = "tag:role"
    values = ["dev"]
  }
  most_recent = true
}

resource "aws_instance" "dev" {
  availability_zone = "us-west-2b"
  ami               = "${data.aws_ami.dev.id}"
  depends_on        = ["aws_ebs_volume.dev_state"]
  instance_type     = "t2.nano"
  key_name          = "primary"
  subnet_id         = "${data.terraform_remote_state.vpcs.subnet_main}"
  vpc_security_group_ids = [
    "${data.terraform_remote_state.sg_world.allow_all_inbound_ssh}"
  ]
  tags = {
    role = "dev"
  }
}

resource "aws_ebs_volume" "dev_state" {
    availability_zone = "us-west-2b"
    size = 10
    tags {
        Name = "dev-state"
    }
}

resource "aws_volume_attachment" "state_attachment" {
  device_name  = "/dev/xvdb"
  instance_id  = "${aws_instance.dev.id}"
  volume_id    = "${aws_ebs_volume.dev_state.id}"
  skip_destroy = true
}

resource "aws_eip" "dev" {
  vpc = true
}

resource "aws_eip_association" "dev" {
  instance_id = "${aws_instance.dev.id}"
  allocation_id = "${aws_eip.dev.id}"
}
