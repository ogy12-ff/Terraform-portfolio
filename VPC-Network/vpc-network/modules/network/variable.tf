# VPC CIDRブロックの変数定義
variable "vpc_cidr_block" {
  description = "VPCに割り当てるCIDRブロックを記述"
  type        = string
  default     = "10.0.0.0/16"
}

# サービス名の変数定義
variable "service_name" {
  description = "VPCを利用するサービス名"
  type        = string
}

# 環境識別子の変数定義
variable "env" {
  description = "環境識別子"
  type        = string
}

# サブネットCIDRの変数定義
variable "subnet_cidrs" {
  description = "サブネットごとのCIDR指定"
  type = object({
    public  = list(string)
    private = list(string)
  })
}
