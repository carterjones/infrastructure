# migrate to using modules by using this approach:
# https://groups.google.com/forum/#!msg/terraform-tool/Huijbmz9Y2E/bqFwLpuPDgAJ

data "aws_ami" "base" {
    filter {
        name = "state"
        values = ["available"]
    }
    filter {
        name = "tag:role"
        values = ["base"]
    }
    most_recent = true
    owners      = ["self"]
}

resource "aws_instance" "base" {
    ami           = "${data.aws_ami.base.id}"
    instance_type = "t2.nano"
    key_name      = "${var.key_name}"
    subnet_id     = "${aws_subnet.main.id}"
    vpc_security_group_ids = [
        "${aws_security_group.allow_all_inbound_ssh.id}",
        "${aws_security_group.allow_all_inbound_http_and_https.id}",
        "${aws_security_group.allow_egress.id}"
    ]
    tags = {
        role = "base"
        tier = "${var.tier}"
        Name = "base-${var.tier}"
    }
}

output "ip-base" {
    value = "${aws_instance.base.public_ip}"
}

output "ami-base" {
    value = "${data.aws_ami.base.id}"
}
