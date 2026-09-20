# =============================================
# ALB.TF — Application Load Balancer
# =============================================
#   1. ALB        — the load balancer itself, sits in public subnets
#   2. Target Group — the group of servers ALB sends traffic to + health checks
#   3. Listener    — the rule: "on port 80, forward to target group"


resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  tags = {
    Name = "${var.project_name}-alb"
  }
}

# =============================================
# Target Group — Where ALB sends traffic
# =============================================
# Think of this as a "group of servers" the ALB forwards requests to
# The ALB checks if they're healthy before sending traffic
resource "aws_lb_target_group" "web_tg" {
  name     = "${var.project_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  # Health Check - ALB Pings
  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "${var.project_name}-web-tg"
  }
}


# =============================================
# ALB Listener — Listens on port 80 and forwards to Target Group
# =============================================
# Think of it as: "When someone hits port 80 → send them to the web servers"
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }

}