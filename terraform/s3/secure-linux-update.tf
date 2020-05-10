module "secure_linux_update" {
  source              = "../modules/s3_bucket"
  bucket_name         = "secure-linux-update"
  block_public_access = false
}
