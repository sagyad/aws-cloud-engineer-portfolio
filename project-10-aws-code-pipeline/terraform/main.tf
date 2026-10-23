# ---------------------------------------------------------------------------------------------------------------------
# Root main.tf — Module Calls and Shared Resources
# ---------------------------------------------------------------------------------------------------------------------


module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment # Required by your VPC module
  vpc_cidr     = var.vpc_cidr
  azs          = var.azs
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${local.name_prefix}"
  retention_in_days = 30

  tags = local.common_tags
}