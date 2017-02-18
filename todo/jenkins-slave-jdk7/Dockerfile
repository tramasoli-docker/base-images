FROM ubuntu:15.10
MAINTAINER Fábio Tramasoli <fabio@tramasoli.com>

# Install OpenJDK 7 (latest edition)
RUN apt-get update &&\
    apt-get install -y openjdk-7-jdk &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Standard SSH port
EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
