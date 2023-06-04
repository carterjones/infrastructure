data "aws_caller_identity" "current" {}

locals {
  admin_users = [
    "carter",
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

# tfsec:ignore:aws-iam-no-policy-wildcards
module "admins_group_mfa" {
  source  = "trussworks/mfa/aws"
  version = "~> 3"

  iam_groups = ["admins"]
}

# This is a generic role assumption policy that enforces MFA.
data "aws_iam_policy_document" "role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    # Only allow users in this account to use this policy.
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    # Require MFA.
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

# Allow the admin role to access the org_id account.
data "aws_iam_policy_document" "org_id_cross_account_access" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${aws_organizations_account.org_id.id}:role/OrganizationAccountAccessRole",
    ]
  }
}

resource "aws_iam_policy" "org_id_cross_account_access" {
  name        = "org-id-cross-account-access"
  path        = "/"
  description = "Allow cross-account access to the ${aws_organizations_account.org_id.id} account."
  policy      = data.aws_iam_policy_document.org_id_cross_account_access.json
}

resource "aws_iam_role_policy_attachment" "org_id_cross_account_access" {
  role       = aws_iam_role.admin.name
  policy_arn = aws_iam_policy.org_id_cross_account_access.arn
}
