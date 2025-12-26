
#EIPはNATゲートウェイに紐づくため、NATゲートウェイの数だけ作成
resource "aws_eip" "eips" {
  for_each = aws_subnet.public_subnets
  domain   = "vpc"

  tags = {
    Name  = "${var.service_name}-${var.env}-eip-${each.value.availability_zone}"
    Usage = "NAT"
  }
}

#NATゲートウェイはサブネットに紐づく
resource "aws_nat_gateway" "nat_gateway" {
  for_each      = aws_subnet.public_subnets
  allocation_id = aws_eip.eips[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = "${var.service_name}-${var.env}-nat-${each.value.availability_zone}"
  }
  depends_on = [aws_internet_gateway.igw] #IGWの作成が完了してからNATゲートウェイを作成するように依存関係を設定
}
