#S3バケットの作成
resource "aws_s3_bucket" "sample_bucket" {
  bucket = var.bucket_name
}

#S3バケットのウェブサイト設定
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.sample_bucket.id

  index_document {
    suffix = var.index_documents
  }
}

#パブリックアクセス設定
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.sample_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#バケットポリシー設定
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.sample_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.sample_bucket.arn}/*"]
      },
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.public_access_block]
}
