/*
resource "aws_ssm_parameter" "foo" {
    name = "foo"
    type = "String"
    value = "bar"
}

resource "aws_instance" "tr_ec2" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "batash00"
    associate_public_ip_address = true
    ebs_block_device {
      device_name = "/dev/xvda"
      volume_size = 8
      volume_type = "gp3"
    }
}
*/

resource "aws_eks_cluster" "example" {
  name = "example"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.az1.id,
      aws_subnet.az2.id,
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_subnet" "az1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "eks-private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "az2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-subnet-2"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "eks-vpc"
  }
}