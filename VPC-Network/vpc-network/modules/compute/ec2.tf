resource "aws_instance" "ec2_instance" {
  for_each = var.public_subnet_ids

  instance_type = "t2.micro"
  ami           = "ami-0d52744d6551d851e" #Amazon Linux 2023

  subnet_id = each.value

  tags = {
    Name = "${var.service_name}-${var.env}-web-${each.key}"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each = aws_instance.ec2_instance

  target_group_arn = var.target_group_arn
  target_id        = each.value.id
  port             = 80
}
