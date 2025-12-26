# サービス名の変数定義
variable "service_name" {
  description = "サービス名"
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

variable "public_subnet_id" {
  description = "パブリックサブネットのID"
  type        = string
}

variable "security_group_id" {
  description = "セキュリティグループのID"
  type        = string
}

variable "bucket_name" {
  description = "S3バケット名"
  type        = string
}

variable "bucket_arn" {
  description = "S3バケットのARN"
  type        = string
}
