# EC2がロールを引き受けるためのポリシードキュメント
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAMロールを作成（EC2がS3にアクセスするためのロール）
resource "aws_iam_role" "ec2_role" {
  name               = "${var.service_name}-${var.env}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAMロールにS3アクセス権限を付与するポリシー
resource "aws_iam_role_policy" "s3_access" {
  name = "${var.service_name}-${var.env}-s3-access"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.bucket_arn,
          "${var.bucket_arn}/*"
        ]
      }
    ]
  })
}

# IAMインスタンスプロファイルを作成（EC2にロールをアタッチ）
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.service_name}-${var.env}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
