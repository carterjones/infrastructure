data "aws_ami" "gaming" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["gaming-*"]
  }
}

data "aws_subnet" "main" {
  filter {
    name   = "tag:Name"
    values = ["main-${var.tier}"]
  }
}

data "aws_security_group" "egress" {
  filter {
    name   = "group-name"
    values = ["allow_egress-${var.tier}"]
  }
}

data "aws_security_group" "inbound_rdp" {
  filter {
    name   = "group-name"
    values = ["allow_all_inbound_rdp-${var.tier}"]
  }
}

data "aws_eip" "gaming" {
  filter {
    name   = "tag:Name"
    values = ["gaming"]
  }
}
