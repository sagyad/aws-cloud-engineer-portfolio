#----------------------------------------------------
# Project 10 - AWS CodePipeline
# Environment: Staging
# ---------------------------------------------------

project_name  = "project10-codepipeline"
environment   = "staging"
vpc_cidr      = "10.0.0.0/16"
instance_type = "t3.micro"
azs           = ["eu-west-2a", "eu-west-2b"]
github_repo   = "sagyad/aws-cloud-engineer-portfolio"
github_branch = "staging"