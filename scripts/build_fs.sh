#!/bin/sh

set -e

DIRECTORY=$HOME/sources/busybox-1.32.1

if [ ! -d "$DIRECTORY"  ]; then
    echo "[!] path to busybox not found, downloading and building it..."
    mkdir -p $HOME/sources
    cd $HOME/sources
    wget https://busybox.net/downloads/busybox-1.32.1.tar.bz2
    tar xvjf busybox-1.32.1.tar.bz2
    cd $DIRECTORY
    make defconfig
    LDFLAGS="--static" make -j4 install
fi

rm -rf $HOME/staging/initramfs
mkdir -p $HOME/staging/initramfs/fs

cd $HOME/staging/initramfs/fs
mkdir -pv bin sbin etc proc sys usr/bin usr/sbin
cp -av $DIRECTORY/_install/* .
rm -f ./init
echo "#!/bin/sh" >> ./init
echo "mount -t proc none /proc" >> ./init
echo "mount -t sysfs none /sys" >> ./init
echo "exec /bin/sh" >> ./init
chmod +x ./init
find . -print0 | cpio --null -ov --format=newc | gzip -9 > $HOME/staging/initramfs-busybox-x86.cpio.gz
cd $HOME/staging
