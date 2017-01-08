resource "aws_security_group" "block_egress" {
  name = "block_egress"
  description = "Block all egress."
  vpc_id = "${data.terraform_remote_state.vpcs.vpc_main}"

  egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["127.0.0.1/32"]
  }
}

output "block_egress" {
  value = "${aws_security_group.block_egress.id}"
}
