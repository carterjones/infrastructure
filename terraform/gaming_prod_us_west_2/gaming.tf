module "gaming-prod-us-west-2" {
  source = "../modules/gaming"
  enable = var.enable
  tier   = "prod"
}

variable "enable" {
  default = 0
}
