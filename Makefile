
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

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

# Package version number (git TAG)
PACKAGE_VERSION = v1.1.3

PACKAGE_NAME = alsa-lib
PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif

PREFIX = /opt/alsa/$(PACKAGE)
EXEC_PREFIX = $(PREFIX)/$(SOC)


all:
	@echo ""
	@echo "## Get the source"
	@echo "make clone      # Clone git repository"
	@echo "make pull       # Pull latest updates from git repository"
	@echo ""
	@echo "## Build"
	@echo "make prepare    # Checkout specific version and rebuild configure"
	@echo "make configure"
	@echo "make compile"
	@echo ""
	@echo "## Install"
	@echo "sudo make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean      # Clean all build products"
	@echo "make distclean  # Clean all build products"
	@echo ""


.PHONY: clone
clone:
	git clone git://git.alsa-project.org/alsa-lib.git


.PHONY: pull
pull:
	# Discard any local changes
	cd $(PACKAGE_NAME) && git checkout -- .
	
	# Checkout master branch
	cd $(PACKAGE_NAME) && git checkout master
	
	# ...
	cd $(PACKAGE_NAME) && git pull

	
.PHONY: prepare
prepare:
	# Checkout specific version
	cd $(PACKAGE_NAME) && git checkout $(PACKAGE_VERSION)
	
	# Rebuild configure
	cd $(PACKAGE_NAME) && autoreconf -f -i


.PHONY: configure
configure:
	cd $(PACKAGE_NAME) && ./configure CFLAGS="$(CCFLAGS)" --host=$(TOOL_TRIPLET) --prefix=$(PREFIX) --exec-prefix=$(EXEC_PREFIX) --enable-static --disable-shared --disable-python


.PHONY: compile
compile:
	cd $(PACKAGE_NAME) && make -j$(J)


.PHONY: install
install:
	cd $(PACKAGE_NAME) && make install


.PHONY: clean
clean:
	cd $(PACKAGE_NAME) && make clean


.PHONY: distclean
distclean:
	cd $(PACKAGE_NAME) && make distclean
