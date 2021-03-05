#!/bin/sh
#this is the part two of arch installation
#the first part is archLVM1.sh
#NOTE: EDIT THE <> PARTS!!! there should not be any < and > in the script whene you run it!

echo "Make sure you already edited this script"
echo "now that you completed the partition going to next one."
echo

lsblk
echo "is this correct ?"
echo "press Enter to continue"
echo "Make sure you edited this script as you like"
read key
echo
clear

#Edit <> !!!!
#Setup LVM
pvcreate --dataalignment 1m </dev/sda2> #this is your LVM partition that has been created by yourself
vgcreate volg0 </dev/sda2> #this too
lvcreate -L <30GB> volg0 -n lv_root #this is the size of the root volume. you can change the name of the volume group too(volg0) and name of the root volume(lv_root)
lvcreate -L <size of home> volg0 -n lv_home #change size of the home volume. also if you changed volume group in the last line,do it in here too
#NOTE: if you want the whole free space for home volume (not using snapshots) change L to l
#and <size of home> to 100%FREE

modprobe dm_mod
vgscan

echo "prees Enter to coutinue. . ."
read key
clear

#activate logical volumes
vgchange -ay

#EDIT THIS!!!
#Formating
mkfs.fat -F32 </dev/sda1> #EFI partition name
mkfs.ext4 /dev/volg0/lv_root #if you changed volg0 and lv_root, change them in here too
mkfs.ext4 /dev/volg0/lv_home #and in here

#EDIT THIS <>
#Mounting 
mount /dev/volg0/lv_root /mnt #here too
mkdir /mnt/home
mount /dev/volg0/lv_home /mnt/home #also here
mkdir /boot/EFI
mount </dev/sda1> /boot/EFI #name of the EFI partition

echo "press Enter to continue ..."
read key
clear

#fstab
mkdir /mnt/etc
genfstab -U -p /mnt >> /mnt/etc/fstab
clear

cat /mnt/etc/fstab
echo "press Enter to continue ..."
read key
clear

#pacstrap
pacstrap -i /mnt base linux linux-lts linux-firmware

#About part3
echo
echo
echo "after you pressed Enter, run the third script"
read key

#chroot to /mnt
arch-chroot /mnt
