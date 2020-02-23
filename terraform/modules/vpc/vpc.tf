resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-${var.tier}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-${var.tier}"
  }
}

resource "aws_subnet" "main" {
  availability_zone       = "${var.region}b"
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/16"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-${var.tier}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-${var.tier}"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_vpc_endpoint" "private_s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
  route_table_id  = aws_route_table.main.id
}
