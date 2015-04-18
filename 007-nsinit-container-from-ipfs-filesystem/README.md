# Starting a container with nsinit from an IPFS filesystem

Docker's image format is built on the idea of [filesystem
layers][layers].  You could conceivably create images with [a single
tar layer][layer-changeset], but by packing the layer into a tar
archive you lose many IPFS benefits.  For example, if you tweak a
single file, you either have to distribute a new tar archive, or add a
second tar layer that needs some fancy filesystem manipulations to
unpack (e.g. a union- or snapshot-based filesystem like [AUFS][],
[btrfs][], or [device-mapper's thin provisioning][thin-provisioning]).
It's more efficient to store the filesystem directly in IPFS without
any packing.

The core of Docker's container launching is [libcontainer][], and
libcontainer has [`nsinit`][nsinit], a demonstration utility that
launches containers directly from a root filesystem.  `nsinit` reads
the container's environment, networking, capabilities, etc. from a
`container.json` in the root filesystem.  You can either put that file
directly in your IPFS directory, or have users generate it themselves
(you can get the standard configuration with `nsinit config`).

The final wrinkle in this procedure is that [IPFS doesn't yet track
file permissions][no-exec], so you can't launch `nsinit` directly from
your IPNS directory.  As a workaround, the demo `Makefile` currently
extracts the IPFS directory to your local filesystem, and then tweaks
the file mode locally.

To run this demo:

1. [Install the `ipfs`][install-ipfs] binary somewhere in your `PATH`:
   IPFS is easy:

        $ go get -u github.com/ipfs/go-ipfs/cmd/ipfs

   You can optionally compile a local `nsinit` binary, but it's [a bit
   more complicated due to vendoring][libcontainer-vendoring].  For
   folks that don't want to bother, I've bundled a Linux / amd64 build
   based on their commit 32b8465d (Merge pull request #533 from
   rhatdan/badrelabel, 2015-04-14).

2. Launch a local IPFS daemon so you can fetch remote objects:

        $ ipfs daemon

3. Run `make`:

        $ make
        test ! -e /tmp/ipfs-nsinit-demo
        ipfs get -o=/tmp/ipfs-nsinit-demo QmWQWb4cBmeLbfpRLueo6pB3KSUgcofL5HhaZqnAYiXYCd
        Saving file(s) to /tmp/ipfs-nsinit-demo
        31.42 MB 0
        chmod 755 /tmp/ipfs-nsinit-demo/bin/* /tmp/ipfs-nsinit-demo/lib64/ld-*
        cd /tmp/ipfs-nsinit-demo && sudo /tmp/ipfs-nsinit-demo/bin/nsinit exec --tty /bin/busybox sh
        / # echo 'hello from your container!'
        hello from your container!

  If you've installed your `ipfs` and `nsinit` binaries outside your
  `PATH`, you can [override][] the location with something like:

        $ make IPFS=/path/to/ipfs NSINIT=/path/to/nsinit

  You can also override the following variables to tweak the
  execution:

    * `ROOT_FILESYSTEM_ID`, which defaults to
      [`QmWQWb4cBmeLbfpRLueo6pB3KSUgcofL5HhaZqnAYiXYCd`][root] and is
      the IPFS key for the container's root directory.
    * `ROOT_FILESYSTEM_LOCAL_PATH`, which defaults to
      `/tmp/ipfs-nsinit-demo` and is the location of the directory
      used for the local copy of the container's root directory.
    * `COMMAND`, which defaults to `/bin/busybox sh` and is the
      command executed inside the container.  The
      [`QmWQWb4cBmeLbfpRLueo6pB3KSUgcofL5HhaZqnAYiXYCd`][root] tree
      only contains [BusyBox][], IPFS, and `nsinit` binaries, so your
      options are somewhat limited unless you also override
      `ROOT_FILESYSTEM_ID`.

If you don't like `nsinit`, I'm sure you could use a similar workflow
with [LXC][] or any other container-launching system that uses an
unpacked root filesystem.

[layers]: https://github.com/docker/docker/blob/master/image/spec/v1.md#terminology
[layer-changeset]: https://github.com/docker/docker/blob/master/image/spec/v1.md#creating-an-image-filesystem-changeset
[AUFS]: http://aufs.sourceforge.net/
[btrfs]: https://btrfs.wiki.kernel.org/index.php/Main_Page
[thin-provisioning]: https://www.kernel.org/doc/Documentation/device-mapper/thin-provisioning.txt
[libcontainer]: https://github.com/docker/libcontainer
[nsinit]: https://github.com/docker/libcontainer#nsinit
[no-exec]: https://github.com/ipfs/go-ipfs/issues/846
[install-ipfs]: https://github.com/ipfs/go-ipfs#install
[libcontainer-vendoring]: https://github.com/docker/libcontainer/issues/210
[override]: https://www.gnu.org/software/make/manual/html_node/Overriding.html
[root]: http://gateway.ipfs.io/ipfs/QmYRpzwXkSnCPPNL4b2gn5AFnyyMHFxhS9Nrbau5ycw92H
[BusyBox]: http://www.busybox.net/
[LXC]: https://linuxcontainers.org/
