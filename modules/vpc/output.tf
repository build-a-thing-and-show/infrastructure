output "vpc_id" {
  value = aws_vpc.batas_vpc.id
}

output "subnet_private_id" {
  value = aws_subnet.private.id
}

output "subnet_public_id" {
  value = aws_subnet.public.id
}