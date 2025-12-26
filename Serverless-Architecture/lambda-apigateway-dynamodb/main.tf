module "lambda" {
  source = "./modules/compute"

  dynamodb_table_name = module.dynamodb.table_name
}

module "dynamodb" {
  source = "./modules/database"
}

module "apigateway" {
  source = "./modules/api"

  lambda_function_arn = module.lambda.lambda_function_arn
}
