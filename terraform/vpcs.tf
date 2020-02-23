module "vpc_us_west_1_prod" {
  source = "./modules/vpc"
  region = "us-west-1"
  tier   = "prod"
}

module "vpc_us_west_2_prod" {
  source = "./modules/vpc"
  region = "us-west-2"
  tier   = "prod"
}
