resource "aws_iam_group" "admins" {
  name = "admins"
}

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
    actions   = ["*"]
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_group_policy_attachment" "admins_full_access_with_mfa" {
  group      = aws_iam_group.admins.name
  policy_arn = aws_iam_policy.full_access_with_mfa.arn
}
