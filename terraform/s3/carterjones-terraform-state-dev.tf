resource "aws_s3_bucket" "carterjones_terraform_state_dev" {
  bucket        = "carterjones-terraform-state-dev"
  acl           = "private"
  force_destroy = false

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_public_access_block" "carterjones_terraform_state_dev" {
  bucket     = "carterjones-terraform-state-dev"
  depends_on = [aws_s3_bucket.carterjones_terraform_state_dev]

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
