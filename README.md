# ipfs-container-demos

[![](https://img.shields.io/badge/made%20by-Protocol%20Labs-blue.svg?style=flat-square)](http://ipn.io)
[![](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](http://ipfs.io/)
[![](https://img.shields.io/badge/freenode-%23ipfs-blue.svg?style=flat-square)](http://webchat.freenode.net/?channels=%23ipfs)
[![](https://img.shields.io/badge/discussion_repo-go_to_issues-brightgreen.svg?style=flat-square)](https://github.com/ipfs/ipfs-container-demos/issues)
[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> ipfs container demos

This repository outlines demos for container and infrastructure things done with IPFS: booting VMs, docker-registry, mounting data volumes, etc.

This is also a **discussion repo**. That means that all of the work gets done in the [issues](https://github.com/ipfs/container-demos/issues).

## Planning a Demo

1. create an issue with the demo title
2. outline what the demo would be / do
3. outline what artifacts we would need (vms, makefiles, etc) 
4. discuss

## Preparing a Demo

1. create demo artifacts
2. make a directory in the repo (e.g. "boot-vm-with-pxe")
3. put all artifacts in there
4. make sure to add a `Makefile` that builds + fetches things with ipfs
5. if there are specific ipfs urls to pin, note those and where to get them.
6. write the demo `script` (what to say, what to do, etc)

## Making demo

**We can worry about this later, once we have 5+ demos ready to record.**

1. Record demo
2. Upload to youtube on ipfs account
3. Write a demo page -- like an [ipfs-example](https://github.com/protocol/ipfs-examples) but embedding the youtube video + transcript
4. Publish to ipfs examples page, blog, twitter, etc.

## Contribute

Feel free to join in. All welcome.

This repository falls under the IPFS [Code of Conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).

### Want to hack on IPFS?

[![](https://cdn.rawgit.com/jbenet/contribute-ipfs-gif/master/img/contribute.gif)](https://github.com/ipfs/community/blob/master/contributing.md)

## License

MIT
