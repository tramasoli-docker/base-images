set -x
#docker exec -it $1 ps aux | grep sshd || exit 1
docker exec -it $1 java -version | grep 1.8 || exit 1
docker exec -it $1 mvn -version  |  grep Apache\ Maven\ 3\. || exit 1
docker exec -it $1 svn --version || exit 1
docker exec -it $1 git -version  || exit 1
exit 0
