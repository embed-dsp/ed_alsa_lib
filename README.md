
Cross Compile of ALSA Library for Raspberry Pi and BeagleBone
=============================================================

This repository contains make files for easy cross compile of the ALSA Library for Raspberry Pi and BeagleBone.

Prerequisites
=============

## Fedora-27
```bash
dnf install automake
dnf install libtool
```

Get Source Code
===============

## ed_alsa_lib
```bash
git clone https://github.com/embed-dsp/ed_alsa_lib.git
```

## ALSA Library
```bash
# Enter the ed_alsa_lib directory.
cd ed_alsa_lib

# Clone the ALSA Library git repository.
make clone

# Pull latest updates from the ALSA Library git repository.
make pull

# Edit the Makefile for selecting the ALSA Library source version (git master branch / git tag).
vim Makefile
PACKAGE_VERSION = v1.1.3
```

Select SoC
==========
The ALSA Library can be compiled in one of two ways:
1. Using default compiler options.
    * In this case the platform architecture is given by the script: `bin/get_arch.sh`
2. Using fine tuned compiler optimizations for a specific SoC.
    * In this case the platform architecture is the same as the SoC name.
    * The SOC specific compiler options are stored in the make file: `make/soc.mk`

```bash
# Edit the Makefile for selecting the desired SOC or for not selecting a SOC at all.
vim Makefile
```

```bash
# Raspberry Pi Zero
# Raspberry Pi Zero Wireless
SOC = bcm2835

# Raspberry Pi 2 Model B
SOC = bcm2836

# Raspberry Pi 3 Model B
SOC = bcm2837

# BeagleBone Black
# BeagleBone Black Wireless
# BeagleBone Blue
SOC = am3358
```

Select Tool Chain
=================
The ALSA Library can be compiled in one of two ways:
1. Using the native compiler on the local platform.
    * This option is automatically selected in case no SoC has been selected.
2. Using a cross-compiler on the local platform.

```bash
# Edit the Makefile for selecting the desired compiler tool chain.
vim Makefile
```

```bash
# Native compile.
#TOOL_CHAIN = /usr/bin
#TOOL_TRIPLET =
#TOOL_PREFIX = 

# Cross Compile: Raspberry Pi tool chain (Linux): GCC 4.9.3, Default: 32-bit ARMv6 Cortex-A, hard-float, little-endian
#TOOL_CHAIN = /opt/raspberry/tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
#TOOL_TRIPLET = arm-linux-gnueabihf
#TOOL_PREFIX = $(TOOL_TRIPLET)-

# Cross Compile: Linaro tool chain (Linux): GCC 7.2.1, Default: 32-bit ARMv8 Cortex-A, hard-float, little-endian
TOOL_CHAIN = /opt/gcc-arm/gcc-linaro-7.2.1-2017.11-x86_64_armv8l-linux-gnueabihf/bin
TOOL_TRIPLET = armv8l-linux-gnueabihf
TOOL_PREFIX = $(TOOL_TRIPLET)-
```

Build
=====
```bash
# Checkout specific version and rebuild configure script.
make prepare

# Configure source code.
make configure

# Compile source code using 4 simultaneous jobs (Default: J=4).
make compile
make compile J=4
```

Install
=======
```bash
# Install build products.
sudo make install
```

The build products are installed in the following locations:
```bash
opt
└── alsa
    └── alsa-lib-v1.1.3
        ├── include         # Include directory.
        │   ├── alsa
        │   │   ├── asoundlib.h
        │   │       ...
        │   └── sys
        │       └── asoundlib.h
        ├── share           # Architecture independent data files.
        │   ...
        ├── bcm2835         # SOC=bcm2835: Raspberry Pi Zero, Raspberry Pi Zero Wireless
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        ├── bcm2836         # SOC=bcm2836: Raspberry Pi 2 Model B
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        ├── bcm2837         # SOC=bcm2837: Raspberry Pi 3 Model B
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        ├── linux_armv6l    # Local build on: Raspberry Pi Zero, Raspberry Pi Zero Wireless
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        ├── linux_armv7l    # Local build on: Raspberry Pi 3 Model B
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        └── linux_x86_64    # Local build on: Fedora-27 (64-bit) Linux
            ├── bin
            │   └── aserver
            └── lib
                ├── libasound.a
                    ...
```

Notes
=====
