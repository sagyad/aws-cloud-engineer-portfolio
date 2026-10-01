
# ---------------------------------------------------------------------------------------------------------------------
# Root main.tf — Calls VPC and ECS Modules
# This file connects all modules together and passes values between them
# ---------------------------------------------------------------------------------------------------------------------

# --- VPC Module (uses its own defaults for CIDR, AZs, subnets) ---
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr    
}

# --- ECS Module (receives values from VPC, IAM, SG, ALB) ---
module "ecs" {
  source = "./modules/ecs"

  project_name       = var.project_name
  desired_count   = var.desired_count       # passes tfvars → module
  cpu             = var.cpu
  memory          = var.memory
  container_image = var.container_image
  container_port  = var.container_port

  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_sg_id          = aws_security_group.ecs-sg.id
  target_group_arn   = aws_lb_target_group.main.arn
  execution_role_arn = aws_iam_role.execution.arn
}
