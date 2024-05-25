#!/bin/bash

COMPOSE_FILE=~/Utils/win10dockerconfig/docker-compose.yml

container_name="windows" 
running_container=$(docker ps --filter "name=$container_name" --filter "status=running" -q)

if [ -z "$running_container" ]; then
  echo "Container is not running."
else
  echo "Stopping Docker Compose services..."
  docker compose -f $COMPOSE_FILE down
  echo "Services stopped."
fi


