# tfsec:ignore:aws-s3-enable-bucket-logging
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

  # tfsec:ignore:aws-s3-enable-versioning
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

# tfsec:ignore:aws-s3-block-public-acls
# tfsec:ignore:aws-s3-block-public-policy
# tfsec:ignore:aws-s3-ignore-public-acls
# tfsec:ignore:aws-s3-no-public-buckets
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.block_public_access
  block_public_policy     = var.block_public_access
  ignore_public_acls      = var.block_public_access
  restrict_public_buckets = var.block_public_access
}
