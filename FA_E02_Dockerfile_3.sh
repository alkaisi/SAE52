#!/bin/bash


# Install curl command
apt install curl

# Example configuration file
curl -L -O https://raw.githubusercontent.com/elastic/beats/7.7/deploy/docker/filebeat.docker.yml

# Volume-mounted configuration
docker run -d --link elasticsearch --link kibana --name=filebeat --user=root --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" --volume="/var/run/docker.sock:/var/run/docker.sock:ro" docker.elastic.co/beats/filebeat:7.7.1 filebeat -e -strict.perms=false -E output.elasticsearch.hosts=["elasticsearch:9200"]

# Customize your configuration
docker run --label co.elastic.logs/module=apache2 --label co.elastic.logs/fileset.stdout=access --label co.elastic.logs/fileset.stderr=error --label co.elastic.metrics/module=apache --label co.elastic.metrics/metricsets=status --label co.elastic.metrics/hosts='${data.host}:${data.port}' --detach=true --name my-apache-app -p 8080:80 httpd:2.4