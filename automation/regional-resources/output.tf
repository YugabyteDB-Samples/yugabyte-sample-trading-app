output "ip"{
  value = aws_eip.app.public_ip
}

output "app-vm" {
  value = aws_instance.app.id
}
output "sg" {
  value = aws_security_group.sg.id
}
