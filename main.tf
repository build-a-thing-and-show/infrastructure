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

resource "aws_eks_cluster" "tf_cluster" {
  name = "name_for_tf_cluster"
  role_arn = aws_iam_role.cluster.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.az1.id,
      aws_subnet.az2.id,
      aws_subnet.az3.id,
    ]
  }
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