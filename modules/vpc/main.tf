resource "aws_vpc" "batas_vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    Name = var.vpc_name
  }
}

/*
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
*/

// Create internet gateway for the pbulic subents
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.batas_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

// Create the route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.batas_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}


//--> for experimental reason, only use public subnet at this moment. We will change this once we add the API Gateway, ALB and NAT Gateway 
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.batas_vpc.id
  cidr_block        = var.subnet_private_cidr_block
  availability_zone = var.subnet_private_availability_zone
  map_public_ip_on_launch = true  // temporariliy convert this subnet to public (without changing the names)
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


// Create the associations between subnets and the public route table to internet gateway
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}