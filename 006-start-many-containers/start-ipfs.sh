#!/bin/sh

export GOPATH=/opt/ipfs
export IPFS_PATH=/var/lib/ipfs

IPFS_BIN="/opt/ipfs/bin/ipfs"

mkdir -p ${IPFS_PATH}

if [ ! -f ${IPFS_PATH}/config ]; then
         # < /dev/null needed to get this running under vagrant
	 ${IPFS_BIN} init < /dev/null
fi

${IPFS_BIN} config Mounts.FuseAllowOther --bool true < /dev/null
${IPFS_BIN} daemon --mount &
