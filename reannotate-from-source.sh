#!/bin/bash
sources=`cat sources`
while IFS= read -r line; do
  echo "Processing $line"
  for source in $sources; do
	  status=`curl -qsL -w "%{http_code}" -H"ClientUserPrincipal: app-preditor" --digest -u "xxx:xxx" "http://metadata.internal.ft.com/metadata-services/binding/1.0/sources/$source/references/$line?includeTermAttrs=true&inflate=MAX" -o /dev/null 2>/dev/null`
	  if [ "$status" == "200" ]; then
		  echo "$line found in source $source"
		  data=`curl -qSfsL -H"ClientUserPrincipal: app-preditor" --digest -u "xxx:xxx" "http://metadata.internal.ft.com/metadata-services/binding/1.0/sources/$source/references/$line?includeTermAttrs=true&inflate=MAX" 2>/dev/null`
		  #echo "$data"
		  echo -n $data | go run json_envelope.go --uuid=$line | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://upp-publishing-prod:xxx@pub-prod-uk-up.ft.com/metadata"
		  break
	  fi
  done
done
