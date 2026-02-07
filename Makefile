# .PHONY = clean 
# CC = gcc
# FLAGS = -Wall -Wextra

# asm_kernel : bootsect.S
# 	export PATH="$(brew --prefix binutils)/bin:$PATH"
# 	gas --32 -o bootsect.o bootsect.s
# 	gld -m elf_i386 -Ttext 0x7c00 -o bootsect.elf bootsect.o
# 	gobjcopy -O binary bootsect.elf boot.bin
# 	which gas gld gobjcopy
# 	gas --version

# 	ls -l boot.bin
# run_kernel : bootsect.s
# 	./qemu-system-i386.exe -boot a -fda linux.img
# clean :
# 	rm -rf *.o
# Makefile for 16-bit boot sector (GAS/AT&T) -> linux.img -> run with QEMU

# BINUTILS_PREFIX := $(shell brew --prefix binutils 2>/dev/null)
# GAS      := $(BINUTILS_PREFIX)/bin/gas
# GLD      := $(BINUTILS_PREFIX)/bin/gld
# GOBJCOPY := $(BINUTILS_PREFIX)/bin/gobjcopy

# QEMU := qemu-system-i386

# BOOT_SRC := bootsect.s
# BOOT_OBJ := bootsect.o
# BOOT_ELF := bootsect.elf
# BOOT_BIN := boot.bin
# IMG      := linux.img

# .PHONY: all run clean toolcheck
# all: $(IMG)

# toolcheck:
# 	@echo "BINUTILS_PREFIX=$(BINUTILS_PREFIX)"
# 	@test -x "$(GAS)" || (echo "ERROR: GNU gas not found. Run: brew install binutils" && exit 1)
# 	@test -x "$(GLD)" || (echo "ERROR: GNU ld not found. Run: brew install binutils" && exit 1)
# 	@test -x "$(GOBJCOPY)" || (echo "ERROR: GNU objcopy not found. Run: brew install binutils" && exit 1)
# 	@$(GAS) --version | head -n 1
# 	@$(GLD) --version | head -n 1
# 	@$(GOBJCOPY) --version | head -n 1
# 	@$(QEMU) --version | head -n 1

# $(BOOT_BIN): $(BOOT_SRC) toolcheck
# 	$(GAS) --32 -o $(BOOT_OBJ) $(BOOT_SRC)
# 	$(GLD) -m elf_i386 -Ttext 0x7c00 -o $(BOOT_ELF) $(BOOT_OBJ)
# 	$(GOBJCOPY) -O binary $(BOOT_ELF) $(BOOT_BIN)
# 	@ls -l $(BOOT_BIN)

# $(IMG): $(BOOT_BIN)
# 	dd if=/dev/zero of=$(IMG) bs=1m count=10
# 	dd if=$(BOOT_BIN) of=$(IMG) conv=notrunc bs=512 count=1
# 	@ls -l $(IMG)
# 	@echo "Boot signature (should end with 55 aa):"
# 	@xxd -g 1 -l 512 $(IMG) | tail -n 2

# run: $(IMG)
# 	$(QEMU) -drive format=raw,file=$(IMG)

# clean:
# 	rm -f $(BOOT_OBJ) $(BOOT_ELF) $(BOOT_BIN) $(IMG)
