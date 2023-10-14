#!/bin/bash


# Pull the Elasticsearch Docker image
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.1

# Start a single-node cluster with Docker
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.1


# Pull the Kibana Docker image
docker pull docker.elastic.co/kibana/kibana:7.7.1

# Run Kibana on Docker for development
docker run -d --name kibana --link elasticsearch -p 5601:5601 docker.elastic.co/kibana/kibana:7.7.1