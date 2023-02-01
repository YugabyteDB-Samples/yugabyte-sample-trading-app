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

resource "aws_security_group" "sg" {  
  name = "${var.prefix}-sg"
  description = "TradeX - Security Group"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.prefix}-sg"
  }

  ingress {
    description = "All all traffic from VPC IPs"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = data.aws_vpc.vpc.cidr_block_associations[*].cidr_block
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Allow HTTP traffic"
    from_port     = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS traffic"
    from_port     = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Alt HTTP traffic"
    from_port     = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Alt HTTP traffic"    
    from_port     = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Alt HTTPS traffic"
    from_port     = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Alow all traffic from Administrators IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.admin-cidrs
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


resource "aws_eip" "app" {
  vpc = true
}

resource "aws_lb" "app" {
  name               = "${var.prefix}-nlb"
  load_balancer_type = "network"
  # security_groups = [aws_security_group.lb.id]

  subnet_mapping {
    subnet_id     = data.aws_subnets.public-subnets.ids[0]
    allocation_id = aws_eip.app.id
  }
}


locals{
  app_ports = {
    ssh = 22
    http = 80
    https = 443
    alt_http = 8080
    spring_management = 8081
    alt_https = 8443
  }
}
resource "aws_lb_target_group" "app" {
  for_each = local.app_ports
  name     = "${var.prefix}-${each.value}-tg"
  port     = each.value
  protocol = "TCP"
  vpc_id   = data.aws_vpc.vpc.id
  depends_on = [
    aws_lb.app
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "app" {
  for_each = local.app_ports
  target_group_arn = aws_lb_target_group.app[each.key].arn
  target_id        = aws_instance.app.id
  port             = each.value
  
}

resource "aws_lb_listener" "app" {
  for_each = local.app_ports
  tags = {
    Name = "${var.prefix}-${each.value}"
  }

  load_balancer_arn = aws_lb.app.arn
  protocol          = "TCP"
  port              = each.value

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app[each.key].arn
  }
}

