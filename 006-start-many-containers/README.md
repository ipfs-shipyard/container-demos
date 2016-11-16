# Distributed Docker Registry

Note: due to performance issues, this demo is not yet complete.

## Quick Start

We have already prepared a docker-registry configured for IPFS and a demo container for you.

To run this demo:

   1. Make sure `ipfs` daemon is running and mounted with `allow_other`
      ```sh
      export PATH=${HOME}/ipfs/bin:${PATH}
      ipfs config Mounts.FuseAllowOther --bool true
      ipfs daemon --mount &
      sleep 10
      ```
      If you are having trouble with FUSE, please see: https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md

   2. Make sure you can run Docker without `sudo`. For Ubuntu Linux users, see: https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo/477554#477554

   4. You need a copy of VirtualBox and Vagrant 1.6.5+. Make sure these are installed.

   5. Run ```make``` By default, this will start up 5 nodes.

## Discussion

There are currently performance issues. The first is that bringing up multiple nodes via Vagrant/VirtualBox
takes a while. This might be improved if we use a provider that allows us to bring up vms in parallel.

The second performance issue relates to IPFS itself. Right now, VMs talking to each other via loopback still
takes a while for blocks to get loaded by the registry. Sometimes the registry can't even see the files.

