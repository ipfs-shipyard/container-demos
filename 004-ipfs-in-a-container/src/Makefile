container_tag=ipfs/daemon:0.1.0
DIRS=src pkg bin

build: bin/ipfs
	sudo docker build -t $(container_tag) .

bin/ipfs: $(DIRS)
	GOPATH=$(PWD) CGO_ENABLED=0 go get -v -a -ldflags '-s' github.com/jbenet/go-ipfs/cmd/ipfs

$(DIRS):
	mkdir $@

clean:
	rm -fr $(DIRS)
