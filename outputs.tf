output "s3_bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "route53_alias" {
  value = aws_route53_record.website_address.alias
}
