terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
      configuration_aliases = [ aws.src, aws.dst ]
    }
  }
}




# vpc-mapping = {
#   Boston : {
#     vpc : "vpc-0aa158023c29d81b8"
#     # us-east-2
#   }
#   Washington : {
#     vpc : "vpc-0cfafd8d518c099c9"
#     # us-east-1
#   }
#   London : {
#     vpc : "vpc-04a0fd2c443ad64e8"
#     # eu-west-2
#   }
#   Mumbai : {
#     vpc : "vpc-0b863842ed2fa905a"
#     # ap-south-1
#   }
#   Sydney : {
#     vpc : "vpc-08f041ce41685aa17"
#     # ap-southeast-2
#   }
# }
locals {
  tags = {
    yb_owner   = "yrampuria"
    yb_customer = "internal"
    yb_task     = "demo"
    yb_dept     = "sales"
    yb_env      = "demo"
    yb_project  = "Tradex (yr)"

  }
}

module "Washington-Boston" {
  source = "../"
  src-vpc-id = "vpc-0cfafd8d518c099c9"
  dst-vpc-id = "vpc-0aa158023c29d81b8"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Boston
   }
}

module "Washington-London" {
  source = "../"
  src-vpc-id = "vpc-0cfafd8d518c099c9"
  dst-vpc-id = "vpc-04a0fd2c443ad64e8"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.London
   }
}

module "Washington-Mumbai" {
  source = "../"
  src-vpc-id = "vpc-0cfafd8d518c099c9"
  dst-vpc-id = "vpc-0b863842ed2fa905a"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Mumbai
   }
}

module "Washington-Sydney" {
  source = "../"
  src-vpc-id = "vpc-0cfafd8d518c099c9"
  dst-vpc-id = "vpc-08f041ce41685aa17"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Sydney
   }
}

module "Boston-London" {
  source = "../"
  src-vpc-id = "vpc-0aa158023c29d81b8"
  dst-vpc-id = "vpc-04a0fd2c443ad64e8"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.London
   }
}

module "Boston-Mumbai" {
  source = "../"
  src-vpc-id = "vpc-0aa158023c29d81b8"
  dst-vpc-id = "vpc-0b863842ed2fa905a"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Mumbai
   }
}

module "Boston-Sydney" {
  source = "../"
  src-vpc-id = "vpc-0aa158023c29d81b8"
  dst-vpc-id = "vpc-08f041ce41685aa17"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Sydney
   }
}


module "London-Mumbai" {
  source = "../"
  src-vpc-id = "vpc-04a0fd2c443ad64e8"
  dst-vpc-id = "vpc-0b863842ed2fa905a"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Mumbai
   }
}

module "London-Sydney" {
  source = "../"
  src-vpc-id = "vpc-04a0fd2c443ad64e8"
  dst-vpc-id = "vpc-08f041ce41685aa17"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Sydney
   }
}

module "Mumbai-Sydney" {
  source = "../"
  src-vpc-id = "vpc-04a0fd2c443ad64e8"
  dst-vpc-id = "vpc-08f041ce41685aa17"
  providers = {
    aws.src = aws.Washington
    aws.dst = aws.Sydney
   }
}
