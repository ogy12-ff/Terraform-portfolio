# RDSを配置する場所（プライベートサブネット）をグループ化
resource "aws_db_subnet_group" "main" {
  name       = "${var.service_name}-${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.service_name}-${var.env}-db-subnet-group"
  }
}

# RDSインスタンス本体
resource "aws_db_instance" "main" {
  identifier        = "${var.service_name}-${var.env}-db-multi-az"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro" # 無料枠対象
  allocated_storage = 20            # 最小20GB

  db_name  = "mydb"
  username = "admin"
  # パスワードは本来 secrets manager 等を使うのが理想ですが、まずは直書きで進めます
  password = "Password1234"

  db_subnet_group_name = aws_db_subnet_group.main.name

  # セキュリティ向上のための設定
  publicly_accessible = false
  multi_az            = true # Active-Standbyにするならtrue
  skip_final_snapshot = true # 削除をスムーズにする設定

  # 【重要】後で作成するセキュリティグループをここに紐付けます
  # vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "${var.service_name}-${var.env}-db"
  }
}
