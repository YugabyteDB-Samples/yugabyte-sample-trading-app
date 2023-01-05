terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


data "aws_vpc" "vpc" {
  id = var.vpc_id  
}
data "aws_ami" "ubuntu" {
  count = length(var.ami) == 0 ? 1 : 0
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
locals {
  ami-id = length(var.ami) == 0? data.aws_ami.ubuntu[0].id : var.ami
}

resource "aws_key_pair" "ssh-key" {
  key_name_prefix   = "tradex"
  public_key = var.public-key
}

resource "aws_security_group" "sg" {  
  name = var.name
  description = "TradeX - Security Group"
  vpc_id      = var.vpc_id
    
  ingress {
    description = "Alow all traffic from Administrators IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.admin-cidrs
  }
  ingress {
    description = "All all traffic from VPC"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = data.aws_vpc.vpc.cidr_block_associations[*].cidr_block
  }
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Alt HTTP traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Alt HTTPS traffic"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name = "map-public-ip-on-launch"
    values = ["true"]
  }
}
data "cloudinit_config" "server_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/templates/cloudconfig.yaml.tftpl", {
      tls-cert-pem = var.tls-cert-pem
      tls-ca-pem = var.tls-ca-pem
      tls-key-pem = var.tls-key-pem
      tls-pkcs = var.tls-pkcs
      post-provision-commands = var.post-provision-commands
    })
  }
}
resource "aws_instance" "app" {
  ami           = local.ami-id
  tags = {
    Name = "${var.name}"
  }
  associate_public_ip_address = true
  instance_type = var.machine-size
  key_name = aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]
  subnet_id = data.aws_subnets.subnets.ids[0]
  user_data = data.cloudinit_config.server_config.rendered
}
