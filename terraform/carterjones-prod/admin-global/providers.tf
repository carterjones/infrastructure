provider "aws" {
  region = local.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}
