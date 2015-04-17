# Running docker-registry on IPFS

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

   3. Build the ipfs docker registry
      ```sh
      cd src
      make
      cd ..
      ```

   4. Run ```make```

## Start Docker Registry on another machine

Try bringing up the ipfs-docker-registry on another box, pointing to the ID of the original

First, get the $ID on the first machine:
```sh
ipfs id
```

On a different machine:

```sh
export PATH=${HOME}/ipfs/bin:${PATH}
ipfs config Mounts.FuseAllowOther --bool true
ipfs daemon --mount

cd src; make; cd ..

sudo docker ps | grep ipfs-registry || sudo docker run -d \
  -p 5000:5000 \
  --name ipfs-registry \
  -v /ipns/$ID/docker-registry:/ipns/local/docker-registry \
  -t \
  ipfs/docker-registry:0.1.0

sudo docker pull localhost:5000/wiki-node
```

## Discussion

IPFS currenly only supports a single FUSE option, `allow_other`. By mounting IPFS with `allow_other`, you
can run Docker containers on top of IPFS.

This demo also demonstrates the difference between client-server architecture and a distributed application.
Rather than specifying a remote registry with a URL, a local docker registry is mounted against a remote
IPFS location. The images contained in that registry are transferred with the IPFS swarming protocol.
