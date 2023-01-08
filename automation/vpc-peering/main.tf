terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
      configuration_aliases = [ aws.src, aws.dst ]
    }
  }
}



data "aws_vpc" "src" {
  provider = aws.src
  id = var.src-vpc-id
}
data "aws_vpc" "dst" {
  provider = aws.dst
  id = var.dst-vpc-id
}
data "aws_region" "src" {
  provider = aws.src
}
data "aws_region" "dst" {
  provider = aws.dst
}

# resource "aws_vpc_peering_connection" "src-dst" {
#   provider = aws.src
#   vpc_id        = data.aws_vpc.src.id
#   peer_vpc_id   = data.aws_vpc.dst.id
#   peer_region   = data.aws_region.dst.name  
# }
# resource "aws_vpc_peering_connection_accepter" "dst-src" {
#   provider                  = aws.dst
#   vpc_peering_connection_id = aws_vpc_peering_connection.src-dst.id
#   auto_accept               = true
# }


data "aws_vpc_peering_connection" "src-dst" {
  provider        = aws.src
  vpc_id          = data.aws_vpc.src.id
  peer_cidr_block = data.aws_vpc.dst.cidr_block
  peer_vpc_id = data.aws_vpc.dst.id
  peer_region = data.aws_region.dst.name
}


data "aws_route_tables" "src" {
  provider = aws.src
  vpc_id = data.aws_vpc.src.id
  filter {
    name   = "tag:Name"
    values = ["*public"]
  }
  # filter {
  #   name = "route.destination-cidr-block"
  #   values = ["!'${data.aws_vpc.dst.cidr_block}'"]
  # }
}
resource "aws_route" "src-dst" {
  provider = aws.src
  for_each =  toset(data.aws_route_tables.src.ids)
  route_table_id = each.key
  destination_cidr_block = data.aws_vpc.dst.cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection.src-dst.id
}
data "aws_vpc_peering_connection" "dst-src" {
  provider = aws.dst
  vpc_id          = data.aws_vpc.src.id
  peer_cidr_block = data.aws_vpc.dst.cidr_block
  peer_vpc_id = data.aws_vpc.dst.id
  peer_region = data.aws_region.dst.name
}

data "aws_route_tables" "dst" {
  provider = aws.dst
  vpc_id = data.aws_vpc.dst.id
  filter {
    name   = "tag:Name"
    values = ["*public"]
  }
  # filter {
  #   name = "route.destination-cidr-block"
  #   values = ["!'${data.aws_vpc.src.cidr_block}'"]
  # }
}
resource "aws_route" "dst-src" {
  provider = aws.dst
  for_each =  toset(data.aws_route_tables.dst.ids)
  route_table_id = each.key
  destination_cidr_block = data.aws_vpc.src.cidr_block
  vpc_peering_connection_id = data.aws_vpc_peering_connection.src-dst.id
}
