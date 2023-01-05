#!/usr/bin/env bash

set -Eeuo pipefail
# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# PROJECT_DIR=$( cd ${SCRIPT_DIR}/.. ; pwd)

curl -fsSL https://get.docker.com | sudo bash
sudo usermod -aG docker ubuntu
sudo docker run \
  -v /home/ubuntu/tls.p12:/tls.p12:ro \
  --restart=always --pull=always -d \
  --name app \
  --hostname app \
  -p 443:443 \
  docker.io/yogendra/spring-boot-web  \
  --server.port=443
  --server.ssl.protocol=TLS \
  --server.ssl.enabled-protocols=TLSv1.2 \
  --server.ssl.enabled=true \
  --server.ssl.key-store-type=PKCS12 \
  --server.ssl.key-store=/tls.p12 \
  --server.ssl.key-store-password=changeit \
