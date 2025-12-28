variable "service_name" {
  description = "VPCを利用するサービス名"
  type        = string
}

variable "env" {
  description = "環境識別子"
  type        = string
}

variable "instance_id" {
  description = "EC2インスタンスID"
  type        = string
}
