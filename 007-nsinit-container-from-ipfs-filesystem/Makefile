ROOT_FILESYSTEM_LOCAL_PATH = /tmp/ipfs-nsinit-demo
IPFS = ipfs
NSINIT = nsinit
COMMAND = /bin/busybox sh

# This is just a trimmed-down version of the filesystem from
# stage3-amd64-20150402.tar.bz2 in the Gentoo mirrors [1].  For
# example, it's hosted at [2].
#
# [1]: https://www.gentoo.org/downloads/mirrors/
# [2]: http://gentoo.osuosl.org/releases/amd64/autobuilds/20150402/stage3-amd64-20150402.tar.bz2
ROOT_FILESYSTEM_ID = QmYRpzwXkSnCPPNL4b2gn5AFnyyMHFxhS9Nrbau5ycw92H

.PHONY: checkout-filesystem

run: $(ROOT_FILESYSTEM_LOCAL_PATH)/container.json
	cd $(ROOT_FILESYSTEM_LOCAL_PATH) && sudo $(NSINIT) exec --tty $(COMMAND)

checkout-filesystem:
	test ! -e $(ROOT_FILESYSTEM_LOCAL_PATH)
	$(IPFS) get -o=$(ROOT_FILESYSTEM_LOCAL_PATH) $(ROOT_FILESYSTEM_ID)
	chmod 755 $(ROOT_FILESYSTEM_LOCAL_PATH)/bin/*

$(ROOT_FILESYSTEM_LOCAL_PATH)/container.json: checkout-filesystem
	$(NSINIT) config >"$@"
