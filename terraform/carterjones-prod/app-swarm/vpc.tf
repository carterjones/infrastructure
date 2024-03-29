data "aws_region" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0.2"

  name = "app-swarm"
  cidr = "10.2.0.0/16"

  azs             = ["${data.aws_region.current.name}b"]
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  public_subnets  = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dns_hostnames    = false
  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}
