
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# dnf install automake
# dnf install libtool

BARE_METAL = 0

# ----------------------------------------
# System-on-Chip (SoC)
# ----------------------------------------
# No specific SoC
#SOC = generic

# Raspberry Pi Zero
# Raspberry Pi Zero Wireless
#SOC = bcm2835

# Raspberry Pi 2 Model B
#SOC = bcm2836

# Raspberry Pi 3 Model B
SOC = bcm2837

# BeagleBone Black
# BeagleBone Black Wireless
# BeagleBone Blue
#SOC = am3358

# ----------------------------------------
# Tool Chain
# ----------------------------------------
# Native compile.
#TOOL_CHAIN = /usr/bin
#TOOL_PREFIX = 

# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.8.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#TOOL_CHAIN = /opt/raspberry/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
#TOOL_PREFIX = arm-linux-gnueabihf-

# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.9.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#TOOL_CHAIN = /opt/raspberry/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
#TOOL_PREFIX = arm-linux-gnueabihf-

# Cross Compile: Linaro tool chain (Linux): GCC 7.1.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
#TOOL_CHAIN = /opt/gcc-arm/gcc-linaro-7.1.1-2017.08-x86_64_armv8l-linux-gnueabihf/bin
#TOOL_PREFIX = armv8l-linux-gnueabihf-

# Cross Compile: Linaro tool chain (Linux): GCC 7.2.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
TOOL_CHAIN = /opt/gcc-arm/gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf/bin
TOOL_PREFIX = armv8l-linux-gnueabihf-

# FIXME: HOST
HOST = armv8l-linux-gnueabihf

# ----------------------------------------
# Installation destination.
# ----------------------------------------
DESTDIR = /opt/ed_pi_alsa

# ----------------------------------------
# C / C++ Compiler
# ----------------------------------------
CC = $(TOOL_CHAIN)/$(TOOL_PREFIX)gcc

CCFLAGS =

# Optimization
#CCFLAGS += -O0
#CCFLAGS += -O1
CCFLAGS += -O2
#CCFLAGS += -O3
#CCFLAGS += -Ofast
#CCFLAGS += -Os

# ----------------------------------------

include make/soc.mk


PATH:=$(TOOL_CHAIN):$(PATH)

PREFIX = $(DESTDIR)
EXEC_PREFIX = $(PREFIX)/$(SOC)


all:
	@echo ""
	@echo "make distclean"
	@echo ""
	@echo "make build"
	@echo ""
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile"
	@echo ""
	@echo "sudo make install"
	

.PHONY: build
build: prepare configure compile
	
	
.PHONY: prepare
prepare:
	# Discard any local changes
	cd alsa-lib && git checkout -- .
	
	# Checkout specific version
	cd alsa-lib && git checkout v1.1.3
	
	# Rebuild configure
	cd alsa-lib && autoreconf -f -i
	

.PHONY: configure
configure:
	cd alsa-lib && ./configure CFLAGS="$(CCFLAGS)" --host=$(HOST) --prefix=$(PREFIX) --exec-prefix=$(EXEC_PREFIX) --enable-static --disable-shared --disable-python
	

.PHONY: compile
compile:
	cd alsa-lib && make -j4
	cd alsa-lib && make check
	

.PHONY: install
install:
	cd alsa-lib && make install
#	-mkdir -p $(EXEC_PREFIX)/test
	# Only when compiling with shared libraries.
#	-cp alsa-lib/test/.libs/* $(EXEC_PREFIX)/test


.PHONY: distclean
distclean:
	cd alsa-lib && make distclean
	

.PHONY: clean
clean:
	cd alsa-lib && make clean
