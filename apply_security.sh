#!/bin/sh

curl -XPUT 'http://elastic:changeme@localhost:9200/_xpack/security/user/elastic/_password' -H "Content-Type: application/json" -d '{
  "password" : "elastic"
}'
