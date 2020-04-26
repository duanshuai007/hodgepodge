obj-m := io.o
KERNELDIR:=/lib/modules/$(shell uname -r)/build
#KERNELDIR=/home/duan/crosstool/kernel/3.6.6/linux-3.6.6_back
PWD:=$(shell pwd)
modules:
	make -C $(KERNELDIR) M=$(PWD) modules
clean:
	@rm -rf *.o *.ko *.mod.c *.order *.symvers
