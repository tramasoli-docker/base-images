FROM tramasoli/base-images:centos7-jenkins-jdk-8.121
LABEL maintainer "Fábio Tramasoli <fabio@tramasoli.com>"
LABEL env=dev
COPY ./scripts/Dockerfile-angular-cli.bootstrap /bootstrap.sh
# installs Node and Angular-cli
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - && \
    yum -y --disableplugin=fastestmirror install gcc-c++ make nodejs && \
    npm install -g @angular/cli@1.0.0-rc.4 && \
    yum clean all && \
    rm -rf /tmp/*
RUN yum -y --disableplugin=fastestmirror install jq
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]
