#!/bin/bash

if [ -z "$UPP_USER" ] || [ -z "$UPP_PASSWORD" ] || [ -z "$UPP_HOST" ] || [ -z "$uuidList" ]; then
  echo "One of the required environment variables are not set up. Please correct"
  exit 2
fi

echo "Started reannotate v1-metadata from Native Store"
for uuid in ${uuidList}; do
  echo "Processing $uuid"
  debug=`curl -i "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/__nativerw/v1-metadata/$uuid"`
  data=`curl -qSfs "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/__nativerw/v1-metadata/$uuid"`
  if [ "$?" -eq 0 ]; then
    echo "Found $uuid in Native Store. Republishing..."
    echo -n $data | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/metadata"
  else
    echo ">$uuid not found in Native Store. Data: $debug"
  fi
done
echo "Finished"
