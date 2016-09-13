#!/bin/bash

if [ -z "$UPP_USER" ] || [ -z "$UPP_PASSWORD" ] || [ -z "$UPP_HOST" ]; then
  echo "One of the required environment variables are not set up. Please correct"
  exit 2
fi

echo "Started reannotate v1-metadata from Native Store"
while IFS= read -r line; do
  echo "Processing $line"
  data=`curl -qSfs "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/__nativerw/v1-metadata/$line"`
  if [ "$?" -eq 0 ]; then
    echo "Found $line in Native Store. Republishing..."
    echo -n $data | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/metadata"
  else
    echo ">$line not found in Native Store"
  fi
done
echo "Finished"
