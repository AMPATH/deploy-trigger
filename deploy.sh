cd /tmp/
rm build.tgz
# scp -i ./id_rsa exmpleuser@10.10.10.10:./build.tgz .
tar -xzf build.tgz -C ./test-builds
