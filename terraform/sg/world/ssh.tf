resource "aws_security_group" "allow_all_inbound_ssh" {
  name = "allow_all_inbound_ssh"
  description = "Allow all inbound SSH traffic"
  vpc_id = "${data.terraform_remote_state.vpcs.vpc_main}"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

output "allow_all_inbound_ssh" {
  value = "${aws_security_group.allow_all_inbound_ssh.id}"
}
