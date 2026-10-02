
# Project 9: EKS Kubernetes — Container Orchestration

## Architecture



## Overview

End-to-end Kubernetes deployment on AWS EKS using Terraform modules for infrastructure and GitHub Actions for CI/CD. Includes Docker containerisation, ECR image registry, and Kubernetes manifests for deployment and service exposure.

## Key Services

| Service | Purpose |
|---------|---------|
| EKS | Managed Kubernetes cluster |
| ECR | Docker image registry |
| VPC | Network isolation (public + private subnets) |
| IAM | Cluster, node group, and pod execution roles |
| S3 + DynamoDB | Remote state backend with locking |

## Project Structure



## ECS vs EKS — Why EKS?

| Factor | ECS | EKS |
|--------|-----|-----|
| Portability | AWS only | Any cloud provider |
| Control | Limited | Full Kubernetes API |
| Industry adoption | Moderate | Industry standard |
| Learning curve | Easier | Steeper but more valuable |

## CI/CD Pipeline

| Job | Trigger | What It Does |
|-----|---------|--------------|
| Lint | PR | Terraform format check |
| Build & Test | PR | Docker build + Python tests |
| Terraform Plan | PR | Preview infrastructure changes |
| Deploy | Push to main | Apply Terraform + Build image + Deploy to EKS |

## Environments

| Environment | Nodes | Instance | Purpose |
|-------------|-------|----------|---------|
| Dev | 1-2 | t3.medium | Development and testing |
| Staging | 2-3 | t3.medium | Pre-production validation |
| Prod | 3-5 | t3.large | Live production workload |

## Key Concepts Demonstrated

- **Terraform Modules** — Reusable VPC and EKS modules
- **Environment Separation** — dev/staging/prod via tfvars
- **Remote State** — S3 backend with native locking
- **Docker Containerisation** — Python app packaged as Docker image
- **Kubernetes Deployment** — Pods, replicas, LoadBalancer service
- **IAM Best Practices** — Separate roles for cluster, nodes, and pods
- **CI/CD Pipeline** — Automated lint, build, test, plan, deploy

## Commands Reference

```bash
# Infrastructure
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
terraform destroy -var-file=environments/dev.tfvars

# Kubernetes
kubectl get nodes
kubectl get pods
kubectl get services
kubectl apply -f k8s/

