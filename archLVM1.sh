#!/bin/sh

# ArchLVM
# Autor : Amir Kh
# Thanks to jay from LearnLinuxTV Youtube Channel
# First Part of Script for my arch installation with LVM

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
echo
echo "if there is no Error in the output, then we're in UEFI."
echo "Otherwise please stop this script. and change some of it, or don't use it"

#check internet
echo
echo
echo "Check ip address"
ip a

echo
echo "did you get an ip? [y/n]: "
read ip

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
pacman -Sy
pacman --needed -S reflector

#edit mirrorlist
echo
echo
reflector -c <your country> -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyy
clear

#update the system clock
timedatectl set-ntp true
echo "Check the time status"
echo
timedatectl status
echo

#fdisk
echo "after you set the partitions, edit the second script and then run the archLVM2.sh"
echo "press Enter to set the partitions , MAKE SURE YOU'VE EDITED THE <> PART"
read key
fdisk -l

#Edit <>
#you should change </dev/sda> to your disk name. you can look it up with 'fdisk -l' command. MAKE SURE you removed the '<' and '>'.
fdisk </dev/sda>
