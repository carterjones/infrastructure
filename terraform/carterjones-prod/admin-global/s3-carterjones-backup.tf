resource "aws_s3_bucket" "carterjones_backup" {
  bucket        = "carterjones-backup"
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "carterjones_backup" {
  bucket = aws_s3_bucket.carterjones_backup.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "carterjones_backup" {
  bucket = aws_s3_bucket.carterjones_backup.id

  rule {
    id     = "carterjones-backup"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

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
      noncurrent_days = 1
    }
  }
}

resource "aws_s3_bucket_versioning" "carterjones_backup" {
  bucket = aws_s3_bucket.carterjones_backup.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "carterjones_backup" {
  bucket = aws_s3_bucket.carterjones_backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "carterjones_backup" {
  bucket = aws_s3_bucket.carterjones_backup.id

  acl = "private"
}

resource "aws_s3_bucket_replication_configuration" "carterjones_backup" {
  bucket = aws_s3_bucket.carterjones_backup.id

  role = aws_iam_role.carterjones_backup_replication.arn

  rule {
    id     = "full-bucket-replication"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.carterjones_backup_replica.arn
      storage_class = "DEEP_ARCHIVE"
    }
  }
}

resource "aws_s3_bucket" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket        = "carterjones-backup-replica"
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket = aws_s3_bucket.carterjones_backup_replica.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket = aws_s3_bucket.carterjones_backup_replica.id

  rule {
    id     = "carterjones-backup-replica"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    transition {
      days          = 1
      storage_class = "DEEP_ARCHIVE"
    }

    noncurrent_version_expiration {
      noncurrent_days = 1
    }

    expiration {
      expired_object_delete_marker = true
    }
  }
}

resource "aws_s3_bucket_versioning" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket = aws_s3_bucket.carterjones_backup_replica.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket = aws_s3_bucket.carterjones_backup_replica.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "carterjones_backup_replica" {
  provider = aws.useast1

  bucket = aws_s3_bucket.carterjones_backup_replica.id

  acl = "private"
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
