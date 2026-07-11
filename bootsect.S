SETUPLEN = 4  

BOOTSEG = 0x7c0

INITSEG = 0x9000

SETUPSEG = 0x9020

SYSSEG = 0x1000

ENDSEG = SETUPSEG+SYSSIZE

ROOT_DEV = 0x000

.code16
.text

.global _start
_start:
    jmpl $BOOTSEG , $start2

start2:
    movw $BOOTSEG, %ax
    movw %ax, %ds
    movw $INITSEG, %ax
    movw %ax, %es
    movw $256, %cx
    subw %si, %si
    subw %di, %di
    
    rep
    movsw

    jmpl $INITSEG, $go

go:
    movw %cs, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    movw $0xFF00, %sp



.org 510
boot_flag:
    .word 0xaa55
