data "aws_caller_identity" "current" {}

locals {
  admin_users = [
    "carter.org-root",
  ]
}

resource "aws_iam_user" "admins" {
  for_each      = toset(local.admin_users)
  name          = each.value
  force_destroy = true

  tags = {
    Automation = "Terraform"
  }
}

module "admins_group" {
  source  = "trussworks/iam-user-group/aws"
  version = "2.1.0"

  user_list     = local.admin_users
  group_name    = "admins"
  allowed_roles = [aws_iam_role.admin.arn]
}

# This is a generic role assumption policy that enforces MFA.
data "aws_iam_policy_document" "role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    # only allow folks in this account
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    # require MFA
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "admin" {
  name               = "admin"
  description        = "Role for organization administrators"
  assume_role_policy = data.aws_iam_policy_document.role_assume_role_policy.json
  tags = {
    Automation = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "admin_administrator_access" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
