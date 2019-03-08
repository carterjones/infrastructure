data "aws_ami" "git" {
    filter {
        name = "state"
        values = ["available"]
    }
    filter {
        name = "tag:role"
        values = ["git"]
    }
    most_recent = true
    owners      = ["self"]
}

resource "aws_instance" "git" {
    ami           = "${data.aws_ami.git.id}"
    availability_zone = "us-west-2b"
    instance_type = "t2.nano"
    key_name      = "primary"
    subnet_id     = "${aws_subnet.main.id}"
    vpc_security_group_ids = [
        "${aws_security_group.allow_all_inbound_ssh.id}",
        "${aws_security_group.allow_all_inbound_http_and_https.id}"
    ]
    tags = {
        role = "git"
        tier = "${var.tier}"
        Name = "git-${var.tier}"
    }
}

resource "aws_ebs_volume" "git_state" {
    availability_zone = "us-west-2b"
    size = 1
}

resource "aws_volume_attachment" "git_state" {
    device_name = "/dev/xvdb"
    volume_id = "${aws_ebs_volume.git_state.id}"
    instance_id = "${aws_instance.git.id}"
}

resource "aws_eip" "git" {
    vpc = true
}

resource "aws_eip_association" "git" {
    instance_id = "${aws_instance.git.id}"
    allocation_id = "${aws_eip.git.id}"
}

output "ip-git" {
    value = "${aws_eip.git.public_ip}"
}
