provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "main"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
    }
}

resource "aws_subnet" "main" {
    availability_zone = "us-west-2b"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.0.0/16"
    map_public_ip_on_launch = true

    tags {
        Name = "main"
    }
}

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags {
        Name = "main"
    }
}

resource "aws_route_table_association" "main" {
    subnet_id = "${aws_subnet.main.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_vpc_endpoint" "private_s3" {
    vpc_id = "${aws_vpc.main.id}"
    service_name = "com.amazonaws.us-west-2.s3"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
    vpc_endpoint_id = "${aws_vpc_endpoint.private_s3.id}"
    route_table_id = "${aws_route_table.main.id}"
}

output "subnet_main" {
  value = "${aws_subnet.main.id}"
}

output "vpc_main" {
  value = "${aws_vpc.main.id}"
}
