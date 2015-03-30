# Running IPFS in a container

## Quick Start

We have already prepared IPFS in a container for you.

To run this demo:

   1. Make sure `ipfs` daemon is running and mounted
      ```sh
      export PATH=${HOME}/ipfs/bin:${PATH}
      ipfs daemon &
      sleep 10
      ipfs mount
      ```
      If you are having trouble with FUSE, please see: https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md

   2. Run ```make```

   3. Try looking up other hashes:
      ```sh
      ipfs add foo.txt
      sudo docker exec ipfs cat /ipfs/${HASH}
      ```

## Building your own IPFS in a container

In this example, we will use the Dockerfile contained in src/. This Dockerfile contains instructions
to insert a statically-compiled version of the IPFS daemon and make it runnable under the Phusion baseimage.

You will need to have a functioning Go development system. Instructions on how to set that up is
located here: https://golang.org/doc/install

   1. Prepare your environment and get ```ipfs``` daemon running and mount it
      ```sh
      export PATH="${HOME}/ipfs/bin":${PATH}
      ipfs daemon &
      sleep 10
      ipfs mount
      ```

   2. Build the IPFS image
      ```sh
      cd src
      make
      ```

   3. Save a copy of the image, add it to `ipfs` and pin it.
      ```sh
      mkdir images
      docker images
      # Grab the ${IMAGE_ID} you want
      docker save ${IMAGE_ID} > wiki.img
      cd ..
      ipfs add -r images
      ipfs pin -r ${HASH}/images
      ```

   4. To start the image
      ```sh
      docker load < /ipfs/${HASH}/wiki.img
      docker tag ${IMAGE_ID} ipfs/daemon:latest
      docker run -d --name ipfs --privileged ipfs/daemon:latest
      ```

## Discussion

We're actually using FUSE inside the container to mount IPFS to `/ipfs` and `/ipns`. This is why
it needs a `--privileged`. There may be a possibility of using `--cap-add SYS_ADMIN --device /dev/fuse`.
However, the author was unable to set up a correct apparmor profile to get this to work.

Additionally, due to the limitation of Docker itself, you cannot at this time export `/ipfs` and `/ipns`
as volumes for other containers. This is because when you specify `--volumes-from`, Docker mounts
directories from the host to another container. I/O requests from the other container to the mounted
directores never passes through FUSE into the IPFS container.

There are still other possibilities with running IPFS in a container, however. The two HTTP gateways
can be exposed through the container. So there are possibilities of building out an automated pinning
service with this container. Those do not require mounted endpoints, and further, would probably not
require running this with `--privileged`.

For additional discussion on this, please see: https://github.com/jbenet/ipfs-container-demos/issues/2
