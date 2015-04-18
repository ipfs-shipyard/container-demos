ROOT_FILESYSTEM_LOCAL_PATH = /tmp/ipfs-nsinit-demo
IPFS = ipfs
NSINIT = $(ROOT_FILESYSTEM_LOCAL_PATH)/bin/nsinit
COMMAND = /bin/busybox sh

# This is a trimmed-down version of the filesystem from
# stage3-amd64-20150402.tar.bz2 in the Gentoo mirrors [1].  For
# example, it's hosted at [2].  Then I unwound a few symlinks
# (ld-linux-x86-64.so.2, libc.so.6, and libpthread.so.0) in /lib64,
# because IPFS doesn't support symlinks yet.  Then I added ipfs
# (v0.3.4) and nsinit (commit 32b8465) binaries to /bin (but feel free
# to copy in your own Linux / amd64 versions).
#
# [1]: https://www.gentoo.org/downloads/mirrors/
# [2]: http://gentoo.osuosl.org/releases/amd64/autobuilds/20150402/stage3-amd64-20150402.tar.bz2
ROOT_FILESYSTEM_ID = QmRBUaQYGSYzGpYoheUDC16cpKmDKGvsnFRvAdBuGddAYS

.PHONY: checkout-filesystem

run: $(ROOT_FILESYSTEM_LOCAL_PATH)/container.json
	cd $(ROOT_FILESYSTEM_LOCAL_PATH) && sudo $(NSINIT) exec --tty $(COMMAND)

checkout-filesystem:
	test ! -e $(ROOT_FILESYSTEM_LOCAL_PATH)
	$(IPFS) get -o=$(ROOT_FILESYSTEM_LOCAL_PATH) $(ROOT_FILESYSTEM_ID)
	chmod 755 $(ROOT_FILESYSTEM_LOCAL_PATH)/bin/* $(ROOT_FILESYSTEM_LOCAL_PATH)/lib64/ld-*

$(ROOT_FILESYSTEM_LOCAL_PATH)/container.json: checkout-filesystem
	$(NSINIT) config >"$@"
