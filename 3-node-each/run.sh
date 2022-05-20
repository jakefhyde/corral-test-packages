pushd . && cd scripts && go build -o ../build build.go && popd
./build ./packages
corral delete $1
corral create $1 ./dist/digitalocean-rke2-ubuntu-20-04-x64-v1.23.6-rke2r2 -v etcd_count=1 -v controlplane_count=1 -v worker_count=1 --debug
