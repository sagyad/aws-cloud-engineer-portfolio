# --------------------------------------------------
# Variables for Project 7: Monitoring and Alarms
# Defines input variables used across all .tf files
# 1. EC2 (instance_type and ami)
# 2. Alarms (cpu_threshold,alarm_email)
# 3. VPC (cidr,public_subnets,private_subnets) (additional components SG,NATGateway,RouteTable,Route)
# 4. SNS (email_address)
# 5. CloudTrail (s3_bucket_for_logs)
# 6. Dashboard (dashboard_name)
# --------------------------------------------------

variable "project_name" {
  description = "Project name prefix for all resources"
  type        = string
  default     = "project7-monitoring-alerts"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

# EC2 Variable
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}


#VPC Variable
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}


variable "cpu_threshold" {
  description = "CPU Alarm threshold percentage"
  type        = number
  default     = 80
}

variable "alb_5xx_threshold" {
  description = "ALB 5xx error count threshold"
  type        = number
  default     = 10
}

#SNS
variable "alarm_email" {
  description = "Email address for alarm notification"
  type        = string
}

variable "cloudtrail_bucket" {
  description = "S3 bucket name for CloudTrail logs"
  type        = string
  default =""
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = ""
}
