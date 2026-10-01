# ---------------------------------------------------------------------------------------------------------------------
# Variables for ECS module
# ---------------------------------------------------------------------------------------------------------------------
variable "project_name" {
  description = "Project Name for resource naming"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs for ECS Tasks"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}
variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM Execution role ARN for ECS"
  type        = string
}

variable "desired_count" {
  description = "Desired Count"
  type        = number
  default     = 2
}
