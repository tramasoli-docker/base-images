#!/bin/bash
#set -x

#region VARS

BASEPATH=`dirname $0`
TEMP_DIR="/tmp/gendocker"
SSH_SERVER_DISTROS=(centos oraclelinux)
SSH_SERVER_DISTROS_VERSION=(6 7)

JVM_FLAVORS=(server-jre jdk jdk-dcevm)
JCE_FLAVORS=(standard unlimited)

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

generate_jdk_dockerfile() {
  #TODO
  echo "NotImplemented"
}

main() {
  case $1 in
    ssh)
      echo "Generating SSH image servers"
      generate_ssh_dockerfile
      ;;
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
