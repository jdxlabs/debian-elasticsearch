# debian-elasticsearch
ElasticSearch 5.4.1 on Debian 8

## Instructions

### Launch it
Before you start this container make sure to set the max_map_count on your docker host.  
sudo sysctl vm.max_map_count=262144

docker build -t debian-es .  
docker run -d -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" --name=debian-es debian-es  
curl http://elastic:changeme@localhost:9200  
should return :  
```
{
  "name" : "docker-image",
  "cluster_name" : "babidi",
  "cluster_uuid" : "0z15Rh-mSZiLE8n_vCBMQg",
  "version" : {
    "number" : "5.4.1",
    "build_hash" : "2cfe0df",
    "build_date" : "2017-05-29T16:05:51.443Z",
    "build_snapshot" : false,
    "lucene_version" : "6.5.1"
  },
  "tagline" : "You Know, for Search"
}
```
### Execute it
docker exec -it debian-es sh

### Stop it
docker stop -t0 debian-es && docker rm debian-es
