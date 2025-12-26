# S3バケット名を出力
output "bucket_name" {
  description = "S3バケット名"
  value       = aws_s3_bucket.bucket.bucket
}

# S3バケットのARNを出力
output "bucket_arn" {
  description = "S3バケットのARN"
  value       = aws_s3_bucket.bucket.arn
}
