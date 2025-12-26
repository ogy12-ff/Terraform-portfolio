#パブリックサブネット用のルートテーブル
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  # デフォルトルートをIGWに向ける設定
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.service_name}-${var.env}-public-rt"
    Env  = var.env
  }
}

#パブリックサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "public_route_table_associations" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

#プライベートサブネット用のルートテーブル
resource "aws_route_table" "private_route_table" {
  vpc_id   = aws_vpc.vpc.id
  for_each = aws_nat_gateway.nat_gateway

  # デフォルトルートをNATゲートウェイに向ける設定
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }
  tags = {
    Name = "${var.service_name}-${var.env}-${aws_subnet.public_subnets[each.key].availability_zone}-private-rt"
  }
}

#プライベートサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "private_route_table_associations" {
  for_each  = aws_subnet.private_subnets
  subnet_id = each.value.id
  route_table_id = [
    for k, v in aws_subnet.public_subnets :
    aws_route_table.private_route_table[k].id
    if v.availability_zone == each.value.availability_zone
  ][0]
}

