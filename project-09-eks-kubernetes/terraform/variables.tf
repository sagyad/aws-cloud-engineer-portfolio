# --------------------------------------------------
# Root Variables — Project 9: EKS Kubernetes
# Declares all variables. Values come from environments/*.tfvars
# --------------------------------------------------

variable "project_name" {
  description = "Project name used for resourcing naming"
  type        = string
}

variable "environment" {
  description = "Environment name(dev, stagging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}


variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
}

variable "desired_nodes" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "min_nodes" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_nodes" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "app_port" {
  description = "Port for the application"
  type        = number
}