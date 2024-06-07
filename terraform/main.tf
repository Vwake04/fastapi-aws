terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


data "aws_caller_identity" "current" {}


// Create EC2 instance within the subnet
resource "aws_instance" "fastapi_instance" {
  ami           = "ami-05e00961530ae1b55" // Your desired AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "fastapi"
  }
}

