
# Project 5: Three-Tier Web Application (Terraform)

## Architecture

```text
              Internet
                 |
          +------+------+
          |     ALB     |    Public Subnets
          +------+------+
           |           |
     +-----+--+  +----+---+
     | Web EC2 |  | Web EC2|  Public (AZ-a, AZ-b)
     +-----+--+  +----+---+
           |           |
     +-----+--+  +----+---+
     | App EC2 |  | App EC2|  Private (AZ-a, AZ-b)
     +-----+--+  +----+---+
           |           |
        +--+-----------+--+
        |   RDS MySQL     |  Private Subnets
        +-----------------+
```

## Overview

Deployed a production-style three-tier web application
on AWS using Terraform. The entire infrastructure is
defined as code, version controlled, and deployed via
CI/CD pipeline. The architecture spans two Availability
Zones for high availability with chained security groups
enforcing strict tier-to-tier communication.

## AWS Services Used

- **VPC** — 4 subnets (2 public, 2 private) across 2 AZs
- **ALB** — Application Load Balancer with health checks
- **EC2** — 2 web servers (public) + 2 app servers (private)
- **RDS** — MySQL database in private subnets
- **Security Groups** — Chained SGs per tier
- **Route Tables** — Public (IGW) and private (isolated)
- **Internet Gateway** — Public subnet internet access

## Terraform Files

| File | Purpose |
|------|---------|
| `provider.tf` | AWS provider and region config |
| `variables.tf` | Variable definitions |
| `vpc.tf` | VPC, subnets, IGW, route tables |
| `security.tf` | 4 security groups (ALB, Web, App, DB) |
| `alb.tf` | ALB, target group, listener |
| `ec2.tf` | Web and app EC2 instances |
| `rds.tf` | DB subnet group and RDS MySQL |
| `outputs.tf` | ALB DNS, EC2 IPs, RDS endpoint |

## Implementation

### Deploy

```bash
terraform init
terraform plan -out=tfplan
terraform show tfplan
terraform apply tfplan
```

### Verify

```bash
terraform output alb_dns_name
# Paste ALB DNS in browser
# Refresh to see load balancing between AZ-a and AZ-b
```

### Destroy

```bash
terraform destroy
```

## Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| Chained security groups | Each tier only communicates with adjacent tier |
| Multi-AZ deployment | High availability across 2 Availability Zones |
| ALB health checks | Automatic failover to healthy instances |
| Private subnets for DB | RDS not accessible from internet |
| Saved plan workflow | Industry standard: plan, review, then apply |
| Outputs defined | Quick access to ALB DNS and endpoints |

## CI/CD Pipeline

GitHub Actions automates the Terraform workflow:

- **On PR:** `terraform fmt` > `validate` > `plan`
- **On merge:** `terraform apply`

## Built With

- **IaC:** Terraform
- **CI/CD:** GitHub Actions
- **Services:** VPC, EC2, ALB, RDS, Security Groups
- **Region:** eu-west-2 (London)
