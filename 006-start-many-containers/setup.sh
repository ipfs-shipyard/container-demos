#!/bin/sh

export GOPATH=/opt/ipfs
export IPFS_PATH=/var/lib/ipfs
mkdir -p ${GOPATH}

IPFS_BIN="/opt/ipfs/bin/ipfs"

# Compile IPFS from master
echo "Compiling ipfs from github.com/ipfs/go-ipfs/cmd/ipfs"
go get -u github.com/ipfs/go-ipfs/cmd/ipfs

mkdir -p ${IPFS_PATH}

if [ ! -f ${IPFS_PATH}/config ]; then
         # < /dev/null needed to get this running under vagrant
	 ${IPFS_BIN} init < /dev/null
fi

${IPFS_BIN} config Mounts.FuseAllowOther --bool true < /dev/null

cp /home/vagrant/ipfs.conf /etc/init/ipfs.conf
service ipfs start
sleep 10
