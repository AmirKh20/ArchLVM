#!/bin/sh
#this is the part two of arch installation
#the first part is archLVM1.sh
#NOTE: EDIT THE <> PARTS!!!

echo "Make sure you already edited this scrtip"
echo "now that you completed the partition going to next one."
echo

lsblk
echo "is this right ?"
echo "press any key to continue"
echo "Make sure you edit this script as you like"
read key
echo
clear

#Edit this!!!!
#Setup LVM
pvcreate --dataalignment 1m </dev/sda2>
vgcreate volg0 </dev/sda2>
lvcreate -L <30GB> volg0 -n lv_root
lvcreate -L <size of home> volg0 -n lv_home
#NOTE: if you want the whole free space (not using snapshots) change L to l
#and <size of home> to 100%FREE

modprobe dm_mod
vgscan

echo "prees any key to coutinue. . ."
read key
clear

#activate logical volumes
vgchange -ay

#EDIT THIS!!!
#Formating
mkfs.fat -F32 </dev/sda1>
mkfs.ext4 /dev/volg0/lv_root
mkfs.ext4 /dev/volg0/lv_home

#Mounting lvm
mount /dev/volg0/lv_root /mnt
mkdir /mnt/home
mount /dev/volg0/lv_home /mnt/home

echo "press Enter to continue ..."
read key
clear

#fstab
mkdir /mnt/etc
genfstab -U -p /mnt >> /mnt/etc/fstab
clear

cat /mnt/etc/fstab
echo "press any key to continue ..."
read key
clear

#pacstrap
pacstrap -i /mnt base

#About part3
echo "after you pressed Enter, run the third script"
read key
echo

#chroot to /mnt
arch-chroot /mnt
