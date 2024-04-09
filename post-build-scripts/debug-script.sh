#!/bin/sh
TARGETDIR=$1

echo "debugfs /sys/kernel/debug/ debugfs defaults 0 0" >> $TARGETDIR/etc/fstab
mkdir -p $TARGETDIR/home/claudio/assets/mg-assets/kernel
mkdir -p $TARGETDIR/root/.ssh
cat ~/.ssh/id_ed25519.pub >> $TARGETDIR/root/.ssh/authorized_keys
echo "hostshare /home/claudio/assets/mg-assets/kernel 9p trans=virtio,version=9p2000.L 0 0" >> $TARGETDIR/etc/fstab
