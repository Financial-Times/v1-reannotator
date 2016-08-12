# v1-reannotator

Tool used to reannotate content with v1 metadata.
* Publishing cluster credentials in lastpass("CoCo Basic Auth")
* Binding service credentials in lastpass("structure service auth prod")

Pre-requisites:
* curl
* go

# Usage
Reannotate from native store:    
`cat uuids | ./reannotate-from-native.sh`

Reannotate from source(binding-service):   
`cat uuids | ./reannotate-from-source.sh`

