resource "aws_s3_bucket" "rei_carterjones_info_logs" {
  bucket        = "rei.carterjones.info-logs"
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

resource "aws_s3_bucket_public_access_block" "rei_carterjones_info_logs" {
  bucket     = "rei.carterjones.info-logs"
  depends_on = [aws_s3_bucket.rei_carterjones_info_logs]

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "rei_carterjones_info_logs" {
  bucket = "rei.carterjones.info-logs"
  policy = data.aws_iam_policy_document.rei_carterjones_info_logs.json
}

data "aws_iam_policy_document" "rei_carterjones_info_logs" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::rei.carterjones.info-logs"]
  }

  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::rei.carterjones.info-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
  }
}
