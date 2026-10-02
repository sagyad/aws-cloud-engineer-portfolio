
# ---------------------------------------------------
# Root Outputs — Project 9
# ---------------------------------------------------

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "node_group_name" {
  description = "EKS Node Group Name"
  value       = module.eks.node_group_name
}

