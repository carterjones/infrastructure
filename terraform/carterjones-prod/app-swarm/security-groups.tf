data "http" "my_ip" {
  url = "https://icanhazip.com"
}

resource "aws_security_group" "swarm" {
  name        = "swarm"
  description = "allow swarm ingress and egress"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow full egress to the world."
  }

  tags = {
    Name = "swarm"
  }
}
