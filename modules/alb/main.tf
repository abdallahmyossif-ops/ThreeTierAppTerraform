#External Load Balancer
resource "aws_lb" "external_alb" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  internal           = false # 👈 public
  subnets = [
    var.public_sub_1_id,
    var.public_sub_2_id
  ]

  security_groups = [var.external_lb_sg_id]
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
  }
}
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
#----------------------------------------------------------
#Internal Load Balancer
resource "aws_lb" "internal_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  internal           = true # 👈 private
  subnets = [
    var.private_sub_1a_id,
    var.private_sub_2a_id
  ]

  security_groups = [var.internal_lb_sg_id]
}
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/health"
  }
}
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
