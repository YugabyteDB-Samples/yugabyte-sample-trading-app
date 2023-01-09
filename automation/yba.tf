data "http" "yba-customer" {
  url = "${var.yba.api-endpoint}/customers"
  request_headers = {
    Accept              = "application/json"
    X-AUTH-YW-API-TOKEN = var.yba.api-token
  }
  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
  insecure = var.yba.insecure
}
locals {
  yba-customer-uuid = jsondecode(chomp(data.http.yba-customer.response_body))[0].uuid
  yba-client = merge({
    customer-uuid = local.yba-customer-uuid
  }, var.yba)
}
module "single-region-universe" {
  source        = "./yba-universe-info"
  yba           = local.yba-client
  universe-name = var.yba.single-region-universe-name
}

module "multi-region-universe" {
  source        = "./yba-universe-info"
  yba           = local.yba-client
  universe-name = var.yba.multi-region-universe-name
}


module "multi-region-read-replica-universe" {
  source        = "./yba-universe-info"
  yba           = local.yba-client
  universe-name = var.yba.multi-region-read-replica-universe-name
}

module "geo-partition-universe" {
  source        = "./yba-universe-info"
  yba           = local.yba-client
  universe-name = var.yba.geo-partition-universe-name
}

