ARCH=riscv
VERSION=1.40.1
TOOLKIT_DIR=/opt/iarsystems/bx$(ARCH)-$(VERSION)/$(ARCH)

ICC=$(TOOLKIT_DIR)/bin/icc$(ARCH)
ICCFLAGS=--core=RV32IMAC --silent --dlib-config normal -e -I.

ILINK=$(TOOLKIT_DIR)/bin/ilink$(ARCH)
ILINKFLAGS=--entry __iar_program_start --vfe --text_out locale --map . --config $(TOOLKIT_DIR)/config/linker/generic.icf --config_def CSTACK_SIZE=0x1000 --config_def HEAP_SIZE=0x1000 --debug_lib

DEPS=Utilities.h Fibonacci.h

%.o: %.c $(DEPS)
	$(ICC) -o $@ $< $(ICCFLAGS)

fibonacci: Fibonacci.o Utilities.o
	$(ILINK) Fibonacci.o Utilities.o -o Fibonacci.elf $(ILINKFLAGS)


clean:
	rm -f *.o *.map *.elf
