
# ADR-001: EKS Over ECS for Container Orchestration

## Status
Accepted

## Context
We need a container orchestration platform for deploying microservices.
Project 8 used ECS with Fargate. This project requires Kubernetes-native
features and multi-cloud portability.

## Decision
Use Amazon EKS (Elastic Kubernetes Service) instead of ECS.

## Reasons

| Factor | ECS | EKS |
|--------|-----|-----|
| Portability | AWS only | Any cloud (GCP, Azure, on-prem) |
| Industry adoption | Limited | 80%+ of enterprises use Kubernetes |
| Ecosystem | AWS native tools only | Helm, ArgoCD, Prometheus, Grafana |
| Learning curve | Lower | Higher — but industry standard |
| Hiring market | Fewer roles | Most DevOps roles require K8s |

## Consequences
- Higher initial setup complexity
- EKS cluster costs $0.10/hr ($73/month)
- Team needs Kubernetes knowledge
- Portable skills — not locked to AWS

## Alternatives Considered
- ECS Fargate (used in Project 8 — simpler but AWS-locked)
- Self-managed Kubernetes on EC2 (too much operational overhead)

