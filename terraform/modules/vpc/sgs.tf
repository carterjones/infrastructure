resource "aws_security_group" "allow_all_inbound_ssh" {
  name        = "allow_all_inbound_ssh-${var.tier}"
  description = "Allow all inbound SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_all_inbound_http_and_https" {
  name        = "allow_all_inbound_http_and_https-${var.tier}"
  description = "Allow all inbound HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "block_egress" {
  name        = "block_egress-${var.tier}"
  description = "Block all egress."
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["127.0.0.1/32"]
  }
}

resource "aws_security_group" "allow_egress" {
  name        = "allow_egress-${var.tier}"
  description = "Allow all egress."
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
