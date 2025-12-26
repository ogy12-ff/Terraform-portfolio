#S3モジュールから受け取るウェブサイトエンドポイント
variable "s3_website_endpoint" {
  description = "S3から受け取るウェブサイトエンドポイント"
  type        = string
}

variable "s3_origin_id" {
  description = "オリジンとして使用するS3バケットのID"
  type        = string
}

variable "index_documents" {
  description = "The default root object for the CloudFront distribution."
  type        = string
}
