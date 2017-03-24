set -x
#ssh -o BatchMode=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ConnectTimeout=5 user@`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${DOCKERFILE/\//-}` echo ok 2>&1 | grep Permission\ denied || exit 1
#docker exec -it $1 ps aux | grep sshd || exit 1
exit 0
