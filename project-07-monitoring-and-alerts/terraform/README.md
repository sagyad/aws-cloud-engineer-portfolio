# Project 7: Monitoring & Alerting with CloudWatch

## Architecture
EC2 Instance ──→ CloudWatch Metrics ──→ CloudWatch Alarms ──→ SNS ──→ Email │
└──→ ALB ──→ CloudWatch Metrics ──→ CloudWatch Alarms ──→ SNS ──→ Email

CloudWatch Dashboard (CPU + ALB 5xx + Text Widget)


## Overview

Production-grade monitoring stack using CloudWatch, SNS, and custom dashboards. Monitors EC2 CPU utilisation and ALB 5xx errors with automated email alerting.

## Services Used

- **CloudWatch** — metrics, alarms, dashboards
- **SNS** — notification topic and email subscription
- **EC2** — web server being monitored
- **ALB** — application load balancer with health checks
- **VPC** — networking with 2 public subnets across AZs
- **S3** — remote Terraform state backend
- **IAM** — security groups for ALB and EC2

## What I Built

- VPC with 2 public subnets in different AZs
- EC2 instance running Ubuntu with CloudWatch monitoring
- Application Load Balancer with target group and health checks
- CloudWatch CPU alarm (threshold-based, alerts via SNS)
- CloudWatch ALB 5xx alarm (error rate monitoring)
- CloudWatch dashboard with CPU, ALB, and text widgets
- SNS topic with email subscription for alarm notifications
- Terraform locals for reusable configuration values
- Remote state stored in S3 with native lockfile

## Project Structure

project-07-monitoring-and-alerts/ ├── terraform/ │ ├── provider.tf # AWS provider + S3 backend │ ├── variables.tf # input variables │ ├── terraform.tfvars # actual values (git-ignored) │ ├── locals.tf # reusable config, tags, alarm thresholds │ ├── data.tf # AMI lookup │ ├── vpc.tf # VPC, subnets, route tables │ ├── security.tf # security groups (ALB + EC2) │ ├── ec2.tf # web server instance │ ├── alb.tf # ALB, target group, listener │ ├── sns.tf # notification topic + subscription │ ├── alarm.tf # CloudWatch alarms (CPU + ALB) │ ├── dashboard.tf # CloudWatch dashboard │ └── outputs.tf # resource outputs └── README.md


## Key Concepts Demonstrated

- **Monitoring as Code** — dashboards and alarms defined in Terraform
- **Threshold-based alerting** — CPU > 80%, ALB 5xx > 10
- **Multi-layer monitoring** — infrastructure (EC2) + application (ALB)
- **SNS fan-out** — single topic, multiple notification targets
- **Terraform locals** — DRY configuration with reusable values
- **Remote state** — S3 backend with native lockfile

## Deploy

```bash
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply tfplan

Verify
terraform output alb_dns_name        # access the ALB
terraform output cpu_alarm_arn       # check alarm ARN
terraform output dashboard_arn       # view dashboard in console

Cleanup
terraform destroy

CI/CD
Pipeline: .github/workflows/project-07-monitoring-and-alerts.yml

On PR — format, validate, test, plan
On merge to main — apply
Certification
AWS Solutions Architect Associate (SAA-C03) — Monitoring and Logging domain