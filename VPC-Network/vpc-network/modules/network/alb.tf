# ロードバランサーの作成
resource "aws_lb" "load_balancer" {
  name               = "${var.service_name}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for s in aws_subnet.public_subnets : s.id]

  tags = {
    Name = "${var.service_name}-${var.env}-alb"
  }
}

# ターゲットグループの作成
resource "aws_lb_target_group" "target_group" {
  name     = "${var.service_name}-${var.env}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# リスナー
resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
