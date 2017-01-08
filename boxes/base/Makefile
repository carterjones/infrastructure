all: destroy update build box cache
destroy:
	vagrant destroy -f
update:
	vagrant box update
build:
	vagrant up
box:
	rm -f box.box
	vagrant package --output box.box
cache:
	vagrant box add carterjones/base box.box --force
