module "static_website" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
}

# CloudFrontが参照できるように出力を定義
output "s3_website_endpoint" {
  value = module.static_website.website_endpoint
}

output "s3_origin_id" {
  value = module.static_website.bucket_id
}

output "index_document_name" {
  value = module.static_website.index_document_name
}
