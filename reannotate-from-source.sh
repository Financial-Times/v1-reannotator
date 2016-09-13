#!/bin/bash
if [ -z "$UPP_USER" ] || [ -z "$UPP_PASSWORD" ] || [ -z "$UPP_HOST" ] || [ -z "$uuidList" ] || [ -z "$QMI_USER" ] || [ -z "$QMI_PASSWORD" ]; then
  echo "One of the required environment variables are not set up. Please correct"
  exit 2
fi


echo "Started reannotate v1-metadata from Binding Service"
sources=`cat sources`
for uuid in ${uuidList}; do
  echo "Processing $uuid"
  for source in $sources; do
	  status=`curl -qsL -w "%{http_code}" -H"ClientUserPrincipal: app-preditor" --digest -u "$QMI_USER:$QMI_PASSWORD" "http://metadata.internal.ft.com/metadata-services/binding/1.0/sources/$source/references/$uuid?includeTermAttrs=true&inflate=MAX" -o /dev/null 2>/dev/null`
	  if [ "$status" == "200" ]; then
		  echo "$uuid found in source $source"
		  data=`curl -qSfsL -H"ClientUserPrincipal: app-preditor" --digest -u "$QMI_USER:$QMI_PASSWORD" "http://metadata.internal.ft.com/metadata-services/binding/1.0/sources/$source/references/$uuid?includeTermAttrs=true&inflate=MAX" 2>/dev/null`
		  echo -n $data | go run json_envelope.go --uuid=$uuid | curl -i -d @- -X POST -H "Content-Type: application/json" -H"X-Origin-System-Id: binding-service" "https://$UPP_USER:$UPP_PASSWORD@$UPP_HOST/metadata"
		  break
	  else
	    echo ">$uuid cannot be obtained from Binding Service. Status: $status"
	  fi
  done
done
echo "Finished"
