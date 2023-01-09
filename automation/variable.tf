variable "env-name" {
  type        = string
  description = "Environment name. App URL will use this like : <location>-<env-name>-tradex.<root-domain>"
}

variable "tls-email" {
  type        = string
  description = "Email address for TLS key"
}
variable "vpc-mapping" {
  type = map(object({
    vpc = string
  }))
  description = "Location to VPC Mapping for deployment. Go to AWS project and find our VPCs for your desired location and map it here"
}
variable "tags" {
  type        = map(string)
  description = "Tags associated with the env"
}

variable "root-domain" {
  type        = string
  description = "A root-domain for this deployment. This domain should have a route 53 hosted zone associated with the account"
  default     = "aws.ats-yb.ga"
}

variable "post-provision-commands" {
  type        = list(string)
  description = "list of commands to execute after provisioning machines. Example: [ 'docker run -d -p 8080:8080 yogendra/spring-boot-web' ]"
}

variable "additional-admin-workstation-cidrs" {
  type        = list(string)
  description = "Open firewall for admins from other IPs. Example: [ '116.12.12.12/32' ] for a single ip"
  default     = []
}

variable "yba" {
  type = object({
    api-endpoint                            = string
    api-token                               = string
    insecure                                = bool
    single-region-universe-name             = string
    multi-region-universe-name              = string
    multi-region-read-replica-universe-name = string
    geo-partition-universe-name             = string

  })
  description = "YugabyteDB Anywhere Portal Details"
}
