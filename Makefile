CC = gcc
FLAGS = -Wall -Wextra
LD = ld -m elf_x86_64
LDFLAGS = -Ttext 0x0 -s --oformat binary
# linux.img : bootsect.S head.o
# 	ld -m elf_x86_64 -Ttext 0x0 -s --oformat binary -o linux.img bootsect.o head.o

linux.img : tools/build bootsect setup
	./tools/build bootsect setup > $@

main.o : main.c
	$(CC) $(FLAGS) -c main.c -o main.o
head.o : head.S
	as -o head.o head.S
boot.o : boot.S
	as -o boot.o boot.S
bootsect.o : bootsect.S
	as -o $@ $<
setup.o : setup.S
	as -o $@ $<
setup : setup.o
	$(LD) $(LDFLAGS) -o $@ $<
bootsect : bootsect.o
	ld -m elf_x86_64 -Ttext 0x0 -s --oformat binary -o $@ $<

#build and test the linux.img in QEMU	
QEMU := $(shell which qemu-system-i386) #find qemu-system-i386 in the system path
test:                                   #test target to run the generated linux.img in QEMU
	$(QEMU) -boot a -fda linux.img
	
.PHONY: clean help
clean :
	rm -f *.o linux.img

help :
	@echo "make clean" : 將中間檔案刪除
	@echo "make test"  : 測試img檔案在qemu運作狀況
