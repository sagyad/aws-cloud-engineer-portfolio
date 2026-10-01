# ---------------------------------------------------------------------------------------------------------------------
# Security Group
# 1.SG-ALB, 2. SG-EC2
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Allows HTTP (port 80) from anywhere
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP traffic from anywhere"
  vpc_id      = module.vpc.vpc_id

  # Allow HTTP from anyhwere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# Allows traffic from ALB SG
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "ecs-sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "Allow traffic from ALB Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow traffic from ALB port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }


  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}