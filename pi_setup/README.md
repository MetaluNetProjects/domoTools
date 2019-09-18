# How to setup a raspberryPi 3 to make it a Domophone

## From scratch Raspbian install
### choose keyboard:
loadkeys fr (or whatever)  
### configure the Pi:
Run ``` sudo raspi-config```: setup language, wifi, hostname; enable ssh-server, choose "Console Autologin" as boot option.   
Change passwd.  
Run:
```
sudo apt-get update  
sudo apt-get dist-upgrade  
sudo apt-get install git  
ssh-keygen  
# 'editor_hostname'/'editor_user' is the computer you will want to login from without password: 
scp @editor_hostname.local:/home/@editor_user/.ssh/id_rsa.pub > authorized_keys  
```

## Download, compile and install Pure Data
### download:
mkdir ~/sources  
cd ~/sources/  
git clone https://github.com/pure-data/pure-data.git  
### install dependencies:
sudo apt-get install build-essential automake autoconf libtool gettext  
sudo apt-get install libasound2-dev libjack-jackd2-dev  
sudo apt-get install libfftw3-dev  
sudo apt-get install tk  
### compile:
cd pure-data/  
./configure --enable-jack --enable-fftw  
make -j4  
### install:
sudo make install  
### enable realtime priority for pi user:
Add to /etc/security/limits.d/99-realtime.conf:  
```
    @audio   -  rtprio     99  
	@audio   -  memlock    unlimited  
```
Add pi to group audio:  
```
sudo usermod -a -G audio pi  
```

(realtime will be actually enabled after next login)

## Install Pd externals

```
mkdir ~/pd-externals
```

Configure deken to install new externals to ~/pd-externals.

### externals to install:
- moonlib
- iemlib
- ggee
- hcs
- motex
- zexy
- creb
- maxlib
- AutoPreset
- comport

### download Fraise:
cd ~/pd-externals ; git clone https://github.com/MetaluNet/Fraise.git

### download domoTools (if not already included in the project you'll run):
cd ~ ; git clone --recurse-submodules https://github.com/MetaluNetProjects/domoTools.git

## Autostart the patch

mkdir ~/bin  
copy to ~/bin the files:

- addnameserver
- app
- appnogui
- ro
- rw
- ENTRY_PATCH.txt
- sdtool/ directory

Allow execution of the bash scripts:  
```
cd ~/bin
sudo chmod a+x app appnogui ro rw addnameserver
```

Add to .profile:  
```
	XAUTHORITY="/tmp/.Xauthority"
	[ -z $DISPLAY ]  && ~/bin/appnogui
```

Allow running X from SSH:
```
echo "XAUTHORITY=/tmp/.Xauthority" > ~/.ssh/environment
sudo sh -c "echo PermitUserEnvironment yes >> /etc/ssh/sshd_config"
```

## Lock the system (make it read-only)

Install and execute Adafruit read-only converting script:
```
cd ~
wget https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/read-only-fs.sh  
sudo bash read-only-fs.sh
```

Create next dhcpdc leases on a RAM disk:  
```
sudo mv /var/lib/dhcpcd5/ /var/lib/dhcpcd5-orig  
sudo ln -s /var/tmp/ /var/lib/dhcpcd5
```

Now that the OS boots in read-only mode, before making any change to the disk you will have to type:  
``` rw ```

After the OS is remounted in read-write mode, don't forget to cleanly halt (sudo halt) or remount read-only by typing the command:  
``` ro ```

If the OS has not been set to read-only mode, it can be *safely* turned off by simply removing the power.

## Edit the Pd patch
Edit the absolute path of the main entry Pd patch in ~/bin/ENTRY_PATCH.txt (default: /home/pi/Documents/main_entry_patch.pd).

The patch will be executed automatically at boot time, without the Pd GUI. 

### local edition:

If you are typing on the keyboard connected to the Pi, and if the Pi is also connected to a screen, you can edit the patch locally.  
First, stop Pd by pressing "Ctrl+C". Start graphical mode by typing ```startx```, then open a Terminal and type:  
```
app&  
```
to run the Pd patch.

If you want to modify the patch, unlock the OS:  
```
rw
```
When all saving is done, re-lock:  
```
ro
```


But the best way is to connect to the Pi from another computer with SSH:

### edition via SSH:
From a X11 compatible host connected to the same network, do:  

```
ssh -X pi@PI_HOSTNAME.local  
app&  
```
If you want to modify the patch, unlock the OS:  
```
rw
```
When all saving is done, re-lock:  
```
ro
```


