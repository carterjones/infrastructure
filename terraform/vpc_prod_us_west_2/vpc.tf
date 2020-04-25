module "vpc_prod_us_west_2" {
  source = "../modules/vpc"
  region = "us-west-2"
  tier   = "prod"
}
