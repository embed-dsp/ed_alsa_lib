#!/bin/sh

# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

kernel=$(uname -s)
machine=$(uname -m)

# kernel="Linux"
# kernel="CYGWIN_NT-10.0-WOW"
# kernel="CYGWIN_NT-10.0"
# kernel="Fubar"

# machine="i386"
# machine="i686"
# machine="x86_64"
# machine="amd64"
# machine="armv6l"
# machine="armv7l"

# Unify Intel/AMD machine names.
case $machine in
    i386)
        machine="x86"
        ;;
    i686)
        machine="x86"
        ;;
    amd64)
        machine="x86_64"
        ;;
esac

# Normalize kernel names.
case $kernel in
    Linux*)
        kernel=linux
        ;;
    CYGWIN*)
        kernel=cygwin
        ;;
    *)
        echo "* ERROR *: Unknown kernel: $kernel"
        exit 1
esac

arch="$kernel"_"$machine"
echo $arch
