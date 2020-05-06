resource "aws_s3_bucket" "secure_windows_update" {
  bucket        = "secure-windows-update"
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

resource "aws_s3_bucket_public_access_block" "secure_windows_update" {
  bucket     = "secure-windows-update"
  depends_on = [aws_s3_bucket.secure_windows_update]

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
