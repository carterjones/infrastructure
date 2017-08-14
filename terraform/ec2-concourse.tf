data "aws_ami" "concourse" {
    filter {
        name = "state"
        values = ["available"]
    }
    filter {
        name = "tag:role"
        values = ["concourse"]
    }
    most_recent = true
}

resource "aws_iam_instance_profile" "concourse" {
    name = "concourse"
    role = "${aws_iam_role.concourse.id}"
}

resource "aws_instance" "concourse" {
    ami           = "${data.aws_ami.concourse.id}"
    instance_type = "t2.nano"
    key_name      = "primary"
    subnet_id     = "${aws_subnet.main.id}"
    iam_instance_profile = "${aws_iam_instance_profile.concourse.name}"
    vpc_security_group_ids = [
        "${aws_security_group.allow_all_inbound_ssh.id}",
        "${aws_security_group.allow_all_inbound_http_and_https.id}",
        "${aws_security_group.allow_egress.id}"
    ]
    tags = {
        role = "concourse"
        Name = "concourse"
    }
}

resource "aws_eip" "concourse" {
    vpc = true
}

resource "aws_eip_association" "concourse" {
    instance_id = "${aws_instance.concourse.id}"
    allocation_id = "${aws_eip.concourse.id}"
}

output "ip-concourse" {
    value = "${aws_eip.concourse.public_ip}"
}
