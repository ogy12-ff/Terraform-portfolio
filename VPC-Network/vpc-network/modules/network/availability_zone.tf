data "aws_availability_zones" "availability_zone" {
  state = "available"

  #すでにobsoleteになっているap-northeast-1bを除外
  exclude_names = [
    "ap-northeats-1b"
  ]
}

# アベイラビリティソーンの数をローカル変数に設定
locals {
  number_of_availability_zones = length( #AZの数を取得
    data.aws_availability_zones.availability_zone.names
  )
}
