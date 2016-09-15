# v1-reannotator

Tool used to reannotate content with v1 metadata.
* Publishing cluster credentials in lastpass("CoCo Basic Auth")
* Binding service credentials in lastpass("structure service auth prod")

Pre-requisites:
* curl
* go

# Usage
Reannotate from native store:

```
export UPP_USER=...
export UPP_PASSWORD=...
export uuidList="list of uuids..."
```
`./reannotate-from-native.sh`

Reannotate from source(binding-service):

```
export UPP_USER=...
export UPP_PASSWORD=...
export uuidList="list of uuids..."
export QMI_USER=...
export QMI_PASSWORD=...
```
`./reannotate-from-source.sh`

# Expected Output
```
$ ./reannotate-from-source.sh
Started reannotate v1-metadata from Binding Service
Processing 017623ac-7308-11e6-b60a-de4532d5ea35
017623ac-7308-11e6-b60a-de4532d5ea35 found in source METHODE
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5059    0     0  100  5059      0  15470 --:--:-- --:--:-- --:--:-- 16214HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Accept-Ranges: bytes
Age: 0
Content-Type: application/json; charset=utf-8
Date: Mon, 05 Sep 2016 11:41:06 GMT
Via: 1.1 varnish-v4
X-Cache: MISS
X-Request-Id: tid_bf6livimuy
X-Varnish: 9269075
Content-Length: 0
Connection: keep-alive

Finished
```

# Notes

If you are running on windows you might have an issue with line terminators. Therefore if you get only the following (you should get more output) when trying to reannotate from source then you probably have an issue:

`$ ./reannotate-from-source.sh
Processing 017623ac-7308-11e6-b60a-de4532d5ea35`

`dos2unix.exe *`

