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
