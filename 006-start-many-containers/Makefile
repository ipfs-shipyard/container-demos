
vm_image=QmW9on9UeKCVDb5dsTEZJQwQoH53gXUtVfWvSBhf2Thmyq/vms/opscode_ubuntu-14.04_chef-provisionerless.box
vm_name=opscode_ubuntu-14.04
registry_name=ipfs-registry
registry_tag=ipfs/docker-registry:0.1.0

demo_image_id=bf25c3f7f322
demo_image_path=/ipfs/QmfG9AUHSc2oeFJ1kVNqoh4UA61knu4WnetawW53kApiGM/wiki-node.img
demo_container_tag=ipfs-demo/wiki-node:latest

define notfound
$(image_path) not found
Make sure the daemon is running and mounted with allow_other:
	ipfs config Mounts.AllowOther --bool true
	ipfs daemon --mount &
	sleep 10

If you are having trouble mounting IPFS, please see https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md
endef
export notfound

load-vagrant-box:
	vagrant box add --name $(vm_name) /ipfs/$(vm_image)

demo: ipfs-docker load-demo
	docker tag -f $(demo_container_tag) localhost:5000/wiki-node
	docker push localhost:5000/wiki-node
	@echo
	@echo Look, we have a registry
	@echo
	ls /ipns/local/docker-registry/images
	@echo
	@echo Deleting demo image and try a pull
	@echo
	docker rmi -f $(demo_image_id)
	docker pull localhost:5000/wiki-node

ipfs-docker: /ipns/local/docker-registry
	@echo Starting docker-registry on ipfs if it is not already started
	@stat /ipns/local >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	docker ps | grep ipfs-registry || docker run -d \
	  -p 5000:5000 \
	  --name $(container_name) \
	  -v /ipns/local/docker-registry:/ipns/local/docker-registry \
	  -t \
	  $(container_tag)

/ipns/local/docker-registry:
	mkdir /ipns/local/docker-registry

load-demo:
	@echo Loading demo image if it is not already loaded
	@stat $(demo_image_path) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	docker images | grep $(demo_image_id) || docker load < $(demo_image_path)
	docker tag -f $(demo_image_id) $(demo_container_tag)

stop:
	docker stop $(container_name)
	docker rm $(container_name)

rel-clean:
	rm -fr /ipns/local/docker-registry

clean: stop rel-clean
	docker rmi -f $(demo_image_id)
