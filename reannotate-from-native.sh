#!/bin/bash
while IFS= read -r line; do
  data=`curl -qSfs "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/__nativerw/v1-metadata/$line"`
  if [ "$?" -eq 0 ]; then
  echo -n $data | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/metadata"
  fi
done
