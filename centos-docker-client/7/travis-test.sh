set -x
#docker exec -it $1 ps aux | grep sshd || exit 1
docker exec -it $1 java -version | grep 1.8 || exit 1
docker exec -it $1 docker --version | grep "\-ce" || exit 1
exit 0
