# Project 6: Mobile Testing with AWS Device Farm

## Architecture

GitHub Actions CI/CD --> PR: format, validate, pytest, plan --> Merge: apply
Device Farm Project (us-west-2) --> Android Device Pool --> Appium Tests --> Sample APK
S3 Backend (eu-west-2) --> terraform.tfstate

## Overview

Provisioned AWS Device Farm using Terraform and wrote Appium test scripts with pytest to automate mobile app testing on real Android devices in the cloud.

## Key Concepts

- Device Farm provides real mobile devices in the cloud for testing
- Appium is an open-source tool for automating mobile apps
- pytest runs tests independently and reports pass/fail for each
- Terraform provisions Device Farm project and device pool as IaC
- S3 remote backend stores state with native lockfile

## Tech Stack

| Tool | Purpose |
|------|---------|
| Terraform | Infrastructure as Code |
| AWS Device Farm | Cloud-based mobile testing |
| Appium | Mobile app automation |
| pytest | Test runner and assertions |
| GitHub Actions | CI/CD pipeline |
| S3 | Remote state backend |

## Project Structure

    project-06-device-farm-appium/
    ├── terraform/
    │   ├── provider.tf
    │   ├── variables.tf
    │   ├── device-farm.tf
    │   └── outputs.tf
    ├── tests/
    │   ├── conftest.py
    │   ├── test_app.py
    │   └── requirements.txt
    ├── apps/
    │   └── README.md
    └── README.md

## How to Deploy

    cd project-06-device-farm-appium/terraform
    terraform init
    terraform plan
    terraform apply

## How to Run Tests

    cd project-06-device-farm-appium/tests
    pip install -r requirements.txt
    pytest -v --tb=short

## CI/CD Pipeline

| Job | Trigger | What It Does |
|-----|---------|-------------|
| Format Check | PR | Checks Terraform formatting |
| Validate | PR | Validates Terraform syntax |
| Run Tests | PR | Runs pytest Appium test suite |
| Plan | PR | Shows infrastructure changes |
| Apply | Merge to main | Deploys infrastructure |

## Cleanup

    cd project-06-device-farm-appium/terraform
    terraform destroy

## Services Used

- **AWS Device Farm** -- real device testing in the cloud
- **S3** -- remote state storage (versioned, encrypted)
- **GitHub Actions** -- CI/CD automation
