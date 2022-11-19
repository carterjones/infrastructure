variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "block_public_access" {
  description = "True if this bucket should be private."
  default     = true
  type        = bool
}

variable "versioning_enabled" {
  description = "True if versoning should be enabled."
  default     = false
  type        = bool
}

variable "canned_acl" {
  description = "The canned ACL to use for this bucket."
  default     = "private"
  type        = string
}

variable "html_page" {
  description = "Optional. A web page to serve from this bucket."
  default     = ""
  type        = string
}

variable "redirect" {
  description = "Optional. Make the bucket's static site redirect to this URL."
  default     = ""
  type        = string
}
