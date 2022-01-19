# tfsec:ignore:aws-vpc-no-public-ingress-sg
resource "aws_security_group" "allow_all_inbound_ssh" {
  name        = "allow_all_inbound_ssh-${var.tier}"
  description = "Allow all inbound SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ingress from the world on tcp/22."
  }
}

# tfsec:ignore:aws-vpc-no-public-ingress-sg
resource "aws_security_group" "allow_all_inbound_http_and_https" {
  name        = "allow_all_inbound_http_and_https-${var.tier}"
  description = "Allow all inbound HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ingress from the world on tcp/80."
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ingress from the world on tcp/443."
  }
}

# tfsec:ignore:aws-vpc-no-public-ingress-sg
resource "aws_security_group" "allow_all_inbound_rdp" {
  name        = "allow_all_inbound_rdp-${var.tier}"
  description = "Allow RDP traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow RDP traffic from the world."
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
    description = "Block all egress by default."
  }
}

# tfsec:ignore:aws-vpc-no-public-egress-sg
resource "aws_security_group" "allow_egress" {
  name        = "allow_egress-${var.tier}"
  description = "Allow all egress."
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow full egress to the world."
  }
}
