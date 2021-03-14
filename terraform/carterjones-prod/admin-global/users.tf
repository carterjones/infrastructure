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
