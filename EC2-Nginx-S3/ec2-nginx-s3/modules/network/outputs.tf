# VPCのIDを出力
output "vpc_id" {
  description = "VPCのIDです"
  value       = aws_vpc.vpc.id
}

# VPCの名前を出力
output "vpc_name" {
  description = "VPCの名前です"
  value       = aws_vpc.vpc.tags["Name"]
}

# パブリックサブネットのIDを出力
output "public_subnet_ids" {
  value = aws_subnet.public_subnet.id
}

# プライベートサブネットのIDを出力
output "private_subnet_ids" {
  value = [aws_subnet.private_subnet.id]
}

# セキュリティグループのIDを出力
output "security_group_id" {
  description = "Webサーバー用セキュリティグループのID"
  value       = aws_security_group.web_sg.id
}
