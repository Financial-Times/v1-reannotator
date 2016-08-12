#!/bin/bash
while IFS= read -r line; do
  data=`curl -qSfs  -H"ClientUserPrincipal: app-preditor" --digest -u "xxx:xxx" "http://metadata.internal.ft.com/metadata-services/binding/1.0/sources/METHODE/references/$line?includeTermAttrs=true&inflate=MAX"`
  if [ "$?" -eq 0 ]; then
  echo -n $data | go run json_envelope.go --uuid=$line | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://upp-publishing-prod:xxx@pub-prod-uk-up.ft.com/metadata"
  fi
done

