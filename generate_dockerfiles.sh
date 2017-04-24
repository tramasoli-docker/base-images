#!/bin/bash
#set -x

#region VARS

BASEPATH=`dirname $0`
TEMP_DIR="/tmp/gendocker"
SSH_SERVER_DISTROS=(centos oraclelinux)
SSH_SERVER_DISTROS_VERSION=(6 7 8)

JAVA_VERSIONS=(7-80-15 8-92-14 8-102-14 8-111-14 8-121-13-e9e7ea248e2c4826b92b3f075a80e441)

#JAVA_VERSION_MAJOR=8
#JAVA_VERSION_MINOR=121
#JAVA_VERSION_BUILD=13
JAVA_PACKAGE=jdk

MVN_MAJOR=3
MVN_MINOR=3
MVN_PATCH=9

#endregion VARS


#region FUNC

help() {
  echo "*** Aren't you missing something? ;)"
  echo "Please provide one of the following options:"
  echo "  ssh - if you want to generate the ssh server dockerfiles for ${SSH_SERVER_DISTROS[@]} versions ${SSH_SERVER_DISTROS_VERSION[@]}"
  #echo * java - apline images for java ${JVM_FLAVORS[@]}
}

generate_ssh_dockerfile() {
  PURPOSE="ssh"
  DOCKERFILE_TPL="${BASEPATH}/Dockerfile-${PURPOSE}.tpl"
  for DISTRO in ${SSH_SERVER_DISTROS[@]}; do
    for RELEASE in ${SSH_SERVER_DISTROS_VERSION[@]}; do
      DOCKERFILEDIR="${BASEPATH}/${DISTRO}-${PURPOSE}/${RELEASE}"
      mkdir -p ${DOCKERFILEDIR}/scripts ${TEMP_DIR}/${DOCKERFILEDIR}
      /bin/cp ${BASEPATH}/Dockerfile-${PURPOSE}.bootstrap ${DOCKERFILEDIR}/scripts
      eval "cat <<EOF > ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile
$(<$DOCKERFILE_TPL)
EOF" > /dev/null
      if [ "`md5sum ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile| awk '{print $1}'`" != "`md5sum ${DOCKERFILEDIR}/Dockerfile| awk '{print $1}'`" ]; then
        /bin/cp ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile ${DOCKERFILEDIR}/Dockerfile
        echo "- You *must* 'git add ${DOCKERFILEDIR}/Dockerfile', it has been changed!!!"
      else
        echo "- File '${DOCKERFILEDIR}/Dockerfile' it's already ok!"
      fi
      /bin/rm ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile
    done
  done
}

generate_jenkins_dockerfile() {
  PURPOSE="jenkins"
  DOCKERFILE_TPL="${BASEPATH}/Dockerfile-${PURPOSE}.tpl"
  for DISTRO in ${SSH_SERVER_DISTROS[@]}; do
    for RELEASE in ${SSH_SERVER_DISTROS_VERSION[@]}; do
	for version in ${JAVA_VERSIONS[@]}; do
		JAVA_VERSION_MAJOR=$(echo $version | cut -d- -f1)
		JAVA_VERSION_MINOR=$(echo $version | cut -d- -f2)
		JAVA_VERSION_BUILD=$(echo $version | cut -d- -f3)
		JAVA_VERSION_TEMP=$(echo $version | cut -d- -f4)
		if [ "${JAVA_VERSION_MINOR}" -ge 121 ]; then
			JVM_URL="http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_VERSION_TEMP}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz"
		else
			JVM_URL="http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz"
		fi
	        DOCKERFILEDIR="${BASEPATH}/${DISTRO}-${PURPOSE}-${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}.${JAVA_VERSION_MINOR}/${RELEASE}"
		mkdir -p ${DOCKERFILEDIR}/scripts ${TEMP_DIR}/${DOCKERFILEDIR}
		/bin/cp ${BASEPATH}/Dockerfile-${PURPOSE}.bootstrap ${DOCKERFILEDIR}/scripts
		eval "cat <<EOF > ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile
$(<$DOCKERFILE_TPL)
EOF" > /dev/null
		if [ "`md5sum ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile| awk '{print $1}'`" != "`md5sum ${DOCKERFILEDIR}/Dockerfile| awk '{print $1}'`" ]; then
			/bin/cp ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile ${DOCKERFILEDIR}/Dockerfile
			echo "- You *must* 'git add ${DOCKERFILEDIR}/Dockerfile', it has been changed!!!"
		else
			echo "- File '${DOCKERFILEDIR}/Dockerfile' it's already ok!"
		fi
      		/bin/rm ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile
	done
    done
  done
}

generate_angular_dockerfile() {
  PURPOSE="angular-cli"
  DOCKERFILE_TPL="${BASEPATH}/Dockerfile-${PURPOSE}.tpl"
  for DISTRO in ${SSH_SERVER_DISTROS[@]}; do
    for RELEASE in ${SSH_SERVER_DISTROS_VERSION[@]}; do
      DOCKERFILEDIR="${BASEPATH}/${DISTRO}-${PURPOSE}/${RELEASE}"
      mkdir -p ${DOCKERFILEDIR}/scripts ${TEMP_DIR}/${DOCKERFILEDIR}
      /bin/cp ${BASEPATH}/Dockerfile-${PURPOSE}.bootstrap ${DOCKERFILEDIR}/scripts
      eval "cat <<EOF > ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile
$(<$DOCKERFILE_TPL)
EOF" > /dev/null
      if [ "`md5sum ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile| awk '{print $1}'`" != "`md5sum ${DOCKERFILEDIR}/Dockerfile| awk '{print $1}'`" ]; then
        /bin/cp ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile ${DOCKERFILEDIR}/Dockerfile
        echo "- You *must* 'git add ${DOCKERFILEDIR}/Dockerfile', it has been changed!!!"
      else
        echo "- File '${DOCKERFILEDIR}/Dockerfile' it's already ok!"
      fi
      /bin/rm ${TEMP_DIR}/${DOCKERFILEDIR}/Dockerfile
    done
  done
}

main() {
  case $1 in
    ssh)
      echo "Generating $1 image servers"
      generate_ssh_dockerfile
      ;;
    jenkins)
      echo "Generating $1 image servers"
      generate_jenkins_dockerfile
      ;;
    #angular)
    #  echo "Generating $1 image servers"
    #  generate_angular_dockerfile
    #  ;;
    *)
      help
      ;;
  esac
  echo "Done. Bye!"
}
#endregion FUNC

main $@

#region SCRIPT
#endregion SCRIPT
