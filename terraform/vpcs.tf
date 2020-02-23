module "vpc-us-west-1-prod" {
  source = "./modules/vpc"
  region = "us-west-1"
  tier   = "prod"
}

module "vpc-us-west-2-prod" {
  source = "./modules/vpc"
  region = "us-west-2"
  tier   = "prod"
}
