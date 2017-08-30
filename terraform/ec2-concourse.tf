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
        tier = "${var.tier}"
        Name = "concourse-${var.tier}"
    }
}

# TODO: split out the IAM roles for the EC2 instance and the concourse user.
# TODO: make terraform control the concourse IAM user.
data "aws_iam_policy_document" "concourse" {
    statement {
        actions = ["ec2:*"]
        resources = ["*"]
    }
    statement {
        actions = ["s3:*"]
        resources = ["*"]
    }
    statement {
        actions = ["s3:*"]
        resources = ["arn:aws:s3:::carterjones-pipeline-artifacts*"]
    }
    statement {
        actions = ["s3:*"]
        resources = ["arn:aws:s3:::carterjones-pipeline-artifacts/*"]
    }
    statement {
        actions = [
            "iam:AttachRolePolicy",
            "iam:CreateInstanceProfile",
            "iam:CreatePolicy",
            "iam:CreateRole",
            "iam:GetInstanceProfile",
            "iam:GetPolicy",
            "iam:GetPolicyVersion",
            "iam:GetRole",
            "iam:ListAttachedRolePolicies",
            "iam:PassRole",
        ]
        resources = ["*"]
    }
}

resource "aws_iam_policy" "concourse" {
    name   = "concourse-${var.tier}"
    path   = "/"
    policy = "${data.aws_iam_policy_document.concourse.json}"
}

resource "aws_iam_role" "concourse" {
    name = "concourse-${var.tier}"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "concourse" {
    role       = "${aws_iam_role.concourse.name}"
    policy_arn = "${aws_iam_policy.concourse.arn}"
}

resource "aws_iam_instance_profile" "concourse" {
    name = "concourse-${var.tier}"
    role = "${aws_iam_role.concourse.id}"
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
