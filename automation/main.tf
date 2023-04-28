

locals {
  dir = path.module
  admin-cidrs = concat(
    var.additional-admin-workstation-cidrs,
    ["${local.workstation-ip}/32"],
    data.aws_vpc.Boston.cidr_block_associations.*.cidr_block,
    data.aws_vpc.Washington.cidr_block_associations.*.cidr_block,
    data.aws_vpc.London.cidr_block_associations.*.cidr_block,
    data.aws_vpc.Mumbai.cidr_block_associations.*.cidr_block,
    data.aws_vpc.Sydney.cidr_block_associations.*.cidr_block
  )
}


module "Boston" {
  providers = {
    aws = aws.Boston
  }
  name                    = "Boston-tradex-${var.env-name}"
  vpc_id                  = var.vpc-mapping.Boston.vpc
  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  tradex-env              = local.tradex-env.boston
  post-provision-commands = var.post-provision-commands
}

module "Washington" {
  providers = {
    aws = aws.Washington
  }
  name                    = "Washington-tradex-${var.env-name}"
  vpc_id                  = var.vpc-mapping.Washington.vpc
  prefix                  = "tradex-${var.env-name}"
  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  tradex-env              = local.tradex-env.washington
  post-provision-commands = var.post-provision-commands
}


module "Mumbai" {
  providers = {
    aws = aws.Mumbai
  }
  name                    = "Mumbai-tradex-${var.env-name}"
  vpc_id                  = var.vpc-mapping.Mumbai.vpc
  prefix                  = "tradex-${var.env-name}"
  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  tradex-env              = local.tradex-env.mumbai
  post-provision-commands = var.post-provision-commands
}


module "Sydney" {
  providers = {
    aws = aws.Sydney
  }
  name                    = "Sydney-tradex-${var.env-name}"
  vpc_id                  = var.vpc-mapping.Sydney.vpc
  prefix                  = "tradex-${var.env-name}"
  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  tradex-env              = local.tradex-env.sydney
  post-provision-commands = var.post-provision-commands
}


module "London" {
  providers = {
    aws = aws.London
  }
  name                    = "London-tradex-${var.env-name}"
  vpc_id                  = var.vpc-mapping.London.vpc
  prefix                  = "tradex-${var.env-name}"
  source                  = "./regional-resources"
  public-key              = tls_private_key.ssh-key.public_key_openssh
  private-key             = tls_private_key.ssh-key.private_key_openssh
  admin-cidrs             = local.admin-cidrs
  tls-key-pem             = local_file.tls-private-key-pem.content
  tls-cert-pem            = local_file.tls-certificate-pem.content
  tls-ca-pem              = local_file.tls-ca-pem.content
  tls-pkcs                = local_file.tls-pkcs12.content_base64
  tradex-env              = local.tradex-env.london
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
