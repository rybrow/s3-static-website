resource "aws_s3_bucket" "website_bucket" {
  bucket = var.static_website_address
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = var.static_website_index_document
  }

  error_document {
    key = var.static_website_error_document
  }
}

resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl    = var.static_website_bucket_acl
}

resource "aws_s3_bucket_versioning" "website_bucket_versioning" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = var.static_website_bucket_versioning
  }
}

resource "aws_s3_bucket_policy" "website_access_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = data.aws_iam_policy_document.website_policy.json
}

data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}/*"
    ]
  }
}

resource "aws_route53_record" "website_address" {
  depends_on = [
    aws_s3_bucket_policy.website_access_policy
  ]
  zone_id = var.route53_hosted_zone_id
  name    = var.static_website_address
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.website_configuration.website_domain
    zone_id                = aws_s3_bucket.website_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket" "www_website_bucket" {
  bucket = "www.${var.static_website_address}"
}

resource "aws_s3_bucket_website_configuration" "www_website_configuration" {
  bucket = aws_s3_bucket.www_website_bucket.bucket

  redirect_all_requests_to {
    host_name = var.static_website_address
  }
}

resource "aws_route53_record" "www_website_address" {
  depends_on = [
    aws_s3_bucket_policy.website_access_policy
  ]
  zone_id = var.route53_hosted_zone_id
  name    = aws_s3_bucket.www_website_bucket.bucket
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.www_website_configuration.website_domain
    zone_id                = aws_s3_bucket.website_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}
