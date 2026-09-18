# Project 4: Three-Tier Web Application (CloudFormation)

## Architecture
Browser → ALB → EC2 (Auto Scaling) → RDS MySQL ↓ ↓ ↓ Public Subnet Private Subnet Private Subnet ↓ NAT Gateway


## AWS Services Used
- **CloudFormation** — Infrastructure as Code (single YAML deploys everything)
- **VPC** — Custom network with public/private subnets
- **ALB** — Application Load Balancer for traffic distribution
- **EC2 + Auto Scaling** — Web servers (min 1, max 4)
- **RDS MySQL** — Managed database in private subnet
- **NAT Gateway** — Internet access for private instances

## What I Learned
- CloudFormation template structure (Parameters, Resources, Outputs)
- Fn::Sub and Fn::Base64 for UserData encoding
- Debugging circular dependencies and property validation errors
- NAT Gateway vs Internet Gateway differences
- Target group health checks and ALB troubleshooting
- Private subnet isolation with controlled internet access

## Live URL
- ALB: http://project4-alb-278231304.eu-west-2.elb.amazonaws.com

## Key Files
- `three-tier-stack.yaml` — Complete CloudFormation template
- `trust-policy.json` — IAM trust policy
- `lambda-permissions-policy.json` — Lambda permissions

## Cost Note
Stack includes NAT Gateway (~£0.04/hr) and RDS — delete stack after testing.