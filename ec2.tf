resource "aws_instance" "tf_ec2" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Ubuntu AMI (Got it from EC2 Console for Canonical, Ubuntu, 24.04, amd64 noble image)
  instance_type = "t2.micro"               # Free-tier eligible instance type
  key_name      = "batash00"                 # This is the key-pair we already have in our EC2 AWS
  tags = {
    Name = "TerraformEC2Instance"
  }
}