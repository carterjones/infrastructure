data "aws_caller_identity" "current" {}

#
# IAM Users, Groups, and Roles
#

# Generic role assumption policy requiring MFA
data "aws_iam_policy_document" "user_assume_role_policy" {
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

# This module enforces MFA; any groups defined in this file should
# be added to the iam_groups argument.
# tfsec:ignore:aws-iam-no-policy-wildcards
module "iam_enforce_mfa" {
  source  = "trussworks/mfa/aws"
  version = "3.0.1"

  iam_groups = ["infra", "engineer", "billing"]
  iam_users  = []
}

locals {
  infra_users = [
    "carter",
  ]

  billing_users = [
    "carter.billing"
  ]

  engineer_users = [
    "carter.eng",
  ]
}

resource "aws_iam_user" "infra_users" {
  for_each      = toset(local.infra_users)
  name          = each.value
  force_destroy = true

  tags = {
    Automation = "Terraform"
  }
}

resource "aws_iam_user" "billing_users" {
  for_each      = toset(local.billing_users)
  name          = each.value
  force_destroy = true

  tags = {
    Automation = "Terraform"
  }
}

resource "aws_iam_user" "engineer_users" {
  for_each      = toset(local.engineer_users)
  name          = each.value
  force_destroy = true

  tags = {
    Automation = "Terraform"
  }
}

module "infra_group" {
  source  = "trussworks/iam-user-group/aws"
  version = "2.1.0"

  user_list = local.infra_users
  allowed_roles = [
    aws_iam_role.infra.arn,
    "arn:aws:iam::${var.account_id_infra}:role/infra",
    "arn:aws:iam::${var.account_id_org_root}:role/billing",
    # "arn:aws:iam::${var.account_id_sandbox}:role/infra",
    "arn:aws:iam::${var.account_id_prod}:role/infra",
  ]
  group_name = "infra"
}

module "billing_group" {
  source  = "trussworks/iam-user-group/aws"
  version = "2.1.0"

  user_list = local.billing_users
  allowed_roles = [
    "arn:aws:iam::${var.account_id_org_root}:role/billing",
  ]
  group_name = "billing"
}

module "engineers_group" {
  source  = "trussworks/iam-user-group/aws"
  version = "2.1.0"

  user_list = local.engineer_users
  allowed_roles = [
    aws_iam_role.engineer.arn,
    # "arn:aws:iam::${var.account_id_sandbox}:role/engineer",
    "arn:aws:iam::${var.account_id_prod}:role/engineer",
  ]
  group_name = "engineer"
}

resource "aws_iam_role" "infra" {
  name               = "infra"
  assume_role_policy = data.aws_iam_policy_document.user_assume_role_policy.json
}

resource "aws_iam_role" "engineer" {
  name               = "engineer"
  assume_role_policy = data.aws_iam_policy_document.user_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "infra_local_policy_attachment" {
  role       = aws_iam_role.infra.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy_attachment" "engineer_local_policy_attachment" {
  role       = aws_iam_role.engineer.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
