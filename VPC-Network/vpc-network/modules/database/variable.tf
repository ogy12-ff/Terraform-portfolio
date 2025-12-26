# サービス名の変数定義
variable "service_name" {
  description = "RDSを利用するサービス名"
  type        = string
}

# 環境識別子の変数定義
variable "env" {
  description = "環境識別子"
  type        = string
}

variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs from network module"
  type        = list(string)
}
