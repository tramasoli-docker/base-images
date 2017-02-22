FROM ${DISTRO}:${RELEASE}
LABEL maintainer "Fábio Tramasoli <fabio@tramasoli.com>"
LABEL env=dev
RUN yum -y install openssh-server shadow-utils
COPY ./scripts/Dockerfile-${PURPOSE}.bootstrap /bootstrap.sh
ENV JAVA_HOME=/opt/jdk \
    M2_HOME=/opt/maven \
    PATH=\${PATH}:/opt/jdk/bin:/opt/maven/bin
# installs Subversion, Git, Maven, JDK
RUN echo -e "JAVA_HOME=\${JAVA_HOME}\nM2_HOME=\${M2_HOME}\nPATH=\${PATH}\n" > /etc/environment && \
    yum -y install subversion git tar xmlstarlet&& \
    curl http://www-eu.apache.org/dist/maven/maven-${MVN_MAJOR}/${MVN_MAJOR}.${MVN_MINOR}.${MVN_PATCH}/binaries/apache-maven-${MVN_MAJOR}.${MVN_MINOR}.${MVN_PATCH}-bin.tar.gz \
        -o /tmp/maven.tar.gz && \
    gunzip /tmp/maven.tar.gz && \
    tar -C /opt -xf /tmp/maven.tar && \
    ln -s /opt/apache-maven-${MVN_MAJOR}.${MVN_MINOR}.${MVN_PATCH} /opt/maven && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz ${JVM_URL} && \
    gunzip /tmp/java.tar.gz && \
    tar -C /opt -xf /tmp/java.tar && \
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk && \
    sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=0/ \$JAVA_HOME/jre/lib/security/java.security && \
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/bin/jjs \
           /opt/jdk/jre/bin/orbd \
           /opt/jdk/jre/bin/pack200 \
           /opt/jdk/jre/bin/policytool \
           /opt/jdk/jre/bin/rmid \
           /opt/jdk/jre/bin/rmiregistry \
           /opt/jdk/jre/bin/servertool \
           /opt/jdk/jre/bin/tnameserv \
           /opt/jdk/jre/bin/unpack200 \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/lib/ext/nashorn.jar \
           /opt/jdk/jre/lib/oblique-fonts \
           /opt/jdk/jre/lib/plugin.jar \
           /tmp/*
EXPOSE 22
CMD ["/bin/bash","/bootstrap.sh"]
