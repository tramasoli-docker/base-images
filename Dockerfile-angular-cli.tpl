FROM ${DISTRO}:${RELEASE}
LABEL maintainer "Fábio Tramasoli <fabio@tramasoli.com>"
LABEL env=dev
RUN yum -y install openssh-server shadow-utils
COPY ./scripts/Dockerfile-${PURPOSE}.bootstrap /bootstrap.sh
# installs Subversion, Git, Maven, JDK
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - && \
    yum -y install gcc-c++ make nodejs subversion git tar xmlstarlet && \
    npm install -g @angular/cli@1.0.0-rc.4
    yum clean all && \
    rm -rf /tmp/*
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]
