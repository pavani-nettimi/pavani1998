#!/bin/bash

# Usage: ./app_health.sh <APP_URL>

APP_URL=$1

if [ -z "$APP_URL" ]; then
  echo "Usage: $0 <APP_URL>"
  exit 1
fi

STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$APP_URL")

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "Application is UP (HTTP $STATUS_CODE)"
else
  echo "Application is DOWN or unhealthy (HTTP $STATUS_CODE)"
fi
