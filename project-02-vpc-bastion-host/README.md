# Project 2: Custom VPC Network + Bastion Host 🔒

## Architecture
INTERNET │ ↓ SSH (my IP only) ┌───────────── VPC (10.0.0.0/16) ──────────────────────┐ │ │ │ ┌── Public Subnet (10.0.1.0/24) ──┐ │ │ │ Bastion Host (t3.micro) │ │ │ │ SSH from my IP → Port 22 │ │ │ └──────────────┬───────────────────┘ │ │ │ SSH (bastion SG only) │ │ ┌── Private Subnet (10.0.3.0/24) ──┐ │ │ │ Private Server (t3.micro) │ │ │ │ No public IP, no internet │ │ │ └───────────────────────────────────┘ │ │ │ │ (x2 AZs for high availability — eu-west-2a + 2b) │ └────────────────────────────────────────────────────────┘


## What I Built
A production-style VPC with public and private subnets across 2 Availability Zones, secured with a bastion host pattern for SSH access to private resources.

## AWS Services Used
| Service | Purpose |
|---------|---------|
| **VPC** | Isolated private network (10.0.0.0/16) |
| **Subnets** | 2 public + 2 private across 2 AZs |
| **Internet Gateway** | Internet access for public subnets |
| **Route Tables** | Public RT → IGW, Private RT → isolated |
| **Security Groups** | Bastion: SSH from my IP; Private: SSH from bastion SG |
| **EC2** | Bastion host + private server (t3.micro) |
| **Key Pair** | RSA key for SSH authentication |

## Key Concepts Learned
- VPC design with public/private subnet separation
- CIDR notation (/32 = 1 IP, /24 = 256, /16 = 65K, /0 = all)
- Internet Gateway vs NAT Gateway (two-way vs one-way)
- Route tables — what makes a subnet public or private
- Security Groups — SG-to-SG referencing pattern
- Bastion host pattern vs modern Session Manager
- SSH hop: laptop → bastion → private server
- chmod 400 — file permissions for SSH keys
- Defence in depth — multiple security layers

## Scripts
| File | Purpose |
|------|---------|
| 01-create-vpc.sh | Create VPC with DNS hostnames |
| 02-create-subnets.sh | 4 subnets across 2 AZs |
| 03-create-igw.sh | Internet Gateway + attach to VPC |
| 04-create-route-tables.sh | Public/Private RTs + associations |
| 05-create-security-groups.sh | Bastion + Private SGs with rules |
| 06-launch-instances.sh | EC2 bastion + private server |
| 07-ssh-hop-test.sh | SSH hop test commands |
| 99-cleanup.sh | Terminate instances |

## Cost
💰 **$0** — EC2 t3.micro within free tier, VPC/subnets/SGs are always free

## Part of
[AWS Cloud Engineer Portfolio](https://github.com/sagyad/aws-cloud-engineer-portfolio) — 12 end-to-end AWS projects from foundation to production.
