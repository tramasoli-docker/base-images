FROM tramasoli/base-images:centos7-jenkins-jdk-8.121
LABEL maintainer "Fábio Tramasoli <fabio@tramasoli.com>"
LABEL env=dev
COPY ./scripts/Dockerfile-docker-client.bootstrap /bootstrap.sh
# installs Node and Angular-cli
RUN yum install -y yum-utils && \
    yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo && \
    yum-config-manager --disable docker-ce-edge && \
    yum install -y docker-ce && \
    yum clean all && \
    rm -rf /tmp/*
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]
