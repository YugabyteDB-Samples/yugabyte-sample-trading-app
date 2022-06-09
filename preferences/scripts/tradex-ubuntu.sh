#!/usr/bin/env bash
# Get this script via wget
# wget https://github.com/yugabyte/yugabyte-sample-trading-app/releases/download/latest/tradex-ubuntu.sh

set -Eeuo pipefail
APP_NAME=tradex
APP_REGION=${APP_REGION:-ap}
SCRIPT="${BASH_SOURCE[0]}"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$( cd ${SCRIPT_DIR} ; pwd)
JAR_URL=${JAR_URL:="https://github.com/yugabyte/yugabyte-sample-trading-app/releases/download/latest/tradex-0.0.1-SNAPSHOT.jar"}
SCRIPT_URL=${JAR_URL:="https://github.com/yugabyte/yugabyte-sample-trading-app/releases/download/latest/tradex-ubuntu.sh"}
SPRING_ACTIVE_PROFILES=${SPRING_ACTIVE_PROFILES:=ysql,prod,$APP_REGION}
WORK_DIR=${WORK_DIR:=.}
JAVA_OPTS=${JAVA_OPTS:=}
LOG_FILE=${WORK_DIR}/${APP_NAME}.log
PID_FILE=${WORK_DIR}/${APP_NAME}.pid

function setup(){
  sudo apt update
  sudo apt upgrade -qqy
  sudo apt install openjdk-17-jre -qqy
  wget -O tradex.jar $JAR_URL
  wget -O $SCRIPT $SCRIPT_URL
}
function fetch-updates(){
  wget -O tradex.jar $JAR_URL
  wget -O $SCRIPT https://github.com/yugabyte/yugabyte-sample-trading-app/releases/download/latest/tradex-ubuntu.sh
}
function app-run(){
  INITIAL_YSQL_HOST=${INITIAL_YSQL_HOST:?"INITIAL_YSQL_HOST not set"}
  echo java -jar tradex.jar  \
    $JAVA_OPTS \
    --spring.profiles.active=${SPRING_ACTIVE_PROFILES}  \
    --app.initial-ysql-host=${INITIAL_YSQL_HOST} \
    "$@"
  java -jar tradex.jar  \
    $JAVA_OPTS \
    --spring.profiles.active=${SPRING_ACTIVE_PROFILES}  \
    --app.initial-ysql-host=${INITIAL_YSQL_HOST} \
    "$@"
}
function start(){
  nohup $SCRIPT app-run "$@" &> ${LOG_FILE} &
  echo $! > ${PID_FILE}
}
function status(){
  if [[ -e $PID_FILE ]] ; then
    echo "RUNNING: Application running at PID [`cat ${PID_FILE}`]"
  else
    echo "STOPPED"
  fi
}
function logs(){
  tail -f $LOG_FILE
}
function stop(){
  kill -9 $(cat ${PID_FILE})
  rm ${PID_FILE}
}


OP=$1; shift
[[ $OP == "" ]] && OP=start

$OP "$@"


