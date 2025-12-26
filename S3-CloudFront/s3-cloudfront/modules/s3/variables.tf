#S3バケットの設定
variable "bucket_name" {
  description = "S3バケットの名前"
  type        = string
}

#インデックスドキュメントの指定
variable "index_documents" {
  description = "参照ドキュメントの指定(例：index.html)"
  type        = string
  default     = "index.html"
}
