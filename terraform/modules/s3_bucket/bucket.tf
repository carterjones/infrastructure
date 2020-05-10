resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  acl           = var.canned_acl
  force_destroy = false

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  # Optionally define a website block if the html_page variable is defined.
  dynamic "website" {
    for_each = compact([var.html_page])
    content {
      index_document = var.html_page
      error_document = var.html_page
    }
  }

  # Optionally define a website block if the redirect variable is defined.
  dynamic "website" {
    for_each = compact([var.redirect])
    content {
      redirect_all_requests_to = var.redirect
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket     = var.bucket_name
  depends_on = [aws_s3_bucket.bucket]

  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}
