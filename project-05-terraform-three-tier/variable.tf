variable "project_name" {
  description = "Project Name for tagging"
  default     = "project5-terraform"
}
variable "aws_region" {
  description = "Region to deploy the resources"
  default     = "eu-west-2"
}
variable "vpc_cidr" {
  description = "CIDR Block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR Block for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR Block for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR Block for private subnet 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR Block for private subnet 2"
  default     = "10.0.4.0/24"
}

variable "db_password" {
  description = "Database admin password"
  sensitive   = true
  default     = "makesure1234"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}
