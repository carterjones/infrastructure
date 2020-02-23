module "gaming-us-west-2-prod" {
  source       = "./modules/gaming"
  gaming_sg_id = module.vpc_us_west_2_prod.gaming_sg_id
  egress_sg_id = module.vpc_us_west_2_prod.egress_sg_id
}
