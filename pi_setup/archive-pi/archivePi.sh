#!/bin/bash

# mount your rPi sdcard to e.g /media/USER/boot /media/USER/root (automatic on some OSes)
# then run: 
#   ./archivePi.sh /media/USER/boot /media/USER/root
# The sdcard partitions will be archived to boot.tar.gz and system.tar.gz.

if [ x$1 = x ] || [ x$2 = x ] ; then echo "error : no rPi disks specified (e.g /media/boot /media/root)" ; exit ; fi

piBoot=$1
piRoot=$2

archDir=`pwd`

echo "$piBoot , $piRoot -> $archDir"

cd $piBoot
sudo tar -cpzf $archDir/boot.tar.gz --one-file-system .

cd $piRoot
sudo tar -cpzf $archDir/system.tar.gz --one-file-system .

cd $archDir



