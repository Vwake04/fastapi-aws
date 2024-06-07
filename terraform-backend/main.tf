terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}




data "aws_caller_identity" "current" {}

# // Create VPC
# resource "aws_vpc" "fastapi_vpc" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "fastapi"
#   }
# }

# // Create subnet within the VPC
# resource "aws_subnet" "fastapi_subnet" {
#   vpc_id            = aws_vpc.fastapi_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "${var.region}a"

#   tags = {
#     Name = "fastapi"
#   }
# }


# # Create a route table
# resource "aws_route_table" "fastapi_route_table" {
#   vpc_id = aws_vpc.fastapi_vpc.id

#   tags = {
#     Name = "fastapi"
#   }
# }


# # Route table association with subnet and vpc
# resource "aws_route_table_association" "fastapi_subnet_association" {
#   subnet_id      = aws_subnet.fastapi_subnet.id
#   route_table_id = aws_route_table.fastapi_route_table.id
# }

# # internet gateway
# resource "aws_internet_gateway" "fastapi_igw" {
#   vpc_id = aws_vpc.fastapi_vpc.id

#   tags = {
#     Name = "fastapi"
#   }
# }

# # aws route
# resource "aws_route" "fastapi_route" {
#   route_table_id         = aws_route_table.fastapi_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.fastapi_igw.id
# }

# # Secrity Group
# resource "aws_security_group" "fastapi_security_group" {
#   vpc_id = aws_vpc.fastapi_vpc.id

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["106.205.250.135/32"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "fastapi"
#   }
# }

# Key Pair
# resource "aws_key_pair" "fastapi_keypair" {
#   key_name   = "fastapi-keypair"
#   public_key = file("~/.ssh/id_rsa.pub")
# }


# // Create EC2 instance within the subnet
# resource "aws_instance" "fastapi_instance" {
#   ami                         = "ami-05e00961530ae1b55" // Your desired AMI ID
#   instance_type               = "t2.micro"
#   # subnet_id                   = aws_subnet.fastapi_subnet.id
#   key_name                    = aws_key_pair.fastapi_keypair.key_name
#   # associate_public_ip_address = true
#   # vpc_security_group_ids      = [aws_security_group.fastapi_security_group.id]
#   tags = {
#     Name = "fastapi"
#   }
# }

