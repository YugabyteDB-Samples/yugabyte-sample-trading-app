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

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = var.private-key 
    host     = self.public_ip
  }
  provisioner "file" {
    source      = var.tls-cert-pem
    destination = "/home/ubuntu/cert.pem"
  }
  provisioner "file" {
    source      = var.tls-key-pem
    destination = "/home/ubuntu/key.pem"
  }
  provisioner "file" {
    source      = var.tls-ca-pem
    destination = "/home/ubuntu/ca.pem"
  }
  provisioner "file" {
    source = var.tls-pkcs
    destination = "/home/ubuntu/tls.p12"
  } 
  provisioner "remote-exec" {
    inline = concat([
      "curl -fsSL https://get.docker.com | sudo bash",
      "sudo apt-get install -y uidmap",
      "dockerd-rootless-setuptool.sh install", 
      "sudo setcap cap_net_bind_service=ep $(which rootlesskit)",
      "systemctl --user restart docker",
      "echo export DOCKER_HOST=unix:///run/user/1000/docker.sock >> ~/.bashrc",
      "export DOCKER_HOST=unix:///run/user/1000/docker.sock",
      "sleep 5"
    ],
    var.post-provision-commands)
  }
}
