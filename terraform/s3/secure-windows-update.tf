module "secure_windows_update" {
  source              = "../modules/s3_bucket"
  bucket_name         = "secure-windows-update"
  block_public_access = false
}
