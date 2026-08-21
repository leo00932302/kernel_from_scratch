# CC = gcc
# CCFLAG = -m32 -march=i386 -I../include -nostdinc -Wall -fomit-frame-pointer -c
# LD = ld
# LDFLAG = -Ttext 0x0 -s --oformat binary

AS = i686-linux-gnu-as
LD = i686-linux-gnu-ld
CC = i686-linux-gnu-gcc
#CCFLAG = -mcpu=i386 -I../include -nostdinc -Wall -fomit-frame-pointer -c
#CCFLAG = -m32 -march=i386 -I../include -nostdinc -Wall -fomit-frame-pointer -c
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

OBJS = head.o main.o sched.o

system : $(OBJS)
	$(LD) $(LDFLAG) -e startup_32 -o $@ $^

head.o : head.S
	$(CC) -traditional -m32 -c -o $@ $<
main.o : main.c
	$(CC) $(CCFLAG) -o $@ $<
sched.o : sched.c
	$(CC) $(CCFLAG) -o $@ $<
clean :
	rm *.o system