################################################################################
# Application Load Balancer
################################################################################

resource "aws_lb" "main" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = local.load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2] // If Multiple Public Subnets [for subnet in aws_subnet.public :subnet.id]

  enable_deletion_protection = false

  #   access_logs {
  #     bucket  = "y-terraform-state-bucket-eu-west-2"
  #     prefix  = "project-07/alb-logs"
  #     enabled = true
  #   }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}"
  })
}

resource "aws_lb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.main.id
  port             = 80
}

resource "aws_lb_target_group" "main" {
  name        = "${local.name_prefix}-lb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
