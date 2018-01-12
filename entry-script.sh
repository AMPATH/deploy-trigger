#! /bin/sh
echo "Preparing ssh keys.."
cd /tmp/keys
ls
cp ./id_rsa /tmp
chmod 400 /tmp/id_rsa
eval $(ssh-agent)
echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 
ssh-add /tmp/id_rsa
echo "Starting services.."
pm2-runtime  start /opt/poc-ci/pm2.json
exec "$@"