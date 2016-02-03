import requests
import json

base_url="http://127.0.0.1:8081/api/v1"
headers = {'content-type': 'application/json','X-API-Key': 'changeme'}

# when starting the tests, the zone should be empty
r = requests.get("%s/servers/localhost/zones" % base_url , headers=headers)
j=r.json()
assert len(j) == 0

payload = {"name":"example.org.", "kind": "Native", "masters": [], "nameservers": ["ns1.example.org.", "ns2.example.org."]}
r = requests.post("%s/servers/localhost/zones" % base_url, data=json.dumps(payload), headers=headers)
print r.text

r = requests.get("%s/servers/localhost/zones" % base_url , headers=headers)
j=r.json()
assert len(j) == 1
