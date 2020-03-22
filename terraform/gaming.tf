module "gaming-us-west-2-prod" {
  source                   = "./modules/gaming"
  subnet_id                = module.vpc_us_west_2_prod.subnet_id
  gaming_sg_id             = module.vpc_us_west_2_prod.gaming_sg_id
  egress_sg_id             = module.vpc_us_west_2_prod.egress_sg_id
  gaming_eip_allocation_id = module.vpc_us_west_2_prod.gaming_eip_allocation_id
  enable                   = var.enable_gaming
}

variable "enable_gaming" {
  default = 0
}
