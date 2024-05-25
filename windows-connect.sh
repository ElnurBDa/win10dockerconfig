#!/bin/bash

# https://github.com/ElnurBDa/win10dockerconfig

COMPOSE_FILE=~/Utils/win10dockerconfig/docker-compose.yml
container_name="windows" 
running_container=$(docker ps --filter "name=$container_name" --filter "status=running" -q)

if [ -z "$running_container" ]; then
  echo "Starting Docker Compose services..."
  docker compose -f $COMPOSE_FILE up -d
  echo "Waiting for services to start..."
  sleep 10
else
  echo "Container is already running."
fi

container_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_name)

if [ -z "$container_ip" ]; then
  echo "Failed to get container IP address. Exiting."
  exit 1
fi

echo "Connecting to container at IP $container_ip..."

xfreerdp3 /v:$container_ip /u:docker /dynamic-resolution /p:''



