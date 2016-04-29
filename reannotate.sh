#!/bin/bash
while IFS= read -r line; do
  curl "https://prod-us-up.ft.com/__nativerw/v1-metadata/$line" | curl -i -d @- -X PUT -H "Content-Type: application/json" "https://prod-us-up.ft.com/__up-queue-sender-v1-metadata/message/$line"
done
