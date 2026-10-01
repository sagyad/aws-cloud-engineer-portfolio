
# ---------------------------------------------------------------------------------------------------------------------
# Root Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "ecs_cluster_id" {
  description = "ECS Cluster id"
  value       = module.ecs.cluster_id
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = module.ecs.service_name
}

output "alb_dns_name" {
  description = "ALB DNS name — use this to access the app"
  value       = aws_lb.main.dns_name
}

