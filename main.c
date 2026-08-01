//kernel/main.c
void main(void){
    tty_init();
    __asm__ __volatile__(
        "loop:\n\r"
        "jmp loop"
        ::
    );
}

//kernel/chr_drv/tty_io.c
#include<linux/tty.h>
void tty_init(void){
    con_init();
}