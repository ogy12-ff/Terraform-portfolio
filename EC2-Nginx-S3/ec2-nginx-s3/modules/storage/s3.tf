# S3バケットを作成（静的ファイルを保存）
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.service_name}-${var.env}-bucket"

  tags = {
    Name = "${var.service_name}-${var.env}-s3-bucket"
    Env  = var.env
  }
}
