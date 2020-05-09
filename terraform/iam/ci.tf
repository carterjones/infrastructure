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
  description = "Allow downloading from, uploading to, and listing the CI bucket."
  policy      = data.aws_iam_policy_document.list_ci_bucket.json
}

data "aws_iam_policy_document" "list_ci_bucket" {
  statement {
    sid    = "ListCIBucketObjects"
    effect = "Allow"

    # ListBucket is the only permission required to perform a `terraform init`
    # command when using an s3 backend.
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::carterjones-terraform-state-ci"]
  }
}
