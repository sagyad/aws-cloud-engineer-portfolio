# --------------------------------------------------
# Locals: Project 7 Monitoring and Alerts
# Calculated values reused across all resource files
# --------------------------------------------------

locals {
  # Naming prefix - used in every resources name

  name_prefix = "${var.project_name}-${var.aws_region}"

  # Common Tags  - user for every resource
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  # Subnets CIDR - caculated using cidrsubnet 
  public_subnet_1_cidr  = cidrsubnet(var.vpc_cidr, 8, 1)
  public_subnet_2_cidr = cidrsubnet(var.vpc_cidr,8, 2)
  private_subnet_cidr = cidrsubnet(var.vpc_cidr, 8, 3)

  load_balancer_type = "application"
  storage_bucket     = "sy-terraform-state-bucket-eu-west-2"

  #CloudWatch alarm config - grouped
  alarms = {
    cpu = {
      name         = "${local.name_prefix}-high-cpu"
      metric       = "CPUUtilization"
      threshold    = var.cpu_threshold
      period       = 300
      eval_periods = 2
    }

    alb_5xx = {
      name         = "${local.name_prefix}-alb-5xx"
      metric       = "HTTPCode_ELB_5xx_Count"
      threshold    = var.alb_5xx_threshold
      period       = 300
      eval_periods = 1
    }
  }
} 