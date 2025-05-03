# Starting a Container

## Quick Start

We have already prepared a Docker image for you to try. This container will run the Federated Wiki https://github.com/fedwiki/wiki-node

To run this demo:

   1. Make sure `ipfs` daemon is running and mounted
      ```sh
      export PATH=${HOME}/ipfs/bin:${PATH}
      ipfs daemon --mount &
      sleep 10
      ```
      If you are having trouble with FUSE, please see: https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md

   2. Run ```make```

   3. Try the Federated Wiki by going to http://localhost:3000

## Using your own container

In this example, we will use the Dockerfile contained in src/. This Dockerfile contains instructions
to install the Federated Wiki from npm, set up a data directory and expose the default port.

   1. Prepare your environment and get ```ipfs``` daemon running and mount it
      ```sh
      export PATH="${HOME}/ipfs/bin":${PATH}
      ipfs daemon &
      sleep 10
      ipfs mount
      ```

   2. Build an image. For example
      ```sh
      cd src
      make
      ```

      or

      ```docker build -t ipfs-demo/wiki-node:latest```

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
      docker tag ${IMAGE_ID} ipfs-demo/wiki-node:latest
      docker run --rm -i -p 3000:3000 -t ipfs-demo/wiki-node:latest
      ```
