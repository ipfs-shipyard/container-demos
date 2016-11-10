container_tag=ipfs/daemon:0.1.0
container_name=ipfs
image_id=5efd607f36d1
image_path=/ipfs/QmdiByRvJpAiFp6SKBc38K938NRiYvkUKtSMmETdJjuk6p/ipfs-daemon-0.1.0.tar

demo=/ipfs/QmTRucVxNAF6d4TRGYHLGtQrc7JbHVhRNVQahpuhTowCUi/dog

define notfound
$(image_path) not found
Make sure the daemon is running and mounted:
	ipfs daemon &
	sleep 10
	ipfs mount

If you are having trouble mounting IPFS, please see https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md
endef
export notfound

demo: ipfs
	@echo "Waiting for ipfs daemon to sync up"
	sleep 30
	sudo docker exec $(container_name) cat $(demo)

ipfs: load-image
	@echo "Warning: Running ipfs daemon in privileged container"
	sudo docker run -d --name $(container_name) --privileged -t $(container_tag)

load-image:
	@stat $(image_path) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	sudo docker load < $(image_path)
	sudo docker tag $(image_id) $(container_tag)

clean-image:
	sudo docker rmi $(image_id)
