provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
  alias = "staging"
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
  alias = "prod"
}


resource "tls_private_key" "tls-key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.tls-key.private_key_pem
  email_address   = var.tls-email
  provider = acme.prod
}

resource "acme_certificate" "tls-certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = data.aws_route53_zone.root.name
  subject_alternative_names = ["*.${data.aws_route53_zone.root.name}"]

  dns_challenge {
    provider = "route53"
    config = {
      AWS_HOSTED_ZONE_ID = data.aws_route53_zone.root.zone_id
    }
  }
  provider = acme.prod
}
resource "pkcs12_from_pem" "tls-pkcs12" {
  password = "changeit"
  cert_pem = acme_certificate.tls-certificate.certificate_pem
  private_key_pem  = acme_certificate.tls-certificate.private_key_pem
  ca_pem = acme_certificate.tls-certificate.issuer_pem
}
resource "local_file" "tls-pkcs12"{
  filename = "${local.dir}/private/tls-pkcs.p12"
  content_base64     = pkcs12_from_pem.tls-pkcs12.result
}

resource "local_file" "tls-private-key-pem"{
  filename = "${local.dir}/private/tls-private-key.pem"
  content     = acme_certificate.tls-certificate.private_key_pem
}
resource "local_file" "tls-certificate-pem"{
  filename = "${local.dir}/private/tls-certificate.pem"
  content     = acme_certificate.tls-certificate.certificate_pem
}
resource "local_file" "tls-ca-pem"{
  filename = "${local.dir}/private/tls-ca.pem"
  content     = acme_certificate.tls-certificate.issuer_pem
}
