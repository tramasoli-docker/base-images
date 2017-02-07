FROM oraclelinux:6
MAINTAINER Fábio Tramasoli <fabio@tramasoli.com>
LABEL env=des
RUN yum -y install openssh-server shadow-utils
RUN echo -e "service sshd start && service sshd stop && echo \"root:hackme\" | chpasswd && /usr/sbin/sshd -D" > /bootstrap.sh
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]
