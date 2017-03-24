set -x
docker exec -it $1 ps aux | grep sshd || exit 
exit 0
