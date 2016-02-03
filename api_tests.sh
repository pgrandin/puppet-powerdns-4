auth="-H 'X-API-Key: changeme'"

curl ${auth} http://127.0.0.1:8081/api/v1/servers/localhost/zones
curl ${auth} -X POST --data '{"name":"example.org.", "kind": "Native", "masters": [], "nameservers": ["ns1.example.org.", "ns2.example.org."]}' -v http://127.0.0.1:8081/api/v1/servers/localhost/zones
curl ${auth} http://127.0.0.1:8081/api/v1/servers/localhost/zones
