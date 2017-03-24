set -x
docker exec -it $1 ps aux | grep sshd || exit 1
exit 0
