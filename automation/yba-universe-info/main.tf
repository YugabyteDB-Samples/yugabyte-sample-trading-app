
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
  primary-tservers  = [for node in local.nodeDetailsSet: node.cloudInfo if node.placementUuid == local.primary-cluster-uuid]
  primary-tservers-ips = sort([ for s in local.primary-tservers : s.private_ip ])
  read-replicas-uuids = [ for c in local.clusters: c.uuid if c.clusterType == "ASYNC"]
  read-replica-tservers = [for node in local.nodeDetailsSet: node.cloudInfo if contains( local.read-replicas-uuids, node.placementUuid)]
  read-replica-tservers-ips = sort([ for s in local.read-replica-tservers : s.private_ip ])
  node-topology-map = merge({
    for ts in local.primary-tservers: ts.private_ip => "${ts.cloud}.${ts.region}.${ts.az}"
  },
  {
    for ts in local.read-replica-tservers: ts.private_ip => "${ts.cloud}.${ts.region}.${ts.az}"
  })
}
