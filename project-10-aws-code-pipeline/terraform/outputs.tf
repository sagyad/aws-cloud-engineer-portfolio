# =============================================================================
# FILE 4: outputs.tf (root) — Important Values After terraform apply
# =============================================================================
# Outputs are printed after terraform apply and can be used by other modules.
# These are the values you need to access your deployed app and debug issues.

output "alb_dns_name" {
  description = "ALB DNS name — hit this URL to access your app"
  value       = aws_lb.main.dns_name
}

output "ecr_repository_url" {
  description = "ECR repo URL — where Docker images are stored"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.main.name
}

output "pipeline_name" {
  description = "CodePipeline name — check pipeline status in console"
  value       = aws_codepipeline.main.name
}

output "s3_artifacts_bucket" {
  description = "S3 bucket for pipeline artifacts"
  value       = aws_s3_bucket.artifacts.id
}