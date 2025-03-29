output "iam_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "iam_role_name" {
  value = aws_iam_role.eks_cluster.name
}

output "eks_node_group_iam_role_arn" {
  value = aws_iam_role.eks_node_group.arn
}

output "eks_node_group_iam_role_name" {
  value = aws_iam_role.eks_node_group.name
}