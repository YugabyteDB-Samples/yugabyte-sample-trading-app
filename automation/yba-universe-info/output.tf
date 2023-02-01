output "universe"{
  value = local.universe
}
output "primary-tservers" {
  value = local.primary-tservers
}
output "primary-tservers-ips" {
  value = local.primary-tservers-ips
}
output "read-replica-tservers"{
  value = local.read-replica-tservers
}

output "read-replica-tservers-ips"{
  value = local.read-replica-tservers-ips
}
output "nodes-topology-map" {
  value = local.node-topology-map
}


output "debug" {
  value = <<-DEBUG
  
  universe
  ${jsonencode(local.universe)}
  -----------------------------
  details
  ${jsonencode(local.details)}
  -----------------------------
  clusters
  ${jsonencode(local.clusters)}
  -----------------------------
  nodeDetailsSet
  ${jsonencode(local.nodeDetailsSet)}
  -----------------------------
  
  primary-cluster-uuid
  ${jsonencode(local.primary-cluster-uuid)}
  -----------------------------
  primary-tservers
  ${jsonencode(local.primary-tservers)}
  -----------------------------
  primary-tservers-ips
  ${jsonencode(local.primary-tservers-ips)}
-----------------------------
  
  read-replicas-uuids
  ${jsonencode(local.read-replicas-uuids)}
  -----------------------------
  read-replica-tservers
  ${jsonencode(local.read-replica-tservers)}
  -----------------------------
  read-replica-tservers-ips
  ${jsonencode(local.read-replica-tservers-ips)}
  -----------------------------
  
  node-topology-map 
  ${jsonencode(local.node-topology-map )}
-----------------------------
  DEBUG
}
