resource "aws_iam_policy" "full_access_with_mfa" {
  name        = "full_access_with_mfa"
  path        = "/"
  description = "Allow all actions when using MFA."
  policy      = data.aws_iam_policy_document.full_access_with_mfa.json
}

data "aws_iam_policy_document" "full_access_with_mfa" {
  statement {
    sid       = "FullAccessWithMFA"
    effect    = "Allow"
    actions   = ["*"] #tfsec:ignore:AWS046 Admins should be able to do anything here.
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_user" "carter" {
  name = "carter"
}

resource "aws_iam_role" "admin" {
  name = "admin"
  assume_role_policy = jsonencode({
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { AWS = aws_iam_user.carter.arn }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "admin_full_access_with_mfa" {
  role       = aws_iam_role.admin.name
  policy_arn = aws_iam_policy.full_access_with_mfa.arn
}
