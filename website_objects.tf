resource "aws_s3_object" "html_objects" {
  depends_on = [
    aws_s3_bucket.website_bucket
  ]
  for_each     = fileset(var.static_website_objects_root, "**.html")
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = each.value
  source       = "${var.static_website_objects_root}${each.value}"
  etag         = filemd5("${var.static_website_objects_root}${each.value}")
  content_type = "text/html"
}

resource "aws_s3_object" "css_objects" {
  depends_on = [
    aws_s3_bucket.website_bucket
  ]
  for_each     = fileset(var.static_website_objects_root, "**.css")
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = each.value
  source       = "${var.static_website_objects_root}${each.value}"
  etag         = filemd5("${var.static_website_objects_root}${each.value}")
  content_type = "text/css"
}

resource "aws_s3_object" "js_objects" {
  depends_on = [
    aws_s3_bucket.website_bucket
  ]
  for_each     = fileset(var.static_website_objects_root, "**.js")
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = each.value
  source       = "${var.static_website_objects_root}${each.value}"
  etag         = filemd5("${var.static_website_objects_root}${each.value}")
  content_type = "application/javascript"
}

resource "aws_s3_object" "image_objects" {
  depends_on = [
    aws_s3_bucket.website_bucket
  ]
  for_each     = fileset(var.static_website_objects_root, "**/*.JPG")
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = each.value
  source       = "${var.static_website_objects_root}${each.value}"
  etag         = filemd5("${var.static_website_objects_root}${each.value}")
  content_type = "image/jpeg"
}