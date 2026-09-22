# --------------------------------------------------
# Variables for Project 6: Device Farm + Appium
# Defines input variables used across all .tf files
# --------------------------------------------------

variable "project_name" {
    description = "Project name prefix for all resources"
    type = string
    default = "project6-device-farm"
}