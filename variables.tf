variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "static_website_address" {
  type    = string
}

variable "static_website_index_document" {
  type    = string
  default = "index.html"
}

variable "static_website_error_document" {
  type    = string
  default = "error.html"
}

variable "static_website_bucket_acl" {
  type    = string
  default = "private"
}

variable "static_website_bucket_versioning" {
  type    = string
  default = "Enabled"
}

variable "static_website_objects_root" {
  type    = string
  default = "../src/"
}

variable "route53_hosted_zone_id" {
  type = string
}