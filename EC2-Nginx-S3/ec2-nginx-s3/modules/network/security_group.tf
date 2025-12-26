# セキュリティグループを作成（HTTPとSSHのアクセスを許可）
resource "aws_security_group" "web_sg" {
  name_prefix = "${var.service_name}-${var.env}-web-sg"
  vpc_id      = aws_vpc.vpc.id

  # HTTPアクセスを許可
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSHアクセスを許可（本番では制限推奨）
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 本番環境では制限を推奨
  }

  # すべてのアウトバウンドトラフィックを許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.env}-web-sg"
    Env  = var.env
  }
}
