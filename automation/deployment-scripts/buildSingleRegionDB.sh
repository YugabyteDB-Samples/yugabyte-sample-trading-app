#! /bin/bash

echo "Single Region DB Actions"

if [ "$#" -ne 1 ]; then
    echo "buildSingleRegionDB.sh <info|clean|migrate>"
    exit 1
fi

source tradex-app-env

docker pull $APP_PROD_DB_DOCKER_IMG_TAG

docker run --rm -e FLYWAY_CLEAN_DISABLED=false  -e FLYWAY_USER=$APP_SINGLE_DB_USER -e FLYWAY_PASSWORD=$APP_SINGLE_DB_PWD -e FLYWAY_URL=jdbc:postgresql://$APP_SINGLE_DB_HOST:5433/$APP_SINGLE_DB_NAME  -e FLYWAY_SCHEMA=public $APP_PROD_DB_DOCKER_IMG_TAG $1




