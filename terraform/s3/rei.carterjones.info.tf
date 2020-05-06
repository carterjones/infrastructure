resource "aws_s3_bucket" "rei_carterjones_info" {
  bucket        = "rei.carterjones.info"
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
    enabled = true
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["https://cdn.rei.carterjones.info"]
    expose_headers  = []
    max_age_seconds = 0
  }
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["https://rei.carterjones.info"]
    expose_headers  = []
    max_age_seconds = 0
  }
}

resource "aws_s3_bucket_public_access_block" "rei_carterjones_info" {
  bucket     = "rei.carterjones.info"
  depends_on = [aws_s3_bucket.rei_carterjones_info]

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
