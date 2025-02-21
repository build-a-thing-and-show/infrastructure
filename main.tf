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