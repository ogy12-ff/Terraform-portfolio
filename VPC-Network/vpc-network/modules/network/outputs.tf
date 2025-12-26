output "vpc_id" {
  description = "VPCのIDです"
  value       = aws_vpc.vpc.id
}

output "vpc_name" {
  description = "VPCの名前です"
  value       = aws_vpc.vpc.tags["Name"]
}

output "public_subnet_ids" {
  value = { for s in aws_subnet.public_subnets : s.availability_zone => s.id }
}
output "private_subnet_ids" {
  # IDのリストとして出力
  value = [for s in aws_subnet.private_subnets : s.id]
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}
