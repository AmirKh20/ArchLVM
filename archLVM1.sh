#!/bin/sh

# ArchLVM
# Autor : Amir Kh
# Thanks to jay from LearnLinuxTV Youtube Channel
# First Part of Script for my arch installation with LDM

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
   echo "stop the script and fix that!"   
fi
echo

clear
#ping test
ping -c 5 google.com
echo
echo
echo "if you didnt get ping, stop this script and try some solution from wiki"
echo "press Enter to continue ..."
read key
echo

#refresh mirrorlist
pacman -Syyy

#edit mirrorlist
echo
echo
echo "edit this file to get better speed"
echo "press Enter to edit"
read key
vim /etc/pacman.d/mirrorlist
pacman -Syyy
clear

#fdisk
echo "after you set the partition run the archLVM2.sh script"
echo "press Enter to continue , MAKE SURE YOU EDITED THE <> PART"
read key
fdisk -l

#Edit <>
#you should change </dev/sda> to your disk name. you can look it up with 'fdisk -l as above' command. MAKE SURE you removed the '<' and '>'.
fdisk </dev/sda>
