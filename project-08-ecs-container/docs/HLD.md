# HIGH LEVEL DESIGN — Project 8: ECS Container Service

| Field | Value |
|-------|-------|
| Author | Sagar Yadav |
| Date | Sep 2026 |
| Status | Draft |
| Reviewer | — |

## 1. OVERVIEW

This project deploys a containerised web application on AWS ECS (Fargate) with automated CI/CD, load balancing, and container registry management. ECS Fargate eliminates the need to manage EC2 instances for container workloads.

## 2. ARCHITECTURE
Developer → GitHub Actions → ECR (push image) → ECS Fargate (run container) ↓ Internet → ALB → ECS Service (2 tasks) → CloudWatch Logs ↓ Private Subnets (2 AZs)


## 3. SERVICES USED

| Service | Purpose |
|---------|---------|
| ECS Fargate | Run containers without managing servers |
| ECR | Store Docker images (private registry) |
| ALB | Distribute traffic across containers |
| VPC | Network isolation with public and private subnets |
| CloudWatch | Container logs and monitoring |
| IAM | Task execution roles and permissions |

## 4. DESIGN DECISIONS

| Decision | Choice | Reason |
|----------|--------|--------|
| Compute | Fargate over EC2 | No server management, pay per task, scales automatically |
| Registry | ECR over Docker Hub | Private, integrated with IAM, no rate limits |
| Networking | Private subnets for tasks | Containers not exposed directly to internet |
| Load Balancer | ALB over NLB | HTTP/HTTPS routing, path-based routing support |
| AZs | 2 Availability Zones | High availability without extra cost |

## 5. NETWORK DESIGN

| Component | CIDR / Detail |
|-----------|--------------|
| VPC | [IP_ADDRESS] |
| Public Subnet 1 (AZ-a) | [IP_ADDRESS] — ALB |
| Public Subnet 2 (AZ-b) | [IP_ADDRESS] — ALB |
| Private Subnet 1 (AZ-a) | [IP_ADDRESS] — ECS Tasks |
| Private Subnet 2 (AZ-b) | 10.0.20.0/24 — ECS Tasks |

## 6. SECURITY

| Layer | Control |
|-------|---------|
| ALB SG | Inbound: 80 (HTTP) from anywhere |
| ECS SG | Inbound: 8080 from ALB SG only |
| IAM | Task execution role with ECR pull and CloudWatch logs permissions |
| ECR | Private repository, image scanning enabled |

## 7. COST ESTIMATE (Monthly)

| Resource | Estimated Cost |
|----------|---------------|
| ECS Fargate (2 tasks, 0.25 vCPU, 0.5GB) | ~$15 |
| ALB | ~$18 |
| ECR (1GB storage) | ~$0.10 |
| CloudWatch Logs | ~$2 |
| **Total** | **~$35/month** |

## 8. RISKS

| Risk | Impact | Mitigation |
|------|--------|------------|
| Container image vulnerability | Security breach | Enable ECR image scanning |
| Task failure | Service downtime | ECS auto-restarts failed tasks, 2 AZ deployment |
| Cost overrun | Budget exceeded | Set billing alerts, use Fargate Spot for non-prod |