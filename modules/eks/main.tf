resource "aws_eks_cluster" "batas_cluster" {
  name = var.eks_cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = var.eks_iam_role_arn
  version  = var.eks_version

  vpc_config {
    subnet_ids = var.eks_subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = var.eks_cluster_policy_arn
  role       = var.eks_iam_role_arn
}