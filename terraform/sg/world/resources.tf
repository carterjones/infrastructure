data "terraform_remote_state" "vpcs" {
    backend = "s3"
    config {
        bucket = "carterjones-terraform-state-prod"
        key = "vpc/terraform.tfstate"
        region = "us-west-2"
    }
}
