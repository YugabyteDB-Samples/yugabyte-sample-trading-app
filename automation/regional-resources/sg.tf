
resource "aws_security_group" "sg" {  
  name = "${var.prefix}-sg"
  description = "TradeX - Security Group"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.prefix}-sg"
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
    description       = "Allow incoming from known machines"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    prefix_list_ids   = [aws_ec2_managed_prefix_list.allow-remote.id]
  }
}



resource "aws_ec2_managed_prefix_list" "allow-remote" {
  name           = "${var.prefix}-allow-remote"
  address_family = "IPv4"
  max_entries    = 20
  tags = {
    Name = "${var.prefix}-allow-remote"
  }
}
resource "aws_ec2_managed_prefix_list_entry" "allow-remote" {
  count       = length(var.admin-cidrs)
  cidr           = var.admin-cidrs[count.index]
  description    = var.admin-cidrs[count.index]
  prefix_list_id = aws_ec2_managed_prefix_list.allow-remote.id
}

