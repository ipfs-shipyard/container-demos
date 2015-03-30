FROM phusion/baseimage:0.9.16

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
