data "http" "workstation-ip" {
  url = "https://ifconfig.me"
}
locals {
  workstation-ip = chomp(data.http.workstation-ip.response_body)
}
