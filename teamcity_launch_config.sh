#!/bin/bash

ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`

download() {
  echo "Pulling teamcity server and agent latest"
  docker pull jetbrains/teamcity-server
  docker pull marcincuber/teamcity-agent
}

start() {
  echo "Check for data/logs directories"
  if [ ! -d "$(pwd)/data" ]; then
    mkdir $(pwd)/data
  fi
  if [ ! -d "$(pwd)/logs" ]; then
    mkdir $(pwd)/logs
  fi

  echo "Starting Teamcity Server"
  docker run -d --rm --name teamcity-server-instance  \
    -e TEAMCITY_SERVER_MEM_OPTS="-Xmx2g -XX:MaxPermSize=1024m -XX:ReservedCodeCacheSize=1024m" \
    -v $(pwd)/data/:/data/teamcity_server/datadir \
    -v $(pwd)/logs/:/opt/teamcity/logs  \
    -p 8111:8111 \
    jetbrains/teamcity-server

  echo "You can access your instance at ${ip}:8111"
}

stop() {
  echo "Stopping Teamcity Server"
  docker stop teamcity-server-instance
}

restart() {
  stop
  sleep 5
  start
}

backup() {
  echo "Stopping Teamcity Server"
  stop
  sleep 5

  echo "Starting backup"
  docker run -d --rm --name teamcity-server-instance  \
    -v $(pwd)/data/:/data/teamcity_server/datadir  \
    -v $(pwd)/logs/:/opt/teamcity/logs  \
    -p 8111:8111 \
    jetbrains/teamcity-server \
    "/opt/teamcity/bin/maintainDB.sh" "backup"
  sleep 5

  echo "Starting Teamcity Server"
  start
}

add_agent_1() {
  echo "Check for agent_1/data directories required for agent initialisation"
  if [ ! -d "$(pwd)/agent_1/data" ]; then
    mkdir -p $(pwd)/agent_1/data
  fi
  echo "Connecting Teamcity Agent"
  docker run -d --rm --name teamcity_agent_1  \
    -e SERVER_URL="http://${ip}:8111/"  \
    -v $(pwd)/agent_1/data/:/data/teamcity_agent/conf  \
    marcincuber/teamcity-agent
}

add_agent_2() {
  docker run -d --rm --name teamcity_agent_2  \
    -e SERVER_URL="http://${ip}:8111/"  \
    -v $(pwd)/agent_2/data/:/data/teamcity_agent/conf  \
    jetbrains/teamcity-minimal-agent
}

stop_agent_1() {
  docker stop teamcity_agent_1
}

stop_agent_2() {
  docker stop teamcity_agent_2
}

script_result=0

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  download)
    download
    ;;
  backup)
    backup
    ;;
  add_agent_1)
    add_agent_1
    ;;
  add_agent_2)
    add_agent_2
    ;;
  stop_agent_1)
    stop_agent_1
    ;;
  stop_agent_2)
    stop_agent_2
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|download|backup|add_agent_1|add_agent_2|stop_agent_1|stop_agent_2}"
    script_result=1
  ;;
esac

exit $script_result
