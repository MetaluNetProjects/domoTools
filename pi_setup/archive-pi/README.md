# rPi archive / restore

## Archive your existing rPi installation
- cd to this directory
- mount your rPi sdcard to e.g /media/USER/boot /media/USER/root (automatic on some OSes)
- run:  
```
./archivePi.sh /media/USER/boot /media/USER/root
```
The sdcard partitions will be archived to boot.tar.gz and system.tar.gz.

## Setup a new sdcard with archived installation

- cd to this directory
- make sure boot.tar.gz and system.tar.gz exists
- insert a sdcard in your reader.
- run:
```
# sudo ./makeNewPi.sh
```
**WARNING: any previous content on the sdcard will be lost**

