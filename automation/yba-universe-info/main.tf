
data "http" "universe" {
  url = "${var.yba.api-endpoint}/customers/${var.yba.customer-uuid}/universes?name=${var.universe-name}"
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
  universe =  jsondecode(chomp(data.http.universe.response_body))[0]
  details = local.universe.universeDetails
  clusters = local.details.clusters
  nodeDetailsSet = local.details.nodeDetailsSet  
  primary-cluster-uuid = one([ for c in local.clusters: c.uuid if c.clusterType == "PRIMARY" ])
  pirmary-tservers = [for node in local.nodeDetailsSet: node.cloudInfo.private_ip if node.placementUuid == local.primary-cluster-uuid]
  read-replicas-uuids = [ for c in local.clusters: c.uuid if c.clusterType == "ASYNC"]
  read-replica-tservers = [for node in local.nodeDetailsSet: node.cloudInfo.private_ip if contains( local.read-replicas-uuids, node.placementUuid)]
}
