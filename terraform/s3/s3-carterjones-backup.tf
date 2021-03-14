#tfsec:ignore:AWS002 I'm cheap and don't want to pay for storing logs.
resource "aws_s3_bucket" "carterjones_backup" {
  bucket        = "carterjones-backup"
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

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      expired_object_delete_marker = true
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  replication_configuration {
    role = aws_iam_role.carterjones_backup_replication.arn

    rules {
      id     = "full-bucket-replication"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.carterjones_backup_replica.arn
        storage_class = "DEEP_ARCHIVE"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "carterjones_backup" {
  bucket     = "carterjones-backup"
  depends_on = [aws_s3_bucket.carterjones_backup]

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#tfsec:ignore:AWS002 I'm cheap and don't want to pay for storing logs.
resource "aws_s3_bucket" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket        = "carterjones-backup-replica"
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

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    transition {
      days          = 1
      storage_class = "DEEP_ARCHIVE"
    }

    noncurrent_version_expiration {
      days = 1
    }

    expiration {
      expired_object_delete_marker = true
    }
  }
}

resource "aws_s3_bucket_public_access_block" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket     = "carterjones-backup-replica"
  depends_on = [aws_s3_bucket.carterjones_backup_replica]

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "carterjones_backup_replication" {
  name               = "carterjones-backup-replication"
  assume_role_policy = data.aws_iam_policy_document.carterjones_backup_replication_role.json
}

data "aws_iam_policy_document" "carterjones_backup_replication_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "carterjones_backup_replication" {
  name   = "carterjones-backup-replication"
  policy = data.aws_iam_policy_document.carterjones_backup_replication_policy.json
}

data "aws_iam_policy_document" "carterjones_backup_replication_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]
    resources = [aws_s3_bucket.carterjones_backup.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
    ]
    resources = ["${aws_s3_bucket.carterjones_backup.arn}/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
    ]
    resources = ["${aws_s3_bucket.carterjones_backup_replica.arn}/*"]
  }
}

resource "aws_iam_role_policy_attachment" "carterjones_backup_replication" {
  role       = aws_iam_role.carterjones_backup_replication.name
  policy_arn = aws_iam_policy.carterjones_backup_replication.arn
}
