resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block #VPCのCIDRブロックを指定
  tags = {
    Name = "${var.service_name}-${var.env}-vpc" #サンプルコードなのでVPCは1つしか作らない
    Env  = var.env
  }
}
