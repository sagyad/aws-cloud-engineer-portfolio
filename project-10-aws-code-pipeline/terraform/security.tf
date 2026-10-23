# ---------------------------------------------------------------------------------------------------------------------
# Security Group — CodePipeline and CodeBuild
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "alb_sg" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Allow HTTP traffic from anywhere"
  vpc_id      = module.vpc.vpc_id

  #Allow HTTP from anywhere
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
    Name = "${local.name_prefix}-alb-sg"
  }
}

# Allows traffic from ALB SG
resource "aws_security_group" "ecs_sg" {
  name        = "${local.name_prefix}-ecs-sg"
  description = "Allow traffic from ALB security group"
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
    Name = "${local.name_prefix}-ecs-sg"
  }
}

resource "aws_security_group" "codebuild_sg" {
  name        = local.name_prefix
  description = "CodeBuild - outbound only for pulling and pushing images"
  vpc_id      = module.vpc.vpc_id

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-codebuild-sg"
  })
}