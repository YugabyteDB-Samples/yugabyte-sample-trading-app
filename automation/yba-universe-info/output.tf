output "universe"{
  value = local.universe
}
output "primary-tservers" {
  value = sort(local.pirmary-tservers)
}
output "read-replica-tservers"{
  value = sort(local.read-replica-tservers)
}
