#container_tag="ipfs-demo/wiki-node:latest"
#image_id=bf25c3f7f322
#image_path=/ipfs/QmfG9AUHSc2oeFJ1kVNqoh4UA61knu4WnetawW53kApiGM/wiki-node.img
container_tag="busybox:latest"
image_id=4986bf8c1536
image_path=/ipfs/QmPveebHsVPpS6Q9oPEtDBjJARnWFNNGuLhuCQE9aCejte/busybox.img

define notfound
$(image_path) not found
Make sure the daemon is running and mounted:
	ipfs daemon --mount &
	sleep 10

If you are having trouble mounting IPFS, please see https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md
endef
export notfound

boot: load-image
	#docker run --rm -p 3000:3000 -i -t $(container_tag)
	docker run --rm -p 3000:3000 -i -t $(container_tag) echo "hello world"


load-image:
	@stat $(image_path) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	docker load < $(image_path)
	docker tag -f $(image_id) $(container_tag)

clean-image:
	docker rmi $(image_id)
