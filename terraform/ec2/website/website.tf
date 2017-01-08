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

data "aws_ami" "website" {
  filter {
    name = "state"
    values = ["available"]
  }
  filter {
    name = "tag:role"
    values = ["go-website"]
  }
  most_recent = true
}

resource "aws_instance" "website" {
  ami           = "${data.aws_ami.website.id}"
  instance_type = "t2.nano"
  key_name      = "primary"
  subnet_id     = "${data.terraform_remote_state.vpcs.subnet_main}"
  vpc_security_group_ids = [
    "${data.terraform_remote_state.sg_world.allow_all_inbound_ssh}",
    "${data.terraform_remote_state.sg_world.allow_all_inbound_http_and_https}",
    "${data.terraform_remote_state.sg_world.block_egress}"
  ]
  tags = {
    role = "go-website"
  }
}

resource "aws_eip" "website" {
  vpc = true
}

resource "aws_eip_association" "website" {
  instance_id = "${aws_instance.website.id}"
  allocation_id = "${aws_eip.website.id}"
}
