resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
resource "local_file" "ssh-key-private" {
  content         = tls_private_key.ssh-key.private_key_pem
  filename        = "${local.dir}/private/ssh-key.pem"
  file_permission = "0600"
}
resource "local_file" "ssh-key-public" {
  content         = tls_private_key.ssh-key.public_key_openssh
  filename        = "${local.dir}/private/ssh.pub"
  file_permission = "0600"
}
output "private-key-file" {
  value = local_file.ssh-key-private.filename
}
