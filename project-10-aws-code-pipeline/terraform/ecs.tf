# ---------------------------------------------------------------------------------------------------------------------
# ECS — CodePipeline and CodeBuild
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_cluster" "main" {
  name = "${local.name_prefix}-ecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = local.common_tags
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  container_definitions = jsonencode([{
    name      = "app"
    image     = "${aws_ecr_repository.app.repository_url}:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]

    # Cloudwatch log group for container stdout/stderr - essentials for debugging
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = "/ecs/${local.name_prefix}"
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "app"
      }
    }
  }])
  tags = local.common_tags
}

resource "aws_ecs_service" "main" {
  name            = "${local.name_prefix}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.id
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.private_subnet_ids
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "app"
    container_port   = 80
  }

  deployment_configuration {
    strategy = "BLUE_GREEN"
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
  tags = local.common_tags
}