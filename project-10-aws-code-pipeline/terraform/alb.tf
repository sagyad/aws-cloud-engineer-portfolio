# ---------------------------------------------------------------------------------------------------------------------
# ALB — CodePipeline and CodeBuild
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnet_ids

  enable_deletion_protection = false

  tags = local.common_tags
}

resource "aws_lb_target_group" "main" {
  name        = "${var.project_name}-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}