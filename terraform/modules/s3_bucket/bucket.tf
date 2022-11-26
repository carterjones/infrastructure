# tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = false
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

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning_status
  }
}

# tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  acl = var.canned_acl
}

# Optionally define a website block if the html_page variable is defined.
resource "aws_s3_bucket_website_configuration" "bucket_website" {
  count = var.html_page == "" ? 0 : 1

  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.html_page
  }

  error_document {
    key = var.html_page
  }
}

# Optionally define a website block if the redirect variable is defined.
resource "aws_s3_bucket_website_configuration" "bucket_redirect" {
  count = var.redirect == "" ? 0 : 1

  bucket = aws_s3_bucket.bucket.id

  redirect_all_requests_to {
    host_name = var.redirect
    protocol  = "https"
  }
}
