module "gaming-prod-us-west-2" {
  source = "../modules/gaming"
  enable = var.enable_gaming
  tier   = "prod"
}

variable "enable_gaming" {
  default = 0
}
