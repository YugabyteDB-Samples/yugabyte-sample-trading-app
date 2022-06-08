#!/usr/bin/env bash

set -Eeuo pipefail
APP_NAME=tradex
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$( cd ${SCRIPT_DIR} ; pwd)
JAR_URL=${JAR_URL:="https://github.com/yugabyte/yugabyte-sample-trading-app/releases/download/refs%2Fheads%2Fmain/tradex-0.0.1-SNAPSHOT.jar"}
INITIAL_YSQL_HOST=${INITIAL_YSQL_HOST:=127.0.0.3}
TOPOLOGY_KEYS=${TOPOLOGY_KEYS:=aws.ap-southeast-1.ap-southeast-1c}
WORK_DIR=${WORK_DIR:=.}
JAVA_OPTS=${JAVA_OPTS:=}
SPRING_ACTIVE_PROFILES=${SPRING_ACTIVE_PROFILES:=ysql,prod}
LOG_FILE=${WORK_DIR}/${APP_NAME}.log
PID_FILE=${WORK_DIR}/${APP_NAME}.pid

function setup(){
  sudo apt update
  sudo apt upgrade -qqy
  sudo apt install openjdk-17-jdk openjdk-17-jre -qqy
  # Get this from the github project page https://github.com/yugabyte/yugabyte-sample-trading-app/releases/latest
  wget -O tradex.jar $JAR_URL
}
function run(){
  echo java -jar tradex.jar  \
      $JAVA_OPTS \
      --spring.flyway.enabled=${SPRING_FLYWAY_ENABLED} \
      --spring.profiles.active=${SPRING_ACTIVE_PROFILES}  \
      --app.topology-keys=${TOPOLOGY_KEYS}  \
      --app.initial-ysql-host=${INITIAL_YSQL_HOST} \
      $*
  java -jar tradex.jar  \
        $JAVA_OPTS \
        --spring.flyway.enabled=${SPRING_FLYWAY_ENABLED} \
        --spring.profiles.active=${SPRING_ACTIVE_PROFILES}  \
        --app.topology-keys=${TOPOLOGY_KEYS}  \
        --app.initial-ysql-host=${INITIAL_YSQL_HOST} \
        $*

}
function start(){
  nohup run $* &> ${LOG_FILE} &
  echo $! > ${PID_FILE}
}
function stop(){
  kill -9 $(cat ${PID_FILE})
  rm ${PID_FILE}
}


OP=$1; shift
[[ $OP == "" ]] && OP=start

$OP $*


