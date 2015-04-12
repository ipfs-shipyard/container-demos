#!/bin/sh

export GOPATH=/opt/ipfs
mkdir -p ${GOPATH}

IPFS_BIN="/opt/ipfs/bin/ipfs"

# Compile IPFS from master
echo "Compiling ipfs from github.com/ipfs/go-ipfs/cmd/ipfs"
go get -u github.com/ipfs/go-ipfs/cmd/ipfs

/home/vagrant/start-ipfs.sh


