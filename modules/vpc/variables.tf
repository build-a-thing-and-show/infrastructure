variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "eks-vpc"
}

variable "subnet_private_cidr_block" {
  type    = string
  default = "10.0.4.0/24"
}

variable "subnet_private_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "subnet_private_name" {
  type    = string
  default = "eks-private-subnet-2"
}

variable "subnet_public_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "subnet_public_availability_zone" {
  type    = string
  default = "us-east-1b"
}

variable "subnet_public_name" {
  type    = string
  default = "eks-public-subnet-2"
}