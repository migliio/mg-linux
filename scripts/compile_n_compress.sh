#!/bin/sh

if [ $# -ne 1 ]; then
    echo "usage: ./compile_n_compress.sh <src>"
 exit 1
fi

gcc -o exploit -static $1
mv ./exploit $HOME/staging/initramfs/fs/
cd $HOME/staging/initramfs/fs/
find . -print0 \
| cpio --null -ov --format=newc \
| gzip -9 > initramfs.cpio.gz
find . -print0 | cpio --null -ov --format=newc | gzip -9 > $HOME/staging/initramfs-busybox-x86.cpio.gz
rm $HOME/staging/initramfs/fs/exploit
