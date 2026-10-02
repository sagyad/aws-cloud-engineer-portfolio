# ---------------------------------------------------------------------------------------------------------------------
# Variables for  VPC Module
# ---------------------------------------------------------------------------------------------------------------------

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC "
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}
