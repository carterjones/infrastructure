resource "aws_s3_bucket" "git_carterjones_info" {
  bucket        = "git.carterjones.info"
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

resource "aws_s3_bucket_public_access_block" "git_carterjones_info" {
  bucket     = "git.carterjones.info"
  depends_on = [aws_s3_bucket.git_carterjones_info]

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
