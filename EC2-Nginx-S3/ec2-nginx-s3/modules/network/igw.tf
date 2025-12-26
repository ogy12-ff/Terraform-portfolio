# インターネットゲートウェイ（IGW）を作成してVPCをインターネットに接続
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id #IGWはVPCに紐づくため、VPCのIDを指定
  tags = {
    Name  = "${var.service_name}-${var.env}-igw"
    Env   = var.env
    VpcId = aws_vpc.vpc.id
  }
}
