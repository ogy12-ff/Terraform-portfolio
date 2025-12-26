resource "aws_subnet" "public_subnets" {
  for_each   = toset(var.subnet_cidrs.public) # パブリックサブネットのCIDRブロックの数だけ作成
  cidr_block = each.value                     #パブリックサブネットのCIDRブロックを指定
  vpc_id     = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zone.names[
    index(var.subnet_cidrs.public, each.value) % local.number_of_availability_zones # AZの数で割った余りをインデックスに使用
  ]
}

resource "aws_subnet" "private_subnets" {
  for_each   = toset(var.subnet_cidrs.private) # プライベートサブネットのCIDRブロックの数だけ作成
  cidr_block = each.value                      # プライベートサブネットのCIDRブロックを指定                     
  vpc_id     = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zone.names[
    index(var.subnet_cidrs.private, each.value) % local.number_of_availability_zones # AZの数で割った余りをインデックスに使用
  ]
}
