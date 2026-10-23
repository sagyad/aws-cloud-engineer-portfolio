#-----------------------------------------------------
# Project 10 - AWS CodePipeline - Variable.tf
# ---------------------------------------------------

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "eu-west-2"
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80

}

variable "environment" {
  description = "Environment (dev,staging,prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "github_repo" {
  description = "GitHub repository (owner/repo)"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch for pipeline source"
  type        = string
}


variable "codestar_connection_arn" {
  description = "ARN of the CodeStar connection to GitHub (create in AWS Console first)"
  type        = string
}
