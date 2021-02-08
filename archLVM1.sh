#!/bin/sh

# Autor : Amir Kh
# First Part of Script for my arch installation with LDM
# ArchLVM

echo "Welcome to my arch installation script!"
echo
echo "This is written by AmirKh-prog"
echo
echo "My github: https://github.com/AmirKh-prog"
echo
echo "NOTE: this is with LVM"
echo "NOTE: MAKE SURE YOU EDITED LAST LINE OF THIS SCRIPT!!!"
echo

#UEFI Check
echo "Check if we are in UEFI"
echo
ls /sys/firmware/efi/efivars

#check internet
echo
echo
echo "Check ip address"
ip a

echo
echo "did you get an ip? [y/n]: "
read ip

#connect to wifi
if [ $ip == y ]
then
   echo "ok!"
else
   echo "pick your wifi"
   wifi-menu
   echo
   echo "check ip again"
   ip a
   echo
   
   echo "did you get an ip?[y/n]: "
   read ip
   if [ $ip == y ]
   then
	echo "great"
   
   else
	dhcpcd
	echo
	ip a
   fi
	
fi
echo

clear
#ping test
ping -c 5 google.com
echo "if you didnt get ping, stop this script and try some solution from wiki"
echo "press Enter to continue ..."
read key
echo

#refresh mirrorlist
pacman -Syyy

#edit mirrorlist
echo "edit this file to get better speed"
echo "press Enter to continue"
read key

vim /etc/pacman.d/mirrorlist
pacman -Syyy

clear
#fdisk
echo "after you did the partition run the archIS2.sh script"
echo "press Enter to continue , MAKE SURE YOU EDITED THE <> PART"
read key
fdisk -l
#Edit this
fdisk </dev/sda>
