CC = gcc
FLAGS = -Wall -Wextra

linux.img : bootsect.S head.o
# 	as -o bootsect.o bootsect.S
	ld -m elf_x86_64 Ttext 0x0 -s --oformat binary -o linux.img bootsect.o head.o

main.o : main.c
	$(CC) $(FLAGS) -c main.c -o main.o
head.o : head.S
	as -o head.o head.S
boot.o : boot.S
	as -o boot.o boot.S

#build and test the linux.img in QEMU	
QEMU := $(shell which qemu-system-i386) #find qemu-system-i386 in the system path
test:                                   #test target to run the generated linux.img in QEMU
	$(QEMU) -boot a -fda linux.img
	
.PHONY: clean
clean :
	rm -f *.o linux.img