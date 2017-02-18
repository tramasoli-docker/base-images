# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:15.10
MAINTAINER Fábio Tramasoli <fabio@tramasoli.com>

# Install and configure a basic SSH server
RUN apt-get update &&\
    apt-get install -y openssh-server &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd
    
# Set user jenkins to the image
RUN adduser --quiet jenkins --home 	/var/jenkins_home &&\
    echo "jenkins:jenkins" | chpasswd

# Install SCM and build tools
RUN apt-get update &&\
    apt-get install -y git subversion maven &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*
    
RUN echo -e "mkdir -p /var/jenkins_home/.subversion\nif [ ! -z \"\$http_proxy\" ]; then\n\techo -e \"[global]\\nhttp-proxy-host = \${http_proxy%:*}\\nhttp-proxy-port = \${http_proxy##*:}\\n\"\nfi\n" > /bootstrap.sh &&\
    echo -e "/usr/sbin/sshd -D" >> /bootstrap.sh

# Standard SSH port
EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
