
# Project 9: EKS Kubernetes — High Level Design (HLD)

## 1. Project Overview

Deploy a Python Flask web application to AWS EKS (Elastic Kubernetes Service)
using a fully automated CI/CD pipeline with Terraform for infrastructure
and Kubernetes manifests for application deployment.

## 2. Business Requirement

- Host a containerised web application on Kubernetes
- Auto-scale based on traffic
- Zero-downtime deployments
- Accessible via a public URL through an Application Load Balancer

## 3. Architecture Diagram



## 4. AWS Services Used

| Service | Purpose |
|---------|---------|
| EKS | Kubernetes cluster — runs the application Pods |
| ECR | Docker image registry — stores our container image |
| VPC | Network — 2 public subnets (ALB), 2 private subnets (EKS nodes) |
| ALB | Load balancer — routes internet traffic to Pods |
| IAM | Roles — EKS cluster role, node group role, ECR access |
| S3 | Terraform state file storage |
| DynamoDB | Terraform state locking (via S3 native lockfile) |
| NAT Gateway | Allows private subnet nodes to pull images from ECR |

## 5. Component Breakdown

### 5a. Networking (VPC Module — reused from Project 8)
- 1 VPC with CIDR [IP_ADDRESS]
- 2 Public subnets (10.0.1.0/24, 10.0.2.0/24) — for ALB
- 2 Private subnets (10.0.10.0/24, [IP_ADDRESS]) — for EKS nodes
- 1 Internet Gateway — public subnet internet access
- 1 NAT Gateway — private subnet outbound access (ECR image pull)
- Route tables for public and private subnets

### 5b. EKS Cluster (EKS Module — new)
- EKS Cluster with Kubernetes version 1.31
- Managed Node Group with 2 nodes (t3.medium)
- Cluster Security Group — control plane communication
- Node Security Group — node-to-node and node-to-control-plane

### 5c. Container Registry (ECR)
- 1 ECR repository to store the Docker image
- Image tag: based on git commit SHA
- Lifecycle policy: keep last 5 images

### 5d. Application Load Balancer
- Public-facing ALB in public subnets
- Target group pointing to EKS node port
- Health check on /health endpoint
- Listener on port 80

### 5e. Application (Python Flask)
- Simple web app with 3 endpoints:
  - / → "Hello from EKS!"
  - /health → health check for ALB
  - /info → shows pod name, node, version
- Containerised with Docker
- Deployed via Kubernetes manifests (Deployment + Service)

### 5f. Kubernetes Manifests (k8s/ folder)
- deployment.yaml — 2 replicas of the Flask app
- service.yaml — NodePort service exposing port 5000
- (ALB routes traffic to NodePort)

## 6. CI/CD Pipeline (GitHub Actions)

| Job | Trigger | What It Does |
|-----|---------|--------------|
| Lint | PR to main | Checks Terraform format, Python lint |
| Build | PR to main | Builds Docker image, runs tests |
| Terraform Plan | PR to main | Shows what infrastructure will change |
| Terraform Apply | Push to main | Creates/updates infrastructure |
| Deploy App | Push to main (after Apply) | Pushes image to ECR, deploys to EKS |

## 7. IAM Roles Required

| Role | Trust | Policies | Purpose |
|------|-------|----------|---------|
| EKS Cluster Role | eks.amazonaws.com | AmazonEKSClusterPolicy | EKS control plane |
| EKS Node Role | ec2.amazonaws.com | AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, AmazonEC2ContainerRegistryReadOnly | Worker nodes |

## 8. Security

- EKS nodes in PRIVATE subnets (not directly accessible)
- ALB in PUBLIC subnets (only entry point)
- Security groups restrict traffic:
  - ALB SG: inbound 80 from internet
  - EKS SG: inbound from ALB SG only
- IAM roles follow least privilege
- ECR images scanned on push

## 9. Cost Estimate (Dev Environment)

| Resource | Cost/Hour | Monthly (Dev) |
|----------|-----------|---------------|
| EKS Cluster | $0.10/hr | ~$73 |
| 2x t3.medium nodes | $0.0416/hr each | ~$60 |
| NAT Gateway | $0.045/hr | ~$33 |
| ALB | $0.0225/hr | ~$16 |
| **Total** | | **~$182/month** |

**IMPORTANT: Destroy after testing to avoid charges!**

## 10. Environments

| Environment | Nodes | Instance Type | Replicas |
|-------------|-------|---------------|----------|
| Dev | 2 | t3.medium | 2 |
| Staging | 2 | t3.medium | 2 |
| Prod | 3 | t3.large | 3 |

## 11. File Structure
project-09-eks-kubernetes/ ├── app/ │ ├── server.py ← Flask application │ └── Dockerfile ← Container build instructions ├── docs/ │ ├── HLD.md ← This document │ └── ADR-001-eks-over-ecs.md ← Why EKS not ECS ├── k8s/ │ ├── deployment.yaml ← Kubernetes Deployment manifest │ └── service.yaml ← Kubernetes Service manifest ├── terraform/ │ ├── environments/ │ │ ├── dev.tfvars │ │ ├── staging.tfvars │ │ └── prod.tfvars │ ├── modules/ │ │ ├── vpc/ ← Reused from Project 8 │ │ │ ├── main.tf │ │ │ ├── variables.tf │ │ │ └── outputs.tf │ │ └── eks/ ← NEW module │ │ ├── main.tf │ │ ├── variables.tf │ │ └── outputs.tf │ ├── locals.tf │ ├── variables.tf │ ├── provider.tf │ ├── ecr.tf │ ├── iam.tf │ ├── alb.tf │ ├── security.tf │ ├── main.tf │ └── outputs.tf └── README.md


## 12. Deployment Flow (What Happens When You Push Code)
Developer pushes to feature branch
Pipeline: lint + build + terraform plan (on PR)
Reviewer approves PR
Merge to main triggers: a. Terraform Apply → creates VPC, EKS, ECR, ALB, IAM b. Docker Build → builds image, pushes to ECR c. kubectl apply → deploys app Pods to EKS cluster
ALB routes traffic → Pods serve the app
User visits ALB URL → sees "Hello from EKS!"


``
