terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id  
}
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_subnets" "public-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name = "map-public-ip-on-launch"
    values = ["true"]
  }
  filter {
    name = "availability-zone"
    values = [data.aws_availability_zones.available.names[0]]
  }
}
data "aws_subnets" "private-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name = "map-public-ip-on-launch"
    values = ["false"]
  }
  filter {
    name = "availability-zone"
    values = [data.aws_availability_zones.available.names[0]]
  }
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
  key_name_prefix   = var.prefix
  public_key = var.public-key
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
      tradex-env = var.tradex-env
    })
  }
}
resource "aws_instance" "app" {
  ami           = local.ami-id
  tags = {
    Name = "${var.prefix}-app"
  }
  # associate_public_ip_address = true
  instance_type = var.machine-size
  key_name = aws_key_pair.ssh-key.key_name
  
  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]
  subnet_id = data.aws_subnets.private-subnets.ids[0]
  user_data = data.cloudinit_config.server_config.rendered
}

