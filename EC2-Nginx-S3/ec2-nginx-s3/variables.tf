# サービス名（リソース名のプレフィックス）
variable "service_name" {
  type        = string
  description = "VPCを利用するサービス名"
  default     = "nginx-web-server"
}

# 環境識別子（dev, stg, prodなど）
variable "env" {
  type        = string
  description = "環境識別子(dev,stg,prod)"
  default     = "dev"
}
