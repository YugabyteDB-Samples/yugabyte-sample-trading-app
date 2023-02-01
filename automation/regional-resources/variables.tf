variable "name"{
  type = string
  description = "name for the vm"
}
variable "prefix" {
  type = string
  description = "small prefix for resource name"
  default = "tradex"
}

variable "vpc_id"{
  type = string
  description = "VPC ID on AWS"
}
variable "public-key" {
  type = string
  description = "Public key"
}
variable "private-key" {
  type = string
  description = "Private key for SSH (Provisioning)"
}
variable "admin-cidrs" {
  type = list(string)
  description = "List of CIDR Addresses for Security Group config. This is used to open remote access"
}

variable "ami" {
  type = string
  default = ""
  description = "Machine image - default is latest Ubuntu LTS machin"
}

variable "machine-size" {
  type = string
  default = "t3.xlarge"
  description = "Size of machine - https://aws.amazon.com/ec2/instance-types/"
}

variable "tls-key-pem" {
  type = string
  description = "File path - TLS private key in PEM format"
}

variable "tls-cert-pem" {
  type = string
  description = "File path - TLS certificate"
}


variable "tls-ca-pem" {
  type = string
  description = "File path - TLS CA certificate"
}
variable "tls-pkcs" {
  type = string
  description = "File path - TLS PKCS12 keystore"
}

variable "post-provision-commands" {
  type = list(string)
  description = "Commands to execute after provisioning the node"
  default = []
}
