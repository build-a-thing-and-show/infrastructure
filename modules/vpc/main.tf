resource "aws_vpc" "batas_vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.batas_vpc.id
  cidr_block        = var.subnet_private_cidr_block
  availability_zone = var.subnet_private_availability_zone

  tags = {
    Name = var.subnet_private_name
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/eks_cluster" = "shared" // Instead of hardcoding the cluster name, we should use ${var.cluster_name}
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.batas_vpc.id
  cidr_block        = var.subnet_public_cidr_block
  availability_zone = var.subnet_public_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_public_name
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/eks_cluster" = "shared"   // Instead of hardcoding the cluster name, we should use ${var.cluster_name}
  }
}