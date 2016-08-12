#!/bin/bash
while IFS= read -r line; do
  data=`curl -qSfs "https://upp-publishing-prod:xxx@pub-prod-uk-up.ft.com/__nativerw/v1-metadata/$line"`
  if [ "$?" -eq 0 ]; then
  echo -n $data | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://upp-publishing-prod:xxx@pub-prod-uk-up.ft.com/metadata"
  fi
done
