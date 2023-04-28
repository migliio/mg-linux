#!/bin/sh

mkdir -p $HOME/sources
cd $HOME/sources
wget $(curl -S https://www.kernel.org/ | sed -n 's/.*href="\(.*linux-[0-9]*\.[0-9]*\.[0-9]*\.tar\.xz\)".*/\1/p' | head -n 1)
tar -xvf linux-*.tar.xz
rm linux-*.tar.xz
mv linux-* linux/

make x86_64_defconfig
make -j4 bzImage
