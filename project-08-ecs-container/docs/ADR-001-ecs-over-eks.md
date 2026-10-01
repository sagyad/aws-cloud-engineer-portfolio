# ADR-001: ECS Fargate Over EKS for Container Deployment

| Field | Value |
|-------|-------|
| Status | Accepted |
| Date | Sep 2026 |
| Decision Maker | Sagar Yadav |

## CONTEXT

This project requires deploying a containerised web application on AWS. Two primary options exist: ECS (Elastic Container Service) and EKS (Elastic Kubernetes Service).

## OPTIONS CONSIDERED

| Option | Pros | Cons |
|--------|------|------|
| ECS Fargate | No cluster management, simple task definitions, lower cost, native AWS integration | AWS-only, less portable |
| EKS | Industry standard (Kubernetes), multi-cloud portable, large ecosystem | Complex setup, higher cost ($0.10/hr for control plane), requires Kubernetes knowledge |
| EC2 with Docker | Full control | Manual scaling, patching, no orchestration |

## DECISION

ECS Fargate. This project focuses on learning container deployment fundamentals. ECS provides a simpler path to production-ready containers without Kubernetes complexity. Project 9 covers EKS for Kubernetes-specific skills.

## CONSEQUENCES

- Positive: Faster deployment, lower cost, simpler operations
- Negative: Not portable to other cloud providers
- Accepted: Team gains ECS experience before advancing to EKS in Project 9