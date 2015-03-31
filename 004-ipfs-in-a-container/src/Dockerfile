FROM phusion/baseimage:0.9.16

# The Phusion guys have a slightly different opinion on how the base images are supposed
# to be set up. Mainly, they have written about how process ID 1 is treated differently.
# (https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/)
# The base image provides a small init system to run daemons and such. It has caught some
# flak for violating the idea of "one process per container". The Phusion guys argue
# this is about "one logical service per container".

# Another option is to use Vendan's slimmed down busybox image. At 4MB is pretty compelling.
# https://github.com/andyleap/busybones/

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update
RUN apt-get install fuse --yes

ADD bin/ipfs /usr/bin/ipfs
ADD ipfs.runit /etc/service/ipfs/run
RUN mkdir /ipfs && mkdir /ipns && mkdir -p /var/lib/ipfs/data

VOLUME /ipfs
VOLUME /ipns
VOLUME /var/lib/ipfs/data

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
