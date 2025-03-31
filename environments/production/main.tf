module "vpc" {
  source = "../../modules/vpc"
}

module "iam" {
  source = "../../modules/iam"
}

module "eks" {
  source             = "../../modules/eks"
  eks_iam_role_arn   = module.iam.iam_role_arn
  eks_iam_role_name  = module.iam.iam_role_name
  eks_node_group_iam_role_arn = module.iam.eks_node_group_iam_role_arn
  eks_node_group_iam_role_name = module.iam.eks_node_group_iam_role_name
  eks_cluster_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  eks_subnet_ids = [
    //module.vpc.subnet_private_id,  --> for experimental reason, only use public subnet at this moment. We will change this once we add the API Gateway, ALB and NAT Gateway to the arch.
    module.vpc.subnet_public_id,
  ]
}