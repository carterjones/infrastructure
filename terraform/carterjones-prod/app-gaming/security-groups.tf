data "http" "my_ip" {
  url = "https://icanhazip.com"
}

resource "aws_security_group" "gaming" {
  name        = "gaming"
  description = "allow gaming ingress and egress"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "RDP from my IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }

  tags = {
    Name = "gaming"
  }
}
