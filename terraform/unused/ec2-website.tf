data "aws_ami" "website" {
    filter {
        name = "state"
        values = ["available"]
    }
    filter {
        name = "tag:role"
        values = ["go-website"]
    }
    most_recent = true
}

resource "aws_instance" "website" {
    ami           = "${data.aws_ami.website.id}"
    instance_type = "t2.nano"
    key_name      = "primary"
    subnet_id     = "${aws_subnet.main.id}"
    vpc_security_group_ids = [
        "${aws_security_group.allow_all_inbound_ssh.id}",
        "${aws_security_group.allow_all_inbound_http_and_https.id}",
        "${aws_security_group.block_egress.id}"
    ]
    tags = {
        role = "go-website"
    }
}

resource "aws_eip" "website" {
    vpc = true
}

resource "aws_eip_association" "website" {
    instance_id = "${aws_instance.website.id}"
    allocation_id = "${aws_eip.website.id}"
}
