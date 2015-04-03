container_name=ipfs-registry
container_tag=ipfs/docker-registry:0.1.0
image_id=98e62dcc3c34
image_path=/ipfs/QmaMPvdLWR3YfMVrzgdW5QnQHC1eXoTeUYLMgRJNAMzvi3/ipfs-docker-registry.tar

demo_image_id=bf25c3f7f322
demo_image_path=/ipfs/QmfG9AUHSc2oeFJ1kVNqoh4UA61knu4WnetawW53kApiGM/wiki-node.img
demo_container_tag=ipfs-demo/wiki-node:latest

define notfound
$(image_path) not found
Make sure the daemon is running and mounted with allow_other:
	ipfs config Mounts.AllowOther --bool true
	ipfs daemon --mount

If you are having trouble mounting IPFS, please see https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md
endef
export notfound

demo: ipfs-docker
	sudo docker tag $(demo_container_tag) localhost:5000/wiki-node
	sudo docker push localhost:5000/wiki-node

ipfs-docker: /ipns/local/docker-registry load-image
	@stat /ipns/local >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	sudo docker run -d \
	  -p 5000:5000 \
	  --name $(container_name) \
	  -v /ipns/local/docker-registry:/ipns/local/docker-registry \
	  -t \
	  $(container_tag)

/ipns/local/docker-registry:
	mkdir /ipns/local/docker-registry

load-demo:
	@stat $(demo_image_path) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	sudo docker load < $(demo_image_path)
	sudo docker tag -f $(demo_image_id) $(demo_container_tag)

load-image:
	@stat $(image_path) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	sudo docker load < $(image_path)
	sudo docker tag -f $(image_id) $(container_tag)

stop:
	sudo docker stop $(container_name)
	sudo docker rm $(container_name)

rel-clean:
	rm -fr /ipns/local/docker-registry

clean-image: stop rel-clean
	sudo docker rmi $(image_id) $(demo_image_id)
