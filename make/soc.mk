
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# ----------------------------------------
# Raspberry Pi Zero
# Raspberry Pi Zero Wireless
# Raspberry Pi 1 Model A+
# Raspberry Pi 1 Model B+
# ----------------------------------------
# ARCH: ARMv6Z (32-bit)
# CORE: Single-core ARM1176JZF-S
ifeq ($(SOC), bcm2835)
CPPDEFINES += -DSOC_BCM2835
# Generate code in ARM state (Needed for hard vfp floating point on armv6).
CCFLAGS += -marm
# Generate code in Thumb state.
#CCFLAGS += -mthumb
# Processor
CCFLAGS += -march=armv6zk -mtune=arm1176jzf-s
# Floating point
CCFLAGS += -mfloat-abi=hard
CCFLAGS += -mfpu=vfpv2
#CCFLAGS += -ftree-vectorize
#CCFLAGS += -ftree-vectorizer-verbose=9
#CCFLAGS += -funsafe-math-optimizations
endif # SOC

# ----------------------------------------
# Raspberry Pi 2 Model B
# ----------------------------------------
# ARCH: ARMv7-A (32-bit)
# CORE: Quad-core ARM Cortex-A7
ifeq ($(SOC), bcm2836)
CPPDEFINES += -DSOC_BCM2836
# Generate code in ARM state.
CCFLAGS += -marm
# Generate code in Thumb state.
#CCFLAGS += -mthumb
# Processor
CCFLAGS += -march=armv7-a -mtune=cortex-a7
# Floating point
CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=vfpv4
CCFLAGS += -mfpu=neon-vfpv4
# CCFLAGS += -ftree-vectorize
# CCFLAGS += -ftree-vectorizer-verbose=9
# CCFLAGS += -funsafe-math-optimizations
endif # SOC


# ----------------------------------------
# Raspberry Pi 3 Compute
# Raspberry Pi 3 Model B
# Raspberry Pi 3 Model B+
# ----------------------------------------
# ARCH: ARMv8-A (32/64-bit)
# CORE: Quad-core ARM Cortex-A53
ifeq ($(SOC), bcm2837)
CPPDEFINES += -DSOC_BCM2837
# Generate code in ARM state.
CCFLAGS += -marm
# Generate code in Thumb state.
#CCFLAGS += -mthumb
# Processor
CCFLAGS += -march=armv8-a -mtune=cortex-a53
# Floating point
CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=fp-armv8
CCFLAGS += -mfpu=neon-fp-armv8
#CCFLAGS += -mfpu=crypto-neon-fp-armv8
# CCFLAGS += -ftree-vectorize
# CCFLAGS += -ftree-vectorizer-verbose=9
# CCFLAGS += -funsafe-math-optimizations
endif # SOC


# ----------------------------------------
# BeagleBone Black
# BeagleBone Black Wireless
# BeagleBone Blue
# PocketBeagle
# ----------------------------------------
# ARCH: ARMv7-A (32-bit)
# CORE: Single-core ARM Cortex-A8
ifeq ($(SOC), am3358)
CPPDEFINES += -DSOC_AM3358
# Generate code in ARM state.
CCFLAGS += -marm
# Generate code in Thumb state.
#CCFLAGS += -mthumb
# Processor
CCFLAGS += -march=armv7-a -mtune=cortex-a8
# Floating point
CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=vfpv3
CCFLAGS += -mfpu=neon-vfpv3
# CCFLAGS += -ftree-vectorize
# CCFLAGS += -ftree-vectorizer-verbose=9
# CCFLAGS += -funsafe-math-optimizations
endif # SOC
