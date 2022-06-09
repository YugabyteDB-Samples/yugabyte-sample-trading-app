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
SCRIPT_URL=${SCRIPT_URL:="https://github.com/yugabyte/yugabyte-sample-trading-app/releases/download/latest/tradex-ubuntu.sh"}
SPRING_ACTIVE_PROFILES=${SPRING_ACTIVE_PROFILES:=ysql,prod,$APP_REGION}
WORK_DIR=${WORK_DIR:=.}
JAVA_OPTS=${JAVA_OPTS:=}
LOG_FILE=${WORK_DIR}/${APP_NAME}.log

function setup(){
  init
  fetch-updates
}
function init(){
  sudo apt update
  sudo apt upgrade -qqy
  sudo apt install openjdk-17-jre -qqy
}
function fetch-updates(){
  wget -O tradex.jar $JAR_URL
  wget -O $SCRIPT $SCRIPT_URL
}
function app-run(){
  INITIAL_YSQL_HOST=${INITIAL_YSQL_HOST:?"INITIAL_YSQL_HOST not set"}
  echo java \
    $JAVA_OPTS \
    -jar tradex.jar  \
    --spring.profiles.active=${SPRING_ACTIVE_PROFILES}  \
    --app.initial-ysql-host=${INITIAL_YSQL_HOST} \
    "$@"
  java \
    $JAVA_OPTS \
    -jar tradex.jar \
    --spring.profiles.active=${SPRING_ACTIVE_PROFILES}  \
    --app.initial-ysql-host=${INITIAL_YSQL_HOST} \
    "$@"
}
function start(){
  nohup $SCRIPT app-run "$@" &> ${LOG_FILE} &
  sleep 1
  echo "App launched"
  status
}
function status(){
  PIDS=$(_pids | tr \\n ' ')
  if [[ $PIDS != "" ]] ; then
    echo "RUNNING: Application running at PIDs [$PIDS]"
  else
    echo "STOPPED"
  fi

}
function _pids(){
  ps -af | grep "java.*-jar tradex.jar.*" | grep -v grep  | awk {'print $2'} || true
}
function logs(){

  tail -f $LOG_FILE
}
function stop(){
  _pids | while read pid; do
    echo "Killing orphaned process $pid"
    kill -9 $pid &>> /dev/null || true
  done
}


OP=$1; shift
[[ $OP == "" ]] && OP=start

$OP "$@"


