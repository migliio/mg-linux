#!/bin/sh

if [! -z ./initramfs ]; then
    read -p "The initramfs file already exists. Are you sure to delete it? [y/n] " choice
    if [[ "${choice}" =~ ^[Yy]$ ]]; then
	rm -rf ./initramfs
    fi
fi
    
mkdir -p initramfs
cd ./initramfs
cp ../initramfs.cpio.gz .
gunzip ./initramfs.cpio.gz
cpio -idm < ./initramfs.cpio
rm ./initramfs.cpio
