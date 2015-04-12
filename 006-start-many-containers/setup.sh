#!/bin/sh

export GOPATH=/opt/ipfs
export IPFS_PATH=/var/lib/ipfs
mkdir -p ${GOPATH}

IPFS_BIN="/opt/ipfs/bin/ipfs"
CACHE_PATH="/vagrant/.cache/"
CACHED_IPFS_BIN="${CACHE_PATH}/ipfs"

# Compile IPFS from master
if [ -f ${CACHE_PATH}/ipfs ]; then
  echo "Cached copy of IPFS binary found. Using cached copy."
  mkdir -p /opt/ipfs/bin
  cp ${CACHED_IPFS_BIN} ${IPFS_BIN}
else
  echo "Cached copy of IPFS binary not found."
  echo "Compiling ipfs from github.com/ipfs/go-ipfs/cmd/ipfs"
  go get -u github.com/ipfs/go-ipfs/cmd/ipfs
  mkdir -p ${CACHE_PATH}
  cp ${IPFS_BIN} ${CACHED_IPFS_BIN}
fi

mkdir -p ${IPFS_PATH}

if [ ! -f ${IPFS_PATH}/config ]; then
         # < /dev/null needed to get this running under vagrant
	 ${IPFS_BIN} init < /dev/null
fi

${IPFS_BIN} config Mounts.FuseAllowOther --bool true < /dev/null

cp /home/vagrant/ipfs.conf /etc/init/ipfs.conf
echo "Starting IPFS"
service ipfs start
sleep 10
