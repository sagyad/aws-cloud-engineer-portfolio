#----------------------------------------------------
# Project 10 - AWS CodePipeline
# Environment: Production
# ---------------------------------------------------

project_name  = "project10-codepipeline"
environment   = "prod"
vpc_cidr      = "10.0.0.0/16"
azs           = ["eu-west-2a", "eu-west-2b"]
instance_type = "t3.micro"
github_repo   = "sagyad/aws-cloud-engineer-portfolio"
github_branch = "main"