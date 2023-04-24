#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]; then
    echo "usage: ./start_qemu_kernel.sh <kernel-image> <file-system-image>"
 exit 1
fi

qemu-system-x86_64 \
    -m 128M \
    -nographic \
    -kernel $1 \
    -append 'console=ttyS0 loglevel=3 oops=panic panic=1 kaslr' \
    -monitor /dev/null \
    -initrd $2  \
    -cpu qemu64 \
    -smp cores=2
