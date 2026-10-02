
# ---------------------------------------------------
# Root main.tf — Calls VPC and EKS Modules
# ---------------------------------------------------

# --- VPC Module ---
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  azs          = var.azs
}

# --- EKS Module ---
module "eks" {
  source             = "./modules/eks"
  project_name       = var.project_name
  environment        = var.environment
  subnet_ids         = module.vpc.private_subnet_ids
  cluster_version    = var.cluster_version
  node_instance_type = var.node_instance_type
  desired_nodes      = var.desired_nodes
  min_nodes          = var.min_nodes
  max_nodes          = var.max_nodes

  depends_on = [module.vpc]
}

