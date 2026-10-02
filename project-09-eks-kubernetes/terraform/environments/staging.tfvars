# ---------------------------------------------------------------------------------------------------------------------
# Project 9 - EKS Kubernetes
# Environment: Staging
# ---------------------------------------------------------------------------------------------------------------------

project_name       = "project9-eks"
environment        = "staging"
vpc_cidr           = "10.1.0.0/16"
azs                = ["eu-west-2a", "eu-west-2b"]
desired_nodes      = 2
min_nodes          = 2
max_nodes          = 4
app_port           = 5000
cluster_version    = "1.32"
node_instance_type = "t3.medium"
