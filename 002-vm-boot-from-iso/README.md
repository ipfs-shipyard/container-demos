# Booting a VM from an ISO

## Quick Start

We have already prepared a ISO for you to try.

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

## Uploading Your Own ISO

In this example, we used one of the VirtualBox VMs prepared by Chef built
from their Bento project, https://github.com/chef/bento

   1. Prepare your environment and get ```ipfs``` daemon running
      ```
      export PATH="${HOME}/ipfs/bin":${PATH}
      ipfs daemon &
      ```

   2. Download an image. For example:
      ```
      mkdir iso
      cd iso
      wget http://haiku.osuosl.org/releases/r1alpha4.1/haiku-r1alpha4.1-iso.tar.xz
      ```

   3. Add and pin it to ```ipfs```
      ```
      cd ..
      ipfs add -r iso
      ipfs pin -r {HASH}/iso
      ```

   4. To download it, you can then issue
      ```
      ipfs get {HASH}/iso/haiku-r1alpha4.1-iso.tar.xz
      ```

   5. Or you can set up a FUSE mount for IPFS, and use it directly:

      ```
      tar Jxvf /ipfs/${HASH}/iso/haiku-r1alpha4.1-iso.tar.xz
      ```

     And then use the VirtualBox manager to start up a machine.

See the `Makefile` for an example of how to set this up via the command line.


