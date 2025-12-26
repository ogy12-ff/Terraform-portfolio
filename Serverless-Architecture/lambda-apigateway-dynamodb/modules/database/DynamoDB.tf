resource "aws_dynamodb_table" "dynamodb" {
  name         = "my_dynamodb_table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "filename"

  attribute {
    name = "filename"
    type = "S"
  }

  tags = {
    Name        = "my_dynamodb_table"
    Environment = "Dev"
  }
}

output "table_name" {
  value = aws_dynamodb_table.dynamodb.name
}
