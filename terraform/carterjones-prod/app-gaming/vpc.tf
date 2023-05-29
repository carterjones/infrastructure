data "aws_region" "current" {}

# tfsec:ignore:aws-ec2-no-public-ip-subnet
# tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0.2"

  name = "app-gaming"
  cidr = "10.1.0.0/16"

  azs             = ["${data.aws_region.current.name}b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}
