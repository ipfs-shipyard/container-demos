#!/bin/sh

apt-get install apt-transport-https -y
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo 'deb http://get.docker.io/ubuntu docker main' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install lxc-docker -y
docker -v
gpasswd -a vagrant docker
service docker start

mv /tmp/docker-registry.yml /etc/
chown root:root /etc/docker-registry.yml
sleep 10

docker pull registry

