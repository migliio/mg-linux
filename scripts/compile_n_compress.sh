#!/bin/sh

set -e

if [ $# -eq 0 ]; then
    echo "usage: ./compile_n_compress.sh <exploit-src> [<initramfs-dir>]"
 exit 1
fi

if [ ! -z "$2" ]; then
    gcc -o exploit -static $1
    mv ./exploit $2
    cd $2
    find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz
else
    gcc -o exploit -static $1
    mv ./exploit $HOME/staging/initramfs/fs/
    cd $HOME/staging/initramfs/fs/
    find . -print0 | cpio --null -ov --format=newc | gzip -9 > $HOME/staging/initramfs-busybox-x86.cpio.gz
    rm $HOME/staging/initramfs/fs/exploit
fi
