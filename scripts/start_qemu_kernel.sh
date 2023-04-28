#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]; then
    echo "usage: ./start_qemu_kernel.sh <kernel-image> <file-system-image>"
 exit 1
fi

qemu-system-x86_64 \
    -m 128M \
    -cpu kvm64,+smep,+smap \
    -kernel $1 \
    -initrd $2 \
    -hdb flag.txt \
    -snapshot \
    -nographic \
    -monitor /dev/null \
    -no-reboot \
    -append "console=ttyS0 kaslr kpti=1 quiet panic=1"
