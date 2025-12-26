# Pythonコードをzipファイルにパッケージ
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/index.py"
  output_path = "${path.module}/lambda_function.zip"
}

#Lambda関数の作成
resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.11"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256 # コードの変更（ハッシュ値の変化）を検知して自動デプロイするための設定

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}
