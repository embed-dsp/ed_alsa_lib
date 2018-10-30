
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# Package.
PACKAGE_NAME = alsa-lib

PACKAGE_VERSION = 1.1.7

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# ==============================================================================

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif

# System and Machine.
SYSTEM = $(shell ./bin/get_system.sh)
MACHINE = $(shell ./bin/get_machine.sh)

# System configuration.
CONFIGURE_FLAGS =

# Architecture.
ifeq ($(SOC),)
	ARCH = $(SYSTEM)_$(MACHINE)
else
	ARCH = $(SYSTEM)_$(SOC)
endif

# Tool chain.
TOOL_CHAIN = /usr/bin
TOOL_TRIPLET =

ifeq ($(CROSS_COMPILE),1)
# Linaro tool chain (Linux): GCC 7.3.1, Default: 32-bit ARMv7 Cortex-A, little-endian, hard-float, vfpv3-d16
TOOL_CHAIN = /opt/linaro/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin
TOOL_TRIPLET = arm-linux-gnueabihf

# Raspberry Pi tool chain (Linux): GCC 4.9.3, Default: 32-bit ARMv6 Cortex-A, little-endian, hard-float, vfp
#TOOL_CHAIN = /opt/raspberry/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
#TOOL_TRIPLET = arm-linux-gnueabihf

ifeq ($(SOC),)
$(error The SOC=... variable must be specified when cross compiling.)
endif
endif

# Compiler flags.
CCFLAGS = -Wall

# Optimization
#CCFLAGS += -O0
#CCFLAGS += -O1
CCFLAGS += -O2
#CCFLAGS += -O3
#CCFLAGS += -Ofast
#CCFLAGS += -Os
#CCFLAGS += -Og

include make/soc.mk

# Installation directory.
INSTALL_DIR = /opt
PREFIX = $(INSTALL_DIR)/alsa/$(PACKAGE)
EXEC_PREFIX = $(PREFIX)/$(ARCH)

PATH := $(TOOL_CHAIN):$(PATH)


all:
	@echo "TOOL_CHAIN   = $(TOOL_CHAIN)"
	@echo "TOOL_TRIPLET = $(TOOL_TRIPLET)"
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo ""
	@echo "## Get Source Code"
	@echo "make download"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure [CROSS_COMPILE=1] [SOC=bcm2835|bcm2836|bcm2837|am3358|...]"
	@echo "make compile [CROSS_COMPILE=1] [J=...]"
	@echo ""
	@echo "## Install"
	@echo "sudo make install [CROSS_COMPILE=1]"
	@echo ""
	@echo "## Cleanup"
	@echo "make distclean"
	@echo "make clean"
	@echo ""


.PHONY: download
download:
	-mkdir src
	cd src && wget -nc ftp://ftp.alsa-project.org/pub/lib/$(PACKAGE).tar.bz2

	
.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar jxf ../src/$(PACKAGE).tar.bz2


.PHONY: configure
configure:
	cd build/$(PACKAGE) && ./configure CFLAGS="$(CCFLAGS)" --host=$(TOOL_TRIPLET) --prefix=$(PREFIX) --exec-prefix=$(EXEC_PREFIX) --enable-static --disable-shared --disable-python --disable-silent-rules $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
	cd build/$(PACKAGE) && make -j$(J)


.PHONY: install
install:
	cd build/$(PACKAGE) && make install


.PHONY: clean
clean:
	cd build/$(PACKAGE) && make clean


.PHONY: distclean
distclean:
	cd build/$(PACKAGE) && make distclean
