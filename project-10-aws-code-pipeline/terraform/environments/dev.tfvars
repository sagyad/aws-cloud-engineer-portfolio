#----------------------------------------------------
# Project 10 - AWS CodePipeline
# Environment: Development
# ---------------------------------------------------

project_name            = "project10-codepipeline"
environment             = "dev"
vpc_cidr                = "10.0.0.0/16"
azs                     = ["eu-west-2a", "eu-west-2b"]
codestar_connection_arn = "arn:aws:codeconnections:eu-west-2:527595306112:connection/31d8e8e2-28b0-48d2-a242-b0a2f2d8578b"
github_repo             = "sagyad/aws-cloud-engineer-portfolio"
github_branch           = "feature/project-10-aws-code-pipeline"