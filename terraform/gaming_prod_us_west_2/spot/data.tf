data "aws_ami" "gaming" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["gaming-*"]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = ["main-b-prod"]
  }
}

data "aws_security_group" "egress" {
  filter {
    name   = "group-name"
    values = ["allow_egress-prod"]
  }
}

data "aws_security_group" "inbound_rdp" {
  filter {
    name   = "group-name"
    values = ["allow_all_inbound_rdp-prod"]
  }
}
