#!/bin/bash

# Restart containers
# Elasticsearch
docker restart elasticsearch

# Kibana
docker restart kibana

# Filebeat
docker restart filebeat

# Apache
docker restart my-apache-app