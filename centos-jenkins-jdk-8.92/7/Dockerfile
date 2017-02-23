FROM centos:7
LABEL maintainer "Fábio Tramasoli <fabio@tramasoli.com>"
LABEL env=dev
RUN yum -y install openssh-server shadow-utils
COPY ./scripts/Dockerfile-jenkins.bootstrap /bootstrap.sh
ENV JAVA_HOME=/opt/jdk     M2_HOME=/opt/maven     PATH=${PATH}:/opt/jdk/bin:/opt/maven/bin
# installs Subversion, Git, Maven, JDK
RUN echo -e "JAVA_HOME=${JAVA_HOME}\nM2_HOME=${M2_HOME}\nPATH=${PATH}\n" > /etc/environment &&     yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(cat /etc/redhat-release | grep -oP "[0-9]*\.[0-9]*" | cut -d"." -f1).noarch.rpm &&     yum install -y subversion git tar xmlstarlet &&     curl http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz         -o /tmp/maven.tar.gz &&     gunzip /tmp/maven.tar.gz &&     tar -C /opt -xf /tmp/maven.tar &&     ln -s /opt/apache-maven-3.3.9 /opt/maven &&     curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz &&     gunzip /tmp/java.tar.gz &&     tar -C /opt -xf /tmp/java.tar &&     ln -s /opt/jdk1.8.0_92 /opt/jdk &&     sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=0/ $JAVA_HOME/jre/lib/security/java.security &&     yum clean all &&     rm -rf /tmp/*
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]
