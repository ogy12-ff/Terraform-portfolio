# パブリックサブネット（インターネットアクセス可能なサブネット）を作成
resource "aws_subnet" "public_subnet" {
  cidr_block              = var.subnet_cidrs.public[0]
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.service_name}-${var.env}-public-subnet"
    Env  = var.env
  }
}

# プライベートサブネット（インターネットアクセス不可のサブネット）を作成
resource "aws_subnet" "private_subnet" {
  cidr_block        = var.subnet_cidrs.private[0]
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.service_name}-${var.env}-private-subnet"
    Env  = var.env
  }
}
