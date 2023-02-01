
data "aws_route53_zone" "root" {
  name         = var.root-domain
  private_zone = false
}

locals {
  app-dns-suffix = "${var.env-name}-tradex.${data.aws_route53_zone.root.name}."
  db-dns-suffix  = "${var.env-name}-tradexdb.${data.aws_route53_zone.root.name}."


  srmz-ips = module.single-region-universe.primary-tservers-ips
  mr-ips   = module.multi-region-universe.primary-tservers-ips
  mrrr-ips = module.multi-region-read-replica-universe.read-replica-tservers-ips
  geo-ips  = module.geo-partition-universe.primary-tservers-ips
}
resource "aws_route53_record" "regional-app" {
  for_each = local.vm-ips
  zone_id  = data.aws_route53_zone.root.id
  name     = "${each.key}-${local.app-dns-suffix}"
  type     = "A"
  ttl      = "5"
  records  = [each.value]
}

resource "aws_route53_record" "single-region" {
  count   = length(local.srmz-ips) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "srmz-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = local.srmz-ips
}

resource "aws_route53_record" "single-region-nodes" {
  count   = length(local.srmz-ips)
  zone_id = data.aws_route53_zone.root.id
  name    = "srmz-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [local.srmz-ips[count.index]]
}

resource "aws_route53_record" "multi-region" {
  count   = length(local.mr-ips) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = local.mr-ips
}

resource "aws_route53_record" "multi-region-nodes" {
  count   = length(local.mr-ips)
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [local.mr-ips[count.index]]
}

resource "aws_route53_record" "multi-region-read-replica" {
  count   = length(local.mrrr-ips) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-rr-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = local.mrrr-ips
}

resource "aws_route53_record" "multi-region-read-replica-nodes" {
  count   = length(local.mrrr-ips)
  zone_id = data.aws_route53_zone.root.id
  name    = "mr-rr-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [local.mrrr-ips[count.index]]
}

resource "aws_route53_record" "geopart" {
  count   = length(local.geo-ips) == 0 ? 0 : 1
  zone_id = data.aws_route53_zone.root.id
  name    = "geo-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = local.geo-ips
}

resource "aws_route53_record" "geopart-nodes" {
  count   = length(local.geo-ips)
  zone_id = data.aws_route53_zone.root.id
  name    = "geo-n${count.index + 1}-${local.db-dns-suffix}"
  type    = "A"
  ttl     = "5"
  records = [local.geo-ips[count.index]]
}
