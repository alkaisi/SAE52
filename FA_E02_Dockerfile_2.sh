#!/bin/bash


# Pull the Filebeat image
docker pull docker.elastic.co/beats/filebeat:7.7.1

# Run the Filebeat setup
docker run -it --link elasticsearch --link kibana docker.elastic.co/beats/filebeat:7.7.1 setup -E setup.kibana.host=kibana:5601 -E output.elasticsearch.hosts=["elasticsearch:9200"]
