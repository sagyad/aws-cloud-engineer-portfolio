
# ---------------------------------------------------
# EKS Module — Outputs
# ---------------------------------------------------

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint URL"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate" {
  description = "EKS Cluster CA Certificate"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "node_group_name" {
  description = "EKS Node Group Name"
  value       = aws_eks_node_group.main.node_group_name
}

