.POSIX:
.SUFFIXES:
.SUFFIXES: .nasm .bin

default: boot2craft.bin
	@printf 'QEMU\t$?\n'
	@qemu-system-i386 \
		-drive file=$?,format=raw \
		-audiodev pa,id=sound \
		-machine pcspk-audiodev=sound \
		-s #-S &
	#@lldb -a i386-unknown-none-code16 \
	#	-o 'settings set target.x86-disassembly-flavor intel' \
	#	-o 'gdb-remote 1234' -o 'tbreak *0x7c00' -o 'c'

.nasm.bin:
	@printf 'NASM\t$*.nasm\n'
	@nasm -f bin -w+all $< -o $*.bin

clean:
	rm -f *.bin
