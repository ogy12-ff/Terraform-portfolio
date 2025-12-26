# パブリックサブネット用のルートテーブルを作成（インターネットアクセスを可能に）
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

# パブリックサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "public_route_table_associations" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


