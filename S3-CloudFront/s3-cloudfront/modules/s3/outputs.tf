#S3バケットのウェブサイトエンドポイント
output "website_endpoint" {
  description = "S3バケットのウェブサイトエンドポイントです"
  value       = aws_s3_bucket_website_configuration.website_config.website_endpoint
}

output "bucket_id" {
  description = "S3バケットのIDです"
  value       = aws_s3_bucket.sample_bucket.id
}
#トップページ
output "index_document_name" {
  description = "The index document name."
  value       = var.index_documents
}
