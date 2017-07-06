#!/bin/sh

# usefull advices :
# https://www.elastic.co/guide/en/x-pack/5.4/security-getting-started.html#security-getting-started
# https://www.elastic.co/guide/en/x-pack/current/security-privileges.html

# Change default password
curl -XPUT 'http://elastic:changeme@localhost:9200/_xpack/security/user/elastic/_password' -H "Content-Type: application/json" -d '{
  "password" : "elastic"
}'

# Set roles
#
curl -XPOST 'elastic:elastic@localhost:9200/_xpack/security/role/role_admin' -H "Content-Type: application/json" -d '{
  "cluster": ["all"],
  "indices" : [
    {
      "names" : [ "*" ],
      "privileges" : [ "all" ]
    }
  ]
}'

curl -XPOST 'elastic:elastic@localhost:9200/_xpack/security/role/role_user' -H "Content-Type: application/json" -d '{
  "indices" : [
    {
      "names" : [ "test_*" ],
      "privileges" : [ "read", "index" ]
    }
  ]
}'

# Set users
#
curl -XPOST 'elastic:elastic@localhost:9200/_xpack/security/user/admin' -H "Content-Type: application/json" -d '{
  "password" : "adminpass",
  "full_name" : "Aministrator",
  "email" : "admin@example.com",
  "roles" : [ "role_admin" ]
}'

curl -XPOST 'elastic:elastic@localhost:9200/_xpack/security/user/user' -H "Content-Type: application/json" -d '{
  "password" : "userpass",
  "full_name" : "User",
  "email" : "user@example.com",
  "roles" : [ "role_user" ]
}'

# Show applied settings
echo "\nRoles :"
curl -s -XGET 'elastic:elastic@localhost:9200/_xpack/security/role/role_admin' | python -mjson.tool
curl -s -XGET 'elastic:elastic@localhost:9200/_xpack/security/role/role_user' | python -mjson.tool
echo "\nUsers :"
curl -s -XGET 'elastic:elastic@localhost:9200/_xpack/security/user/admin' | python -mjson.tool
curl -s -XGET 'elastic:elastic@localhost:9200/_xpack/security/user/user' | python -mjson.tool
