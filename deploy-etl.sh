cd /root/
rm etlbuild.tar.gz
scp travis@45.55.190.196:./etlbuild.tar.gz .
docker load < etlbuild.tar.gz

CLIENT_PORT=$(cat /dev/urandom | od -N2 -An -i | awk -v f=10000 -v r=19999 '{printf "%i\n", f + r * $1 / 65536}')

[ $(netstat -an | grep LISTEN | grep :$CLIENT_PORT | wc -l) -eq 0 ] || { ./$0 && exit 0 || exit 1; }

docker run -dit -v /opt/etl/conf:/opt/etl/conf -p ${CLIENT_PORT}:8004 etl-rest-server/test-build
