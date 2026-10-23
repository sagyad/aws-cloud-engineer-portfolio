
# Project 10: CI/CD Pipeline — High Level Design (HLD)

## 1. Project Overview

Build a complete AWS-native CI/CD pipeline using CodePipeline, CodeBuild, and CodeDeploy.
Deploy a simple Python web application to EC2 instances with automated testing,
building, and deployment — triggered by a code push.

## 2. Problem Statement

In Projects 7-9 we used GitHub Actions for CI/CD. Many enterprises use AWS-native
CI/CD tools because:
- Tighter integration with AWS services (IAM, CloudWatch, S3)
- No need for external CI/CD provider
- Built-in deployment strategies (rolling, blue/green, canary)
- Everything stays within the AWS account — compliance and security

## 3. Architecture

Developer pushes code to S3 (source artifact) │ ▼ ┌─────────────────────────────────────────────────┐ │ AWS CodePipeline │ │ (Orchestrator — controls the entire flow) │ │ │ │ Stage 1: SOURCE │ │ → Pulls code from S3 bucket │ │ │ │ Stage 2: BUILD │ │ → CodeBuild runs tests (pytest) │ │ → CodeBuild packages the app │ │ │ │ Stage 3: DEPLOY │ │ → CodeDeploy deploys to EC2 instances │ │ → Uses appspec.yml for deployment steps │ └─────────────────────────────────────────────────┘ │ ▼ ┌─────────────────┐ │ EC2 Instance │ │ (Python app │ │ running on │ │ port 80) │ └─────────────────┘ │ ▼ ALB (port 80) → End users access the app


## 4. AWS Services Used

| Service | Purpose |
|---------|---------|
| CodePipeline | Orchestrates the 3 stages (Source → Build → Deploy) |
| CodeBuild | Runs pytest, packages the application |
| CodeDeploy | Deploys app to EC2 using appspec.yml |
| S3 | Stores source code artifact (zip file) and pipeline artifacts |
| EC2 | Runs the Python web application |
| ALB | Load balances traffic across EC2 instances |
| VPC | Network with public/private subnets |
| IAM | Roles for CodePipeline, CodeBuild, CodeDeploy, EC2 |
| CloudWatch | Logs from CodeBuild and deployment events |

## 5. Key Files — What Each Does

| File | Purpose | Written By |
|------|---------|------------|
| appspec.yml | Tells CodeDeploy HOW to deploy (which scripts to run, where to copy files) | DevOps |
| buildspec.yml | Tells CodeBuild HOW to build (install deps, run tests, package) | DevOps |
| scripts/install.sh | Runs on EC2 during deploy — installs Python, dependencies | DevOps |
| scripts/start.sh | Runs on EC2 during deploy — starts the application | DevOps |
| scripts/stop.sh | Runs on EC2 during deploy — stops old application | DevOps |
| app/server.py | The actual Python web application | Developer |

## 6. Deployment Flow — Step by Step

Developer zips code and uploads to S3 bucket
CodePipeline detects new file in S3 → triggers pipeline
Stage 1 (Source): Downloads code from S3
Stage 2 (Build): CodeBuild runs:
pip install dependencies
pytest runs tests
Packages app into deployment artifact
Stage 3 (Deploy): CodeDeploy:
Reads appspec.yml
Runs stop.sh (stop old app)
Copies new files to EC2
Runs install.sh (install dependencies)
Runs start.sh (start new app)
End user sees updated app via ALB URL

## 7. Terraform Resources

| Resource | Count | Purpose |
|----------|-------|---------|
| VPC + Subnets + IGW + NAT | ~8 | Network infrastructure |
| EC2 Instance | 1 | Runs the application |
| ALB + Target Group + Listener | 3 | Load balancing |
| Security Groups | 2 | ALB-SG and EC2-SG |
| S3 Bucket | 2 | Source code + pipeline artifacts |
| CodePipeline | 1 | Orchestrator |
| CodeBuild Project | 1 | Build and test |
| CodeDeploy App + Deployment Group | 2 | Deployment |
| IAM Roles | 4 | CodePipeline, CodeBuild, CodeDeploy, EC2 |
| CloudWatch Log Group | 1 | Build logs |

## 8. Folder Structure

project-10-cicd-pipeline/ ├── app/ │ └── server.py ├── deploy/ │ ├── appspec.yml │ ├── buildspec.yml │ └── scripts/ │ ├── install.sh │ ├── start.sh │ └── stop.sh ├── docs/ │ ├── HLD.md │ └── ADR-001-codepipeline-over-jenkins.md ├── k8s/ (empty — not used, EC2 deployment) ├── terraform/ │ ├── environments/ │ │ ├── dev.tfvars │ │ ├── staging.tfvars │ │ └── prod.tfvars │ ├── modules/ │ │ └── vpc/ │ │ ├── main.tf │ │ ├── variables.tf │ │ └── outputs.tf │ ├── main.tf │ ├── variables.tf │ ├── locals.tf │ ├── provider.tf │ ├── iam.tf │ ├── ec2.tf │ ├── alb.tf │ ├── security.tf │ ├── codepipeline.tf │ ├── codebuild.tf │ ├── codedeploy.tf │ ├── s3.tf │ └── outputs.tf ├── tests/ │ └── test_server.py └── README.md


## 9. Cost Estimate (Dev Environment)

| Resource | Cost/Hour |
|----------|-----------|
| EC2 t3.micro | Free tier |
| ALB | ~$0.02/hr |
| S3 | ~$0.00 (minimal) |
| CodePipeline | Free tier (1 pipeline) |
| CodeBuild | Free tier (100 mins/month) |
| CodeDeploy | Free (to EC2) |
| **Total** | **~$0.02/hr** |