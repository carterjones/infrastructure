# The main AWS Organization

resource "aws_organizations_organization" "main" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
  ]

  feature_set = "ALL"
}

# Organizational Units

resource "aws_organizations_organizational_unit" "carterjones" {
  name      = "carterjones"
  parent_id = aws_organizations_organization.main.roots.0.id
}

resource "aws_organizations_organizational_unit" "suspended" {
  name      = "suspended"
  parent_id = aws_organizations_organization.main.roots.0.id
}

module "org-scps" {
  source  = "trussworks/org-scp/aws"
  version = "~> 1.6.4"

  deny_all_access_target_ids = [aws_organizations_organizational_unit.suspended.id]
}

# Organization Accounts

resource "aws_organizations_account" "org_id" {
  name      = "carterjones-id"
  email     = "${var.email_username}+aws-org-id@${var.email_domain}"
  parent_id = aws_organizations_organizational_unit.carterjones.id

  iam_user_access_to_billing = "ALLOW"
  tags = {
    Automation = "Terraform"
  }
}

resource "aws_organizations_account" "org_infra" {
  name      = "carterjones-infra"
  email     = "${var.email_username}+aws-org-infra@${var.email_domain}"
  parent_id = aws_organizations_organizational_unit.carterjones.id

  iam_user_access_to_billing = "DENY"
  tags = {
    Automation = "Terraform"
  }
}

resource "aws_organizations_account" "org_prod" {
  name      = "carterjones-prod"
  email     = "${var.email_username}+aws-org-prod@${var.email_domain}"
  parent_id = aws_organizations_organizational_unit.carterjones.id

  iam_user_access_to_billing = "DENY"
  tags = {
    Automation = "Terraform"
  }

  # This account was imported, so when Terraform sees either ALLOW or DENY for
  # iam_user_access_to_billing, it wants to recreate the account, because there
  # is no AWS Organizations API for reading iam_user_access_to_billing. See
  # https://github.com/hashicorp/terraform-provider-aws/issues/12959 for more
  # details.
  #
  # Therefore use this workaround. Last updated 2021-03-13.
  lifecycle {
    ignore_changes = [iam_user_access_to_billing]
  }
}

# Outputs

output "aws_organizations_account_org_id_id" {
  description = "ID for the carterjones id account"
  value       = aws_organizations_account.org_id.id
}

output "aws_organizations_account_org_infra_id" {
  description = "ID for the carterjones infra account"
  value       = aws_organizations_account.org_infra.id
}

output "aws_organizations_account_org_prod_id" {
  description = "ID for the carterjones prod account"
  value       = aws_organizations_account.org_prod.id
}
