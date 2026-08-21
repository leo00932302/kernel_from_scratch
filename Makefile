AS = i686-linux-gnu-as
LD = i686-linux-gnu-ld
CC = i686-linux-gnu-gcc
# LDFLAG = -Ttext 0x0 -s --oformat binary
# CCFLAG = -Wall -Wextra
CCFLAG = -m32 \
         -march=i386 \
         -I../include \
         -nostdinc \
         -Wall \
         -fomit-frame-pointer \
         -fno-pie \
         -fno-pic \
         -fno-stack-protector \
         -c
LDFLAG = -Ttext 0x0 -s --oformat binary -m elf_i386

linux.img: tools/build bootsect setup kernel/system
	./tools/build bootsect setup kernel/system > $@
bootsect : bootsect.o
	$(LD) $(LDFLAG) -o $@ $<
# main.o : main.c
# 	$(CC) $(CCFLAG) -c main.c -o main.o
bootsect.o : bootsect.S
	$(AS) -o bootsect.o bootsect.S
setup.o : setup.S
	$(AS) -o setup.o setup.S
setup : setup.o
	$(LD) $(LDFLAG) -e _start_setup -o $@ $<
tools/build : tools/build.c
	gcc -o $@ $<
kernel/system :
	cd kernel;make system;cd ..

#build and test the linux.img in QEMU	
QEMU := $(shell which qemu-system-i386) #find qemu-system-i386 in the system path
test:                                   #test target to run the generated linux.img in QEMU
#$(QEMU) -boot a -fda linux.img //the instruction need GTK window tool to display on screen,the tool is designed for grapic
	$(QEMU) -boot a -drive file=linux.img,format=raw,if=floppy -display curses
.PHONY: clean
clean :
	rm -f *.o linux.img setup bootsect tools/build *.o