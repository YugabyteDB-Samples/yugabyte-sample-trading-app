
data "aws_route53_zone" "root" {
  name         = "${var.root-domain}"
  private_zone = false
}

locals {
  fqdn-suffix = "${var.env-name}-tradex.${data.aws_route53_zone.root.name}"
}

resource "aws_route53_record" "fqdn" {
  for_each = local.vm-ips  
  zone_id = data.aws_route53_zone.root.id
  name    = "${each.key}-${local.fqdn-suffix}."
  type    = "A"
  ttl     = "5"
  records = [each.value]
}
