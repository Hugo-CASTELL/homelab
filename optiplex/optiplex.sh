#!/bin/sh

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 {up|down}"
  exit 1
fi

if [ "$1" = "up" ]; then
  docker network create optiplex-net
  docker compose up --detach
elif [ "$1" = "down" ]; then
  docker compose down
  docker network remove optiplex-net
else
  echo "Usage: $0 {up|down}"
  exit 1
fi
