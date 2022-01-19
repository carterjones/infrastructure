data "http" "my_ip" {
  url = "https://icanhazip.com"
}

# tfsec:ignore:aws-vpc-no-public-egress-sg
resource "aws_security_group" "downloaders" {
  name        = "downloaders"
  description = "allow downloaders ingress and egress"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow full egress to the world."
  }

  tags = {
    Name = "downloaders"
  }
}
