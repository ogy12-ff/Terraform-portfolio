# 1. API本体（玄関）
resource "aws_apigatewayv2_api" "main" {
  name          = "serverless-api"
  protocol_type = "HTTP"
}

# 2. 公開ステージ（公開場所）
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default" # URLの末尾に何もつかないデフォルト設定
  auto_deploy = true
}

# 3. 統合（Lambdaとの紐付け）
resource "aws_apigatewayv2_integration" "lambda" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_function_arn # Lambdaモジュールから渡してもらう
}

# 4. ルート（どのパスでアクセスするか）
resource "aws_apigatewayv2_route" "any" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}" # どんなパスで来てもLambdaに投げる設定
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# Lambda関数へのアクセス許可
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
