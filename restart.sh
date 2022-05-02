#!/bin/sh

getopts "env" env;
server_host='localhost';
if [ [$env = 'prod'] ]; then
  $server_host = 'aaaaa'
fi

export SERVER_HOST=$server_host
docker-compose down
docker-compose up
