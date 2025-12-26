# 外部モジュール（s3/main.tf）の出力をデータソースとして参照
data "terraform_remote_state" "s3_state" {
  backend = "local" # バックエンドはlocalと仮定
  config = {
    path = "../s3/terraform.tfstate" # s3ディレクトリのtfstateファイルを指定
  }
}

# CloudFrontモジュールの呼び出し
module "cdn" {
  source = "../modules/cloudfront"

  # S3ディレクトリが出力した値を参照し、CloudFrontモジュールへ渡す
  s3_website_endpoint = data.terraform_remote_state.s3_state.outputs.s3_website_endpoint
  s3_origin_id        = data.terraform_remote_state.s3_state.outputs.s3_origin_id
  index_documents     = data.terraform_remote_state.s3_state.outputs.index_document_name
}
