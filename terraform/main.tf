terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}


locals {
  default_tags = {
    Environment = terraform.workspace
    Name        = "${var.identifier}-${terraform.workspace}"
  }
  tags = merge(local.default_tags, var.tags)
}




# ssh key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXh4ihVZCNXjxD+ecQaCIjA0pajc+s9NP20/6EQCbvLOXKb0Tsk+GDvLEBtjbrcufT3U3BEuy71cIgPzUe+HCUYInqXYzcN6l1skOLNmJmsbmFLRcYYinXG5a53FgOy2uvH/BcBX5PPzA5EU4sJINUFck35/0SM1/Iz3DQ6nMEllh484oC9/UU7jrtxMcLMblt1KIYQ6+oSwLtXzauIDuIkvs/dj+omPatY2hYdOnvsGEtQDfuWykskgOVr0w1hUpDPxqCtD2scbAe9FdxLheRhCdL+TBBCyXiIJSkTDo82KfaWO/HwssU5ek/9SKjVNQ/Jmydw1/53ziI3oS3JuqBbH+OOKeOBdFSD6ZqZv5XqtpUYiK5wCxVhoH65QoXpzK5VgVuwgboYW1VHP6dDJs5P2S/xpuHKrPzggXrAjAJd4JSjnMk7VrN9t8KmoY4gctazBExjg448z/Od9nz8+6X0QR/crHCcs93KcHW79Urx80BQ6v9KyJN7XQafNPQz2U= kmehmood@master-node"
}

# Security group for EC2 instance
resource "aws_security_group" "allow-ssh-tls-ports" {
  name        = "allow-tls-ports"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.215.226.36/32", "107.22.40.20/32", "0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

# Security group for DB
resource "aws_security_group" "allow-db-port" {
  name        = "allow_db_port"
  description = "Allow db inbound traffic"

  ingress {
    description     = "TLS from VPC"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.allow-ssh-tls-ports.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating ec2 instance
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.id
  vpc_security_group_ids = [aws_security_group.allow-ssh-tls-ports.id]


  tags = local.tags
}


resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  vpc      = true
}
