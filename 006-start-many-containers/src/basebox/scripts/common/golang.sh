#!/bin/sh

VERSION="1.4.2"
OS="linux"
ARCH="amd64"
BIN_PKG="https://storage.googleapis.com/golang/go${VERSION}.${OS}-${ARCH}.tar.gz"

cd /tmp
wget ${BIN_PKG}
tar -C /usr/local -xzf /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz

echo 'export PATH=$PATH:/usr/local/go/bin' > /etc/profile.d/golang.sh
