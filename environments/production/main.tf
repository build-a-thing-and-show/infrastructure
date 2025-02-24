module "vpc" {
  source = "../modules/vpc"
}

module "iam" {
  source = "../modules/iam"
}

module "eks" {
  source             = "../modules/eks"
  eks_iam_role_arn   = module.iam.iam_role_arn
  eks_subnet_ids = [
    module.vpc.subnet_private_id,
    module.vpc.subnet_public_id,
  ]
}