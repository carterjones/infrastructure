# Infra role.

module "infra_role" {
  source  = "trussworks/iam-cross-acct-dest/aws"
  version = "3.0.1"

  iam_role_name     = "infra"
  source_account_id = var.account_id_id
}

resource "aws_iam_role_policy_attachment" "infra_role_policy" {
  role       = module.infra_role.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# CI user.

# tfsec:ignore:aws-iam-enforce-group-mfa
resource "aws_iam_group" "ci_runners" {
  name = "ci-runners"
}

resource "aws_iam_user" "ci_runner" {
  name = "ci-runner"
}

resource "aws_iam_user_group_membership" "ci_runner" {
  user   = aws_iam_user.ci_runner.name
  groups = [aws_iam_group.ci_runners.name]
}

resource "aws_iam_group_policy_attachment" "ci_runners_list_ci_bucket" {
  group      = aws_iam_group.ci_runners.name
  policy_arn = aws_iam_policy.list_ci_bucket.arn
}

resource "aws_iam_policy" "list_ci_bucket" {
  name        = "list-ci-bucket"
  path        = "/"
  description = "Allow listing the CI bucket."
  policy      = data.aws_iam_policy_document.list_ci_bucket.json
}

data "aws_iam_policy_document" "list_ci_bucket" {
  statement {
    sid    = "ListCIBucket"
    effect = "Allow"

    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::carterjones-terraform-state-ci"]
  }
}

resource "aws_iam_group_policy_attachment" "ci_runners_get_put_ci_state" {
  group      = aws_iam_group.ci_runners.name
  policy_arn = aws_iam_policy.get_put_ci_state.arn
}

resource "aws_iam_policy" "get_put_ci_state" {
  name        = "get-put-ci-state"
  path        = "/"
  description = "Allow downloading and uploading the CI state files."
  policy      = data.aws_iam_policy_document.get_put_ci_state.json
}

# tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "get_put_ci_state" {
  statement {
    sid    = "GetPutCIStateObjects"
    effect = "Allow"

    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::carterjones-terraform-state-ci/*.state"]
  }
}
