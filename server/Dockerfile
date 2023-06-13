# Base image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y gnupg2 && \
    apt-get install -y software-properties-common && \
    apt-get install -y openjdk-8-jdk

# Set environment variables
ENV SCYLLA_VERSION=5.1

# Download and install ScyllaDB
RUN echo "deb http://downloads.scylladb.com/deb/ubuntu trusty main" | tee /etc/apt/sources.list.d/scylla.list && \
    apt-get update && \
    apt-get install -y scylla=${SCYLLA_VERSION}

# Expose ports
EXPOSE 9042

# Start ScyllaDB
CMD ["scylla"]
