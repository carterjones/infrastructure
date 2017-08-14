data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }

        effect = "Allow"
    }
}

data "aws_iam_policy_document" "concourse" {
    statement {
        sid = "1"

        actions = [
            "ec2:*",
        ]

        resources = [
            "*",
        ]
    }
}

resource "aws_iam_policy" "concourse" {
    name   = "concourse"
    path   = "/"
    policy = "${data.aws_iam_policy_document.concourse.json}"
}

resource "aws_iam_role" "concourse" {
    name = "concourse"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "concourse" {
    role       = "${aws_iam_role.concourse.name}"
    policy_arn = "${aws_iam_policy.concourse.arn}"
}
