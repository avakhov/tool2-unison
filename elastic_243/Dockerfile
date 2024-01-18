# Use an ARM64 base image
FROM openjdk:8-jre

# Set Elasticsearch version
ENV ES_VERSION 2.4.3

# Download and install Elasticsearch
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz && \
    tar -xzvf elasticsearch-${ES_VERSION}.tar.gz && \
    mv elasticsearch-${ES_VERSION} /elasticsearch && \
    rm elasticsearch-${ES_VERSION}.tar.gz

# Expose the Elasticsearch ports
EXPOSE 9200 9300

# Set the default command to run Elasticsearch
CMD ["/elasticsearch/bin/elasticsearch"]


