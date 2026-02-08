# .PHONY = clean 
# CC = gcc
# FLAGS = -Wall -Wextra

assembly : bootsect.S
	as -o bootsect.o bootsect.S
	ld -m elf_x86_64 Ttext 0x0 -s --oformat binary -o linux.img bootsect.o

QEMU := $(shell which qemu-system-i386) #find qemu-system-i386 in the system path

test:                                   #test target to run the generated linux.img in QEMU
	$(QEMU) -boot a -fda linux.img
	
clean :
	rm -f *.o 