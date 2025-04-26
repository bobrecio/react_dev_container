#!/bin/bash

APP_NAME=$1

if [ -z "$APP_NAME" ]; then
  echo "Usage: ./switch-app.sh <app-name>"
  exit 1
fi

sed -i.bak -E "s/(APP_PATH: ).*/\1$APP_NAME/" docker-compose.yml
sed -i.bak -E "s/(APP_PATH=).*/\1$APP_NAME/" docker-compose.yml

echo
echo "Switched to $APP_NAME. Rebuilding Docker container..."
echo

docker-compose down
docker-compose up --build
