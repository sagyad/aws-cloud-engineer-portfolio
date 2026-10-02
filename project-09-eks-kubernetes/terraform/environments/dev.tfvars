# ---------------------------------------------------------------------------------------------------------------------
# Project 9 - EKS Kubernetes
# Environment: Development
# ---------------------------------------------------------------------------------------------------------------------

project_name       = "project9-eks"
environment        = "dev"
vpc_cidr           = "10.0.0.0/16"
azs                = ["eu-west-2a", "eu-west-2b"]
desired_nodes      = 2
min_nodes          = 1
max_nodes          = 3
app_port           = 5000
cluster_version    = "1.30"
node_instance_type = "t3.medium"
