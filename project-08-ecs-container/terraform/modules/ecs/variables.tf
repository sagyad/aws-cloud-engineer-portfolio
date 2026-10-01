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
}

variable "cpu" {
  description = "CPU units for ECS task"
  type        = number
}

variable "memory" {
  description = "Memory for ECS task in MB"
  type        = number
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 2
}
