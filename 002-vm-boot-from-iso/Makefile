vmname="Haiku"
iso=haiku-r1alpha4.iso
remote_iso=/ipfs/QmW9on9UeKCVDb5dsTEZJQwQoH53gXUtVfWvSBhf2Thmyq/isos/haiku-r1alpha4.1-iso.tar.xz

ifeq (, $(shell which VBoxManage))
  $(error "No VBoxManage found in $(PATH). Please install VirtualBox: https://www.virtualbox.org/wiki/Downloads")
endif

define notfound
$(iso) not found
Make sure the daemon is running and mounted:
	ipfs daemon --mount &
	sleep 10

If you are having trouble mounting IPFS, please see https://github.com/jbenet/go-ipfs/blob/master/docs/fuse.md
endef
export notfound

boot: vm
	VBoxManage startvm $(vmname)

vm:
	@VBoxManage list vms | grep $(vmname) >/dev/null || make createvm

createvm: $(iso)
	# create the vm
	VBoxManage createvm --name $(vmname) --register
	VBoxManage modifyvm $(vmname) --memory 512 --acpi on --boot1 dvd
	VBoxManage modifyvm $(vmname) --nic1 nat --nictype1 82540EM --cableconnected1 on
	VBoxManage modifyvm $(vmname) --ostype Linux

	# add a hdd
	VBoxManage createhd --filename ./disk.vdi --size 10000
	VBoxManage storagectl $(vmname) --name "IDE Controller" --add ide
	VBoxManage storageattach $(vmname) --storagectl "IDE Controller"  \
	    --port 0 --device 0 --type hdd --medium ./disk.vdi

	# attach the iso
	VBoxManage storageattach $(vmname) --storagectl "IDE Controller" \
	    --port 1 --device 0 --type dvddrive --medium "$(iso)"

$(iso):
	@stat $(remote_iso) >/dev/null 2>/dev/null || (echo "$$notfound" && false)
	tar Jxvf $(remote_iso)
