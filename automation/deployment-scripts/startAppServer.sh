#! /bin/bash

echo "Starting Application"

source /home/ubuntu/instance-info

source /home/ubuntu/tradex-scripts/tradex-app-env

sudo docker run -v /home/ubuntu/tls.p12:/app/tls.p12:ro --restart=always --pull=always -d --name tradex-app \
  -e APP_INSTANCE_LOCATION=$APP_INSTANCE_LOCATION  --env-file /home/ubuntu/tradex-scripts/tradex-app-env --hostname tradex-app -p 443:443 $APP_PROD_DOCKER_IMG_TAG \
    --server.ssl.protocol=TLS --server.ssl.enabled-protocols=TLSv1.2 --server.ssl.enabled=true --server.ssl.key-store-type=PKCS12 --server.ssl.key-store=/app/tls.p12 --server.ssl.key-store-password=changeit --server.port=443

sleep 5

mkdir /home/ubuntu/applogs

docker logs --follow  tradex-app  >  /home/ubuntu/applogs/tradex-app.log &

docker ps 


