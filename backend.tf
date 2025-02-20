terraform {
  backend "s3" {
    bucket         = "batash-terraform-infrastructure"
    key            = "ec2-instance/terraform.tfstate" # We can rename this and even add more keys as the infra gets more complex
    region         = "us-east-1"
    encrypt        = true
  }
}