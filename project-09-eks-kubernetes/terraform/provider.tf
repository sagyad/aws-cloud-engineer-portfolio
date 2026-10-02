# --------------------------------------------------
# Provider — Project 9: EKS Kubernetes
# AWS provider and S3 remote backend for state management
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
    key          = "project-09/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "eu-west-2"
}