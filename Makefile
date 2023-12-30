vbox:
						vagrant up

qemu:
						qemu-system-x86_64 -cdrom SnowCrash.iso &

qemu-kill:
						pkill qemu-system-x86_64

ssh:
						ssh -p 4242 level0@

