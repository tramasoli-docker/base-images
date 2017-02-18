FROM centos:7
MAINTAINER Fábio Tramasoli <fabio@tramasoli.com>
LABEL env=dev
RUN yum -y install openssh-server shadow-utils
COPY ../../scripts/ssh-bootstrap.sh /bootstrap.sh
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]

FROM centos:7
MAINTAINER Fábio Tramasoli <fabio@tramasoli.com>

RUN yum -y install openssh-server shadow-utils
COPY ../../scripts/ssh-bootstrap.sh /bootstrap.sh

# Install JDK 8 (latest edition)
RUN apt-get update &&\
    apt-get install -y openjdk-8-jdk &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Standard SSH port
EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
