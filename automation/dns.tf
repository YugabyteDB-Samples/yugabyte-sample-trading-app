
data "aws_route53_zone" "root" {
  name         = var.root-domain
  private_zone = false
}

locals {
  app-dns-suffix = "${var.env-name}-tradex.${data.aws_route53_zone.root.name}."
  db-dns-suffix  = "${var.env-name}-tradexdb.${data.aws_route53_zone.root.name}."
}

resource "aws_route53_record" "regional-app" {
  for_each = local.vm-ips
  zone_id  = data.aws_route53_zone.root.id
  name     = "${each.key}-${local.app-dns-suffix}"
  type     = "A"
  ttl      = "5"
  records  = [each.value]
}

resource "aws_route53_record" "single-region-nodes" {
  count   = length(module.single-region-universe.primary-tservers)
  zone_id = data.aws_route53_zone.root.id
  name    = "srmz-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [module.single-region-universe.primary-tservers[count.index]]
}
resource "aws_route53_record" "single-region" {  
  count   = length(module.single-region-universe.primary-tservers) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "srmz-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = module.single-region-universe.primary-tservers
}

resource "aws_route53_record" "multi-region-nodes" {
  count   = length(module.multi-region-universe.primary-tservers)
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [module.multi-region-universe.primary-tservers[count.index]]
}

resource "aws_route53_record" "multi-region" {
  count   = length(module.multi-region-universe.primary-tservers) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = module.multi-region-universe.primary-tservers
}
resource "aws_route53_record" "multi-region-read-replica-nodes" {
  count   = length(module.multi-region-read-replica-universe.read-replica-tservers)
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-rr-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [module.multi-region-read-replica-universe.read-replica-tservers[count.index]]
}

resource "aws_route53_record" "multi-region-read-replica" {
  count   = length(module.multi-region-read-replica-universe.read-replica-tservers) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-rr-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = module.multi-region-read-replica-universe.read-replica-tservers
}


resource "aws_route53_record" "geopart-nodes" {
  count   = length(module.multi-region-read-replica-universe.primary-tservers)
  zone_id = data.aws_route53_zone.root.id
  name    = "geo-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [module.multi-region-read-replica-universe.primary-tservers[count.index]]
}

resource "aws_route53_record" "geopart" {
  count   = length(module.multi-region-read-replica-universe.primary-tservers) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "geo-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = module.multi-region-read-replica-universe.primary-tservers
}
