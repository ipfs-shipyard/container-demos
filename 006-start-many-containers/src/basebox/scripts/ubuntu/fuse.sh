#!/bin/sh

sudo apt-get install fuse -y
chown vagrant:vagrant /etc/fuse.conf
gpasswd -a vagrant fuse
echo 'user_allow_other' >> /etc/fuse.conf

mkdir /ipfs
mkdir /ipns
chown vagrant:vagrant /ipfs
chown vagrant:vagrant /ipns
