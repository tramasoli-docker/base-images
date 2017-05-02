set -x
#docker exec -it $1 ps aux | grep sshd || exit 1
docker exec -it $1 java -version | grep 1.8 || exit 1
docker exec -it $1 node --version | grep v6. || exit 1
docker exec -it $1 ng version | grep angular\/cli\:\ 1.0.0-rc\.4 || exit 1
docker exec -it $1 jq --version | grep 1.5 || exit 1
exit 0
