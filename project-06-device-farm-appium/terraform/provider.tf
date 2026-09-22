# --------------------------------------------------
# Provider for Project 6: Device Farm + Appium
# Defines the AWS provider and S3 backend
# State stored in S3 (versioned, public access blocked)
# S3 native lockfile for state locking
# --------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "sy-terraform-state-bucket-eu-west-2"
    key          = "project-06/terraform.tfstate"       
    region       = "eu-west-2"                          # bucket is in eu-west-2
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "us-west-2"                                  # Device Farm only in us-west-2
}