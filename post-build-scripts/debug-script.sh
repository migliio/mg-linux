#!/bin/sh
TARGETDIR=$1

mkdir -p $TARGETDIR/sys/kernel/debug/ 
echo "debugfs /sys/kernel/debug/ debugfs defaults 0 0" >> $TARGETDIR/etc/fstab
mkdir -p $TARGETDIR/home/claudio/assets/mg-assets/kernel
mkdir -p $TARGETDIR/root/.ssh
rm -f $TARGETDIR/root/.ssh/authorized_keys
cat ~/.ssh/id_ed25519.pub >> $TARGETDIR/root/.ssh/authorized_keys
echo "hostshare /home/claudio/assets/mg-assets/kernel 9p trans=virtio,version=9p2000.L 0 0" >> $TARGETDIR/etc/fstab
echo "auto eth0" > $TARGETDIR/etc/network/interfaces
echo "iface eth0 inet dhcp" >> $TARGETDIR/etc/network/interfaces
