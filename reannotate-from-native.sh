#!/bin/bash

if [ -z "$UPP_USER" ] || [ -z "$UPP_PASSWORD" ] || [ -z "$UPP_HOST" ] || [ -z "$uuidList" ]; then
  echo "One of the required environment variables are not set up. Please correct"
  exit 2
fi

echo "Started reannotate v1-metadata from Native Store"
for uuid in ${uuidList}; do
  echo "Processing $uuid"
  status=`url -qsL -w "%{http_code}" "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/__nativerw/v1-metadata/$uuid" -o /dev/null 2>/dev/null`
  if [ "$status" == "200" ]; then
    data=`curl -qSfs "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/__nativerw/v1-metadata/$uuid"`
    echo "Found $uuid in Native Store. Republishing..."
    echo -n $data | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/metadata"
  else
    echo ">$uuid cannot be obtained from Native Store. Status: $status"
  fi
done
echo "Finished"
