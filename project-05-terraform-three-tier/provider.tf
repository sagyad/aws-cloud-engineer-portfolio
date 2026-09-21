terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "sy-terraform-state-bucket-eu-west-2"
    key            = "project-05/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "ddb-sy-terraform-lock"
    encrypt        = true
  }

}


provider "aws" {
  region = "eu-west-2"
}
