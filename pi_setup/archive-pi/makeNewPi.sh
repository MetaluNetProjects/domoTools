#!/bin/bash

# Insert a sdcard in your reader.
# Then run:
# sudo ./makeNewPi.sh
# WARNING: any previous content on the sdcard will be lost

DEVICE=/dev/sdd
MOUNTDIR=/mnt/newpi

umount ${DEVICE}1
umount ${DEVICE}2

# format disk:
printf "
type=c, size=60MiB
type=83
" | sfdisk ${DEVICE}

mkfs.vfat ${DEVICE}1
fatlabel ${DEVICE}1 boot

mkfs.ext4 ${DEVICE}2
e2label ${DEVICE}2 root

rm -rf $MOUNTDIR
mkdir -p ${MOUNTDIR}/boot
mkdir -p ${MOUNTDIR}/root

mount ${DEVICE}1 ${MOUNTDIR}/boot
mount ${DEVICE}2 ${MOUNTDIR}/root

#exit

#if [ x$1 = x ] || [ x$2 = x ] ; then echo "error: no rPi disks specified (e.g /media/boot /media/root)" ; #exit ; fi

piBoot=${MOUNTDIR}/boot #$1
piRoot=${MOUNTDIR}/root #$2

archDir=`pwd`

echo " $archDir -> $piBoot , $piRoot"

#To restore this backup on a new sdcard, you first have to format it. Make 2 partitions, first FAT32 and 60MB, the second ext4 and big enough to receive all the backup datas. Then extract the 2 archivess to the new 2 partitions with this command :
tar -xvpzf $archDir/boot.tar.gz -C $piBoot --numeric-owner
tar -xvpzf $archDir/system.tar.gz -C $piRoot --numeric-owner

umount ${DEVICE}1
umount ${DEVICE}2



