
Cross Compile of ALSA Library for Raspberry Pi and BeagleBone
=============================================================

This repository contains make files for easy cross compile of the ALSA Library for Raspberry Pi and BeagleBone.

Get tool and source code
========================

## ed_alsa_lib
```bash
git clone https://github.com/embed-dsp/ed_alsa_lib.git
```

## ALSA Library Source
```bash
# Enter the ed_alsa_lib directory.
cd ed_alsa_lib

# Clone ALSA Library repository.
make clone

# Pull latest updates from ALSA Library repository.
make pull

# Edit the Makefile for selecting the ALSA Library source version.
vim Makefile
PACKAGE_VERSION = v1.1.3
```

Build
=====
```bash
# Checkout specific version and rebuild configure.
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
        ├── bcm2835         # Raspberry Pi Zero, Raspberry Pi Zero Wireless
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        ├── bcm2836         # Raspberry Pi 2 Model B
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        ├── bcm2837         # Raspberry Pi 3 Model B
        │   ├── bin
        │   │   └── aserver
        │   └── lib
        │       ├── libasound.a
        │           ...
        └── share           # ...
            ...
```

Notes
=====

dnf install automake
dnf install libtool
