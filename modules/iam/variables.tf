variable "iam_role_name" {
  type    = string
  default = "eks-cluster"
}

variable "node_group_iam_role_name" {
  type    = string
  default = "eks-node-group"
}