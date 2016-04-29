#!/bin/bash
while IFS= read -r line; do
  curl -X GET -H"ClientUserPrincipal: app-preditor" --digest -u "xxx:xxx" "http://metadata.internal.ft.com/metadata-services/binding/1.0/sources/METHODE/references/$line?includeTermAttrs=true&inflate=MAX" | ./json_envelope --uuid=$line | curl -i -d @- -X PUT -H "Content-Type: application/json" "https://prod-us-up.ft.com/__up-queue-sender-v1-metadata/message/$line"
done
