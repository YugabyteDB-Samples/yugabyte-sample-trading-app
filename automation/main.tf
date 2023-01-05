terraform {
  required_version = "~> 1.3.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.0.7"
    }
  }
}

locals {
  dir = path.module
  admin-cidrs = concat(
    var.additional-admin-workstation-cidrs,
    ["${local.workstation-ip}/32"]
  )

}


module "Boston" {
  providers = {
    aws = aws.Boston
  }
  name   = "Boston-tradex-${var.env-name}"
  vpc_id = var.vpc-mapping.Boston.vpc


  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  post-provision-commands = var.post-provision-commands
}

module "Washington" {
  providers = {
    aws = aws.Washington
  }
  name   = "Washington-tradex-${var.env-name}"
  vpc_id = var.vpc-mapping.Washington.vpc

  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  post-provision-commands = var.post-provision-commands
}


module "Mumbai" {
  providers = {
    aws = aws.Mumbai
  }
  name   = "Mumbai-tradex-${var.env-name}"
  vpc_id = var.vpc-mapping.Mumbai.vpc

  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  post-provision-commands = var.post-provision-commands
}


module "Sydney" {
  providers = {
    aws = aws.Sydney
  }
  name   = "Sydney-tradex-${var.env-name}"
  vpc_id = var.vpc-mapping.Sydney.vpc

  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  post-provision-commands = var.post-provision-commands
}


module "London" {
  providers = {
    aws = aws.London
  }
  name   = "London-tradex-${var.env-name}"
  vpc_id = var.vpc-mapping.London.vpc

  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  post-provision-commands = var.post-provision-commands
}

locals {
  vm-ips = {
    Boston     = module.Boston.ip
    Washington = module.Washington.ip
    London     = module.London.ip
    Mumbai     = module.Mumbai.ip
    Sydney     = module.Sydney.ip
  }
}
