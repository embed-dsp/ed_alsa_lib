
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
#TOOL_TRIPLET = arm-linux-gnueabihf
#TOOL_PREFIX = $(TOOL_TRIPLET)-

# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.9.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#TOOL_CHAIN = /opt/raspberry/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
#TOOL_TRIPLET = arm-linux-gnueabihf
#TOOL_PREFIX = $(TOOL_TRIPLET)-

# FIXME: Generates "Segmentation fault" for SOC = bcm2835
# Cross Compile: Linaro tool chain (Linux): GCC 7.1.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
#TOOL_CHAIN = /opt/gcc-arm/gcc-linaro-7.1.1-2017.08-x86_64_armv8l-linux-gnueabihf/bin
#TOOL_TRIPLET = armv8l-linux-gnueabihf
#TOOL_PREFIX = $(TOOL_TRIPLET)-

# FIXME: Generates "Segmentation fault" for SOC = bcm2835
# Cross Compile: Linaro tool chain (Linux): GCC 7.2.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
TOOL_CHAIN = /opt/gcc-arm/gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf/bin
TOOL_TRIPLET = armv8l-linux-gnueabihf
TOOL_PREFIX = $(TOOL_TRIPLET)-

# ----------------------------------------
# Installation destination.
# ----------------------------------------
DESTDIR = /opt/ed_alsa

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
#CCFLAGS += -Og

# ----------------------------------------

include make/soc.mk


PATH := $(TOOL_CHAIN):$(PATH)

PREFIX = $(DESTDIR)
EXEC_PREFIX = $(PREFIX)/$(SOC)

ALSA_LIB = alsa-lib


all:
	@echo ""
	@echo "## First time"
	@echo "make clone	    # Get openocd source from git repo"
	@echo "make prepare	    # Checkout specific version"
	@echo "make configure"
	@echo "make compile"
	@echo "sudo make install"
	@echo ""
	@echo "## Any other time"
	@echo "make distclean	    # Clean all build products"
	@echo "make configure"
	@echo "make compile"
	@echo "sudo make install"
	@echo ""


.PHONY: clone
clone:
	git clone git://git.alsa-project.org/alsa-lib.git $(ALSA_LIB)

	
.PHONY: prepare
prepare:
	# Discard any local changes
	cd $(ALSA_LIB) && git checkout -- .
	
	# Checkout specific version
	cd $(ALSA_LIB) && git checkout v1.1.3
	
	# Rebuild configure
	cd $(ALSA_LIB) && autoreconf -f -i


.PHONY: distclean
distclean:
	cd $(ALSA_LIB) && make distclean


.PHONY: clean
clean:
	cd $(ALSA_LIB) && make clean


.PHONY: configure
configure:
	cd $(ALSA_LIB) && ./configure CFLAGS="$(CCFLAGS)" --host=$(TOOL_TRIPLET) --prefix=$(PREFIX) --exec-prefix=$(EXEC_PREFIX) --enable-static --disable-shared --disable-python


.PHONY: compile
compile:
	cd $(ALSA_LIB) && make -j4
#	cd $(ALSA_LIB) && make check


.PHONY: install
install:
	cd $(ALSA_LIB) && make install
#	-mkdir -p $(EXEC_PREFIX)/test
	# Only when compiling with shared libraries.
#	-cp alsa-lib/test/.libs/* $(EXEC_PREFIX)/test
