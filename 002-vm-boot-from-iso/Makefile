vmname="Haiku"
iso=haiku-r1alpha4.iso
remote_iso=QmW9on9UeKCVDb5dsTEZJQwQoH53gXUtVfWvSBhf2Thmyq/isos/haiku-r1alpha4.1-iso.tar.xz
local_compressed_iso_path=haiku-r1alpha4.1-iso.tar.xz

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

$(iso): $(local_compressed_iso_path)
	tar Jxvf $(local_compressed_iso_path)

$(local_compressed_iso_path):
	ipfs get $(remote_iso)
