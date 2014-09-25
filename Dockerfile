#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java:oracle-java7

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz && \
  tar xvzf elasticsearch-1.3.2.tar.gz && \
  rm -f elasticsearch-1.3.2.tar.gz && \
  mv /tmp/elasticsearch-1.3.2 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

ENV SERVICE_9200_ID elasticsearch
ENV SERVICE_9200_NAME elasticsearchmaster


# Expose ports.
#   - 9200: HTTP
EXPOSE 9200


# Define default command.
ENTRYPOINT ["/elasticsearch/bin/elasticsearch", " -Des.config=/elasticsearch/config/elasticsearch.yml"]
