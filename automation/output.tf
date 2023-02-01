

output "access-info" {
  value = <<EOF
ACCESS INFORMATION
==================

%{for location, ip in local.vm-ips~}
Location: ${location}
---------------------
  SSH Access:    
    ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i ${local_file.ssh-key-private.filename} ubuntu@${ip}
    ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i ${local_file.ssh-key-private.filename} ubuntu@${aws_route53_record.regional-app[location].name}
  Web Access:
    http://${aws_route53_record.regional-app[location].name}
    https://${aws_route53_record.regional-app[location].name}
    http://${aws_route53_record.regional-app[location].name}:8080
    https://${aws_route53_record.regional-app[location].name}:8443

%{endfor~}

Database DNS:
-------------

  Single Region Multi Zone
    %{for db-dns in aws_route53_record.single-region[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)}
    %{endfor~}

    %{for db-dns in aws_route53_record.single-region-nodes[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)} (${module.single-region-universe.nodes-topology-map[join("", db-dns.records)]})
    %{endfor~}

  Multi Region
    %{for db-dns in aws_route53_record.multi-region[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)} 
    %{endfor~}

    %{for db-dns in aws_route53_record.multi-region-nodes[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)} (${module.multi-region-universe.nodes-topology-map[join("", db-dns.records)]})
    %{endfor~}

  Multi Region Read Replicas
    %{for db-dns in aws_route53_record.multi-region-read-replica[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)}
    %{endfor~}

    %{for db-dns in aws_route53_record.multi-region-read-replica-nodes[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)} (${module.multi-region-read-replica-universe.nodes-topology-map[join("", db-dns.records)]})
    %{endfor~}

    Read Replica
    %{for db-dns in aws_route53_record.multi-region-read-replica-rr[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)}
    %{endfor~}

    %{for db-dns in aws_route53_record.multi-region-read-replica-rr-nodes[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)} (${module.multi-region-read-replica-universe.nodes-topology-map[join("", db-dns.records)]})
    %{endfor~}

  Geo Partitioned
    %{for db-dns in aws_route53_record.geopart[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)}
    %{endfor~}

    %{for db-dns in aws_route53_record.geopart-nodes[*]~}
    ${db-dns.name} -> ${join(",", db-dns.records)} (${module.geo-partition-universe.nodes-topology-map[join("", db-dns.records)]})
    %{endfor~}

EOF
}
