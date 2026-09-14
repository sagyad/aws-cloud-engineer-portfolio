# Project 1: Static Website with Global CDN
User Request (HTTPS) ↓ CloudFront CDN (Edge Locations) ↓ (OAC Authentication) S3 Bucket (Private - Static Files)

## Architecture

## What I Built
A static portfolio website hosted on AWS S3, served globally through CloudFront CDN with HTTPS encryption. S3 is locked down — only CloudFront can access it via Origin Access Control (OAC).

## AWS Services Used
| Service | Purpose |
|---------|---------|
| **S3** | Static website file hosting |
| **CloudFront** | CDN for global delivery + HTTPS |
| **ACM** | SSL/TLS certificate (via CloudFront default) |
| **IAM** | Bucket policy for access control |
| **OAC** | Secure CloudFront-to-S3 authentication |

## Key Concepts Learned
- S3 static website hosting and bucket policies
- Principal, Effect, Action, Resource in IAM policies
- Explicit Deny always wins over Allow
- ACLs vs Bucket Policies (bucket policies preferred)
- Block Public Access safety switches
- CloudFront CDN distribution and cache invalidation
- OAC pattern for securing S3 behind CloudFront
- CI/CD with GitHub Actions (test → deploy pipeline)

## CI/CD Pipeline
Automated via GitHub Actions — on every push to `main`:
1. **Test Job** — Validates HTML exists, structure is correct, no secrets exposed
2. **Deploy Job** — Syncs files to S3 + invalidates CloudFront cache

Pipeline only deploys if all tests pass.

## Live URL
🔗 https://d1i3qy1zbydstm.cloudfront.net

## Cost
💰 **$0** — Entirely within AWS Free Tier
- S3: Free tier (5GB storage)
- CloudFront: Free tier (1TB transfer/month)
- No Route 53 (skipped custom domain to avoid $0.50/month)

## Project Structure
project-01-static-website-cdn/ ├── index.html # Portfolio website ├── .github/ │ └── workflows/ │ └── deploy.yml # CI/CD pipeline ├── .gitignore └── README.md


## Part of
[AWS Cloud Engineer Portfolio](https://github.com/sagyad/aws-cloud-engineer-portfolio) — 12 end-to-end AWS projects from foundation to production.