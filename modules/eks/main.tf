resource "aws_eks_cluster" "main" {
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
  role       = var.eks_iam_role_name
}

resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.name
  node_group_name = "single-t2-micro-node"
  node_role_arn = var.eks_node_group_iam_role_arn
  scaling_config {
    desired_size = 1
    max_size = 1
    min_size = 1
  }
  instance_types = ["t2.micro"]
  subnet_ids = var.eks_subnet_ids
  # we want to make sure the node_group gets created after:
  #  - the cluster is created
  # is this really needed?
  depends_on = [ 
    aws_eks_cluster.main,
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
   ]
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = var.eks_node_group_iam_role_name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = var.eks_node_group_iam_role_name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = var.eks_node_group_iam_role_name
}