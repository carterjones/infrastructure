resource "aws_security_group" "allow_all_inbound_http_and_https" {
  name = "allow_all_inbound_http_and_https"
  description = "Allow all inbound HTTP and HTTPS traffic"
  vpc_id = "${data.terraform_remote_state.vpcs.vpc_main}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

output "allow_all_inbound_http_and_https" {
  value = "${aws_security_group.allow_all_inbound_http_and_https.id}"
}
