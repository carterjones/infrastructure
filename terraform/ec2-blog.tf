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

data "template_file" "user_data_blog" {
  template = <<-EOF
             #!/bin/bash
             /opt/carter/init-base.sh ${var.tier}
             /opt/carter/init-blog.sh
             EOF
}

resource "aws_instance" "blog" {
    ami           = "${data.aws_ami.blog.id}"
    availability_zone = "us-west-2b"
    instance_type = "t2.nano"
    key_name      = "${var.key_name}"
    subnet_id     = "${aws_subnet.main.id}"
    iam_instance_profile = "${aws_iam_instance_profile.blog.name}"
    vpc_security_group_ids = [
        "${aws_security_group.allow_all_inbound_ssh.id}",
        "${aws_security_group.allow_all_inbound_http_and_https.id}",
        "${aws_security_group.allow_egress.id}"
    ]
    tags = {
        role = "blog"
        Name = "blog-${var.tier}"
    }
    user_data = "${data.template_file.user_data_blog.rendered}"
}

data "aws_iam_policy_document" "blog" {
    statement {
        actions = [
            "s3:GetObject",
            "s3:PutObject"
        ]
        resources = [
            "arn:aws:s3:::carterjones-terraform-state-${var.tier}/ssl/blog.carterjones.info/*",
            "arn:aws:s3:::carterjones-terraform-state-${var.tier}/ssl/test.kelsey.life/*",
            "arn:aws:s3:::carterjones-terraform-state-${var.tier}/ssl/blog.kelsey.life/*",
        ]
    }
    statement {
        actions = [
            "s3:ListBucket",
            "s3:ListAllMyBuckets",
            "s3:ListBucket",
            "s3:ListBucketMultipartUploads",
            "s3:ListBucketVersions",
            "s3:ListMultipartUploadParts",
        ]
        resources = [
            "arn:aws:s3:::carterjones-terraform-state-${var.tier}",
        ]
        condition {
            test = "StringLike"
            variable = "s3:prefix"
            values = [
                "ssl/blog.carterjones.info/",
                "ssl/test.kelsey.life/",
                "ssl/blog.kelsey.life/",
            ]
        }
    }
}

resource "aws_iam_policy" "blog" {
    name   = "blog-${var.tier}"
    path   = "/"
    policy = "${data.aws_iam_policy_document.blog.json}"
}

resource "aws_iam_role" "blog" {
    name = "blog-${var.tier}"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "blog" {
    role       = "${aws_iam_role.blog.name}"
    policy_arn = "${aws_iam_policy.blog.arn}"
}

# Note: use of roles rather than role is depricated. However, if we use role,
# it doesn't actually set the role.
resource "aws_iam_instance_profile" "blog" {
    name = "blog-${var.tier}"
    roles = ["${aws_iam_role.blog.id}"]
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
