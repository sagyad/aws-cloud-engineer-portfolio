# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "project_name" {
  description = "Project Name for resource taggings"
  type        = string
  default     = "project-08-ecs"
}
variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-west-2"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
  default     = "project8-ecs"
}