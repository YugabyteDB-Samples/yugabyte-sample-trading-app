

output "access-info" {
  value = <<EOF
  ACCESS INFORMATION
  ==================

  %{for location, ip in local.vm-ips}
  Location: ${location}
  ---------------------    
    SSH Access:    
      ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i ${local_file.ssh-key-private.filename} ubuntu@${ip}
      ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i ${local_file.ssh-key-private.filename} ubuntu@${aws_route53_record.fqdn[location].name}
    Web Access:
      http://${aws_route53_record.fqdn[location].name}
      https://${aws_route53_record.fqdn[location].name}
      http://${aws_route53_record.fqdn[location].name}:8080
      https://${aws_route53_record.fqdn[location].name}:8443

  %{endfor}  
EOF
}
