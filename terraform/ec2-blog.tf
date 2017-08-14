data "aws_ami" "blog" {
    filter {
        name = "state"
        values = ["available"]
    }
    filter {
        name = "tag:role"
        values = ["blog"]
    }
    most_recent = true
}

resource "aws_instance" "blog" {
    ami           = "${data.aws_ami.blog.id}"
    availability_zone = "us-west-2b"
    instance_type = "t2.nano"
    key_name      = "primary"
    subnet_id     = "${aws_subnet.main.id}"
    vpc_security_group_ids = [
        "${aws_security_group.allow_all_inbound_ssh.id}",
        "${aws_security_group.allow_all_inbound_http_and_https.id}"
    ]
    tags = {
        role = "blog"
        Name = "blog"
    }
}

resource "aws_ebs_volume" "blog_state" {
    availability_zone = "us-west-2b"
    size = 1
}

resource "aws_volume_attachment" "blog_state" {
    device_name = "/dev/xvdb"
    volume_id = "${aws_ebs_volume.blog_state.id}"
    instance_id = "${aws_instance.blog.id}"
}

resource "aws_eip" "blog" {
    vpc = true
}

resource "aws_eip_association" "blog" {
    instance_id = "${aws_instance.blog.id}"
    allocation_id = "${aws_eip.blog.id}"
}

output "ip-blog" {
    value = "${aws_eip.blog.public_ip}"
}
