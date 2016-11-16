
vm_image=QmVq4oB59VdEwNWv4NUSdcyy6UErMieTATvMiaqtArrjw4/ubuntu-14.10_ipfs.box
vm_name=ubuntu-14.10_ipfs
registry_name=ipfs-registry
registry_tag=ipfs/docker-registry:0.1.0

#demo_image_id=bf25c3f7f322
#demo_image_path=/ipfs/QmPveebHsVPpS6Q9oPEtDBjJARnWFNNGuLhuCQE9aCejte/wiki-node.img
#demo_container_tag=ipfs-demo/wiki-node:latest
#demo_remote_tag="localhost:5000/wiki-node"
demo_image_id=4986bf8c1536
demo_image_path=/ipfs/QmPveebHsVPpS6Q9oPEtDBjJARnWFNNGuLhuCQE9aCejte/busybox.img
demo_container_tag="busybox:latest"
demo_remote_tag="localhost:5000/busybox"

NODES=5 # default
export NODES

define notfound
$(image_path) not found
Make sure the daemon is running and mounted with allow_other:
	ipfs config Mounts.AllowOther --bool true
	ipfs daemon --mount &
	sleep 10

If you are having trouble mounting IPFS, please see https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md
endef
export notfound

demo: ipfs-docker load-demo nodes

nodes:
	vagrant up
	vagrant ssh ipfs-node-1 -c 'docker pull $(demo_remote_tag)'


load-vagrant-box:
	vagrant box list | grep $(vm_name) || vagrant box add --name $(vm_name) /ipfs/$(vm_image)

demo2: ipfs-docker load-demo
	@echo
	@echo Look, we have a registry
	@echo
	ls /ipns/local/docker-registry/images
	@echo
	@echo Deleting demo image and try a pull
	@echo
	docker rmi -f $(demo_image_id)
	docker pull $(demo_remote_tag)

ipfs-docker: /ipns/local/docker-registry build-registry
	@echo Starting docker-registry on ipfs if it is not already started
	@stat /ipns/local >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	docker ps | grep registry || docker run -d -t \
	  -p 5000:5000 \
	  --name registry \
	  -v /ipns/local/docker-registry:/ipns/local/docker-registry \
          -v ${PWD}/docker-registry.yml:/docker-registry.yml \
          -e DOCKER_REGISTRY_CONFIG=/docker-registry.yml \
	  -e SETTINGS_FLAVOR=prod \
          -e STORAGE_PATH=/ipns/local/docker-registry \
	  -t \
	  registry
	sleep 2

build-registry:
	docker pull registry

/ipns/local/docker-registry:
	mkdir /ipns/local/docker-registry

load-demo:
	@echo Loading demo image if it is not already loaded
	@stat $(demo_image_path) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	docker images | grep $(demo_image_id) || docker load < $(demo_image_path)
	docker tag -f $(demo_image_id) $(demo_container_tag)
	docker tag -f $(demo_container_tag) $(demo_remote_tag)
	docker push $(demo_remote_tag)

stop:
	docker stop ipfs-registry || true
	docker rm ipfs-registry || true
	docker stop registry || true
	docker rm registry || true
	vagrant destroy -f || true

rel-clean: clean
	rm -fr /ipns/local/docker-registry

clean: stop

.PHONY: load-vagrant-box demo ipfs-docker build-registry load-demo clean stop rel-clean
