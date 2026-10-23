
# ADR-001: AWS CodePipeline Over Jenkins

## Status
Accepted

## Context
Project needs a CI/CD pipeline to automate build, test, and deployment.
Two main options: AWS CodePipeline (native) or Jenkins (self-hosted).

## Decision
Use AWS CodePipeline with CodeBuild and CodeDeploy.

## Reasons
- **No server management** — Jenkins needs an EC2 instance running 24/7
- **Native IAM integration** — no stored credentials, uses IAM roles
- **Built-in deployment strategies** — rolling, blue/green via CodeDeploy
- **Pay per use** — CodePipeline free tier (1 pipeline), CodeBuild (100 mins/month)
- **CloudWatch integration** — logs and metrics built-in
- **S3 artifact storage** — no external artifact server needed

## Trade-offs
- Jenkins has 1800+ plugins — more flexible for non-AWS workloads
- CodePipeline is AWS-only — not portable to other clouds
- Jenkins is open source — no vendor lock-in

## Conclusion
For AWS-only deployment to EC2, CodePipeline is simpler, cheaper, and more secure.
Jenkins is better when deploying across multiple cloud providers.

