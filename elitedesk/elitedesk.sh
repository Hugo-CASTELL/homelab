#!/bin/sh

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 {up|down}"
  exit 1
fi

if [ ! -s "./config/tunnel_token" ]; then
  echo "Configuration files missing"
  exit 2
fi

export TUNNEL_TOKEN=$(cat "./config/tunnel_token")

if [ "$1" = "up" ]; then
  docker network create elitedesk-net
  docker compose up --detach
elif [ "$1" = "down" ]; then
  docker compose down
  docker network remove elitedesk-net
else
  echo "Usage: $0 {up|down}"
  exit 1
fi
