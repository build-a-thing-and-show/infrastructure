variable "eks_cluster_name" {
  type    = string
  default = "batas_eks_cluster"
}

variable "eks_iam_role_arn" {
  type = string
}

variable "eks_version" {
  type    = string
  default = "1.31"
}

variable "eks_subnet_ids" {
  type = list(string)
}

variable "eks_cluster_policy_arn" {
  type = string
}