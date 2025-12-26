# VPC（仮想プライベートクラウド）を作成
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16" #VPCのCIDRブロックを指定
  enable_dns_hostnames = true
  tags = {
    Name = "${var.service_name}-${var.env}-vpc"
    Env  = var.env
  }
}
