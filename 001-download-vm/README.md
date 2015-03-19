# Downloading a VM

## Quick Start

We have already prepared a VM for you to try.

To run this demo:

   1. Make sure ```ipfs``` is in your ```PATH```

      ```export PATH="${HOME}/ipfs/bin":${PATH}```

   2. Make sure ipfs daemon is running:

      ```ipfs daemon &```

   3. Run ```make```

## Uploading Your Own VM

In this example, we used one of the VirtualBox VMs prepared by Chef built
from their Bento project, https://github.com/chef/bento

   1. Prepare your environment and get ```ipfs``` daemon running
      ```
      export PATH="${HOME}/ipfs/bin":${PATH}
      ipfs daemon &
      ```

   2. Download an image. For example:
      ```
      mkdir vms
      cd vms
      wget http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box
      ```

   3. Add and pin it to ```ipfs```
      ```
      cd ..
      ipfs add -r vms
      ipfs pin -r {HASH}/vms
      ```

   4. To download it, you can then issue
      ```
      ipfs get {HASH}/vms/opscode_ubuntu-14.04_chef-provisionerless.box
      ```

