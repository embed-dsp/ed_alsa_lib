
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# ----------------------------------------
# ARCH: ?
# CORE: ?
ifeq ($(SOC), generic)
endif


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
ifeq ($(BARE_METAL), 0)
CCFLAGS += -mfloat-abi=hard
CCFLAGS += -mfpu=vfpv3
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
else
CCFLAGS += -mfloat-abi=softfp
#CCFLAGS += -mfloat-abi=hard
CCFLAGS += -mfpu=vfpv3
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
endif # BARE_METAL
endif # SOC

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
ifeq ($(BARE_METAL), 0)
CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=vfpv4
CCFLAGS += -mfpu=neon-vfpv4
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
else
CCFLAGS += -mfloat-abi=softfp
#CCFLAGS += -mfpu=vfpv4
CCFLAGS += -mfpu=neon-vfpv4
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
endif # BARE_METAL
endif # SOC


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
ifeq ($(BARE_METAL), 0)
CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=vfpv4
#CCFLAGS += -mfpu=neon
CCFLAGS += -mfpu=neon-vfpv4
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
else
CCFLAGS += -mfloat-abi=softfp
#CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=vfpv4
#CCFLAGS += -mfpu=neon
CCFLAGS += -mfpu=neon-vfpv4
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
endif # BARE_METAL
endif # SOC


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
ifeq ($(BARE_METAL), 0)
CCFLAGS += -mfloat-abi=hard
#CCFLAGS += -mfpu=vfpv4
CCFLAGS += -mfpu=neon-vfpv4
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
else
CCFLAGS += -mfloat-abi=softfp
#CCFLAGS += -mfpu=vfpv4
CCFLAGS += -mfpu=neon-vfpv4
CCFLAGS += -ftree-vectorize
CCFLAGS += -ftree-vectorizer-verbose=9
CCFLAGS += -funsafe-math-optimizations
endif # BARE_METAL
endif # SOC
