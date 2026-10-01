# ---------------------------------------------------------------------------------------------------------------------
# Variables for  VPC Module
# ---------------------------------------------------------------------------------------------------------------------

variable "project_name" {
  description = "Project Name for taggings"
  type        = string
  default     = "project8-ecs"
}

variable "vpc_cidr" {
  description = "VPC "
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

