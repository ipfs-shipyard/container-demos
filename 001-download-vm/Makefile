
vm_image=QmW9on9UeKCVDb5dsTEZJQwQoH53gXUtVfWvSBhf2Thmyq/vms/opscode_ubuntu-14.04_chef-provisionerless.box

ifeq (, $(shell which ipfs))
  $(error "No ipfs in $(PATH). Add the binary to the PATH")
endif

download:
	ipfs get $(vm_image)
