# ---------------------------------------------------------------------------------------------------------------------
# Project 9 - EKS Kubernetes
# Environment: Production
# ---------------------------------------------------------------------------------------------------------------------

project_name       = "project9-eks"
environment        = "prod"
vpc_cidr           = "10.2.0.0/16"
azs                = ["eu-west-2a", "eu-west-2b"]
desired_nodes      = 3
min_nodes          = 3
max_nodes          = 6
app_port           = 5000
cluster_version    = "1.32"
node_instance_type = "t3.micro"
