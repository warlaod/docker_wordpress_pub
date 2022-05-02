#!/bin/sh

getopts e: env;
server_host='localhost';

if [ "$OPTARG" = "prod" ]; then
  server_host="erostinger.com";
fi

echo "SERVER_HOST: $server_host"

export SERVER_HOST=$server_host
docker-compose down
docker-compose rm -f
docker-compose pull
docker-compose up --build --remove-orphans
