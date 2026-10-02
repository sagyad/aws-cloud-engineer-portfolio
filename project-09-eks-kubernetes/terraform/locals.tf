# --------------------------------------------------
# Locals — Project 9: EKS Kubernetes
# Common tags and naming used by all resources
# --------------------------------------------------


locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    environment = var.environment
    ManagedBy   = "Terraform"
  }
}