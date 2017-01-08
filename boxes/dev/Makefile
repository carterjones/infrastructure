all: destroy build box cache
destroy:
	vagrant destroy -f
build:
	vagrant up
box:
	rm -f box.box
	vagrant package --output box.box
cache:
	vagrant box add carterjones/dev box.box --force
