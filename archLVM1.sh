#!/bin/bash

# ArchLVM
# Autor : Amir Kh
# First Part of Script for my arch installation with LVM

GREEN='\033[0;32m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

enter_to_continue()
{
    echo -e "${MAGENTA}Press Enter to continue${RESET}"
    read && clear
}

echo -e "${GREEN}Welcome to my arch installation script!\n${RESET}"
echo -e "${GREEN}This is written by ${RESET}${RED}AmirKh20\n${RESET}"
echo -e "${GREEN}My github: ${RESET}${RED}https://github.com/AmirKh20\n${RESET}"
echo -e "${RED}WARNING: MAKE SURE YOU'VE EDITED THE SCRIPT\n${RESET}"
enter_to_continue

#UEFI Check
echo -e "${GREEN}Check if we booted with UEFI\n${RESET}"
if ls /sys/firmware/efi/efivars &>>/dev/null; then
  echo -e "${GREEN}YES${RESET}"
else
  echo -e "${RED}Stoping the script because there is no efivars${RESET}" && exit 1
fi
enter_to_continue

#ping test
echo -e "${GREEN}Pinging...${RESET}"
if ping -c 5 archlinux.org &>>/dev/null; then
  echo -e "${GREEN} You have a working internet${RESET}"
else
  echo -e "${RED}You dont have a working internet, stoping the script...${RESET}" && exit 1
fi
enter_to_continue

#refreshing mirrorlist
echo -e "\n${GREEN} running reflector... if it didnt finish just stop it with ctrl-c\n${RESET}"
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy
enter_to_continue

#update the system clock
timedatectl set-ntp true
echo -e "${GREEN}Checking the time status${RESET}\n"
timedatectl status
enter_to_continue

#fdisk
echo -e "\n${GREEN}Partition the disk, dont create swap partition, it will be created as a swap file. create a esp partition as 'EFI System' type with At least 260 MiB. choose other partition type as Linux LVM${RESET}"
fdisk -l
enter_to_continue

#Edit <>
#you should change the next line to your disk name. you can look it up with 'fdisk -l' command. add other disks if desired
fdisk </dev/sda>

echo -e "${GREEN}Runing lsblk...${RESET}\n"
lsblk
echo -e "is this correct ?"
enter_to_continue

#Edit <> !!!!
#Setup LVM
echo -e "${GREEN}Creating pvs,vgs,lvs...${RESET}\n"
pvcreate --dataalignment 1m </dev/sda2> #this is your LVM partition that has been created by yourself
vgcreate volg0 </dev/sda2> #this too
lvcreate -L <30GB> volg0 -n lv_root #this is the size of the root volume. you can change the name of the volume group too(volg0) and name of the root volume(lv_root)
lvcreate -L <size of home> volg0 -n lv_home #change size of the home volume. also if you changed volume group in the last line,do it in here too
#NOTE: if you want the whole free space for home volume (not using snapshots) change L to l
#and <size of home> to 100%FREE
modprobe dm_mod
vgscan
vgchange -ay
enter_to_continue

#EDIT THIS!!!
#Formating
echo -e "${GREEN}Formating The EFI Partition and lvs...${RESET}\n"
mkfs.fat -F32 </dev/sda1> #EFI partition name
mkfs.ext4 /dev/volg0/lv_root #if you changed volg0 and lv_root, change them in here too
mkfs.ext4 /dev/volg0/lv_home #and in here
enter_to_continue

#EDIT THIS <>
#Mounting
echo -e "${GREEN}Mounting...${RESET}\n"
mount /dev/volg0/lv_root /mnt #here too
mkdir /mnt/home
mount /dev/volg0/lv_home /mnt/home #also here
mkdir -p /mnt/boot/efi
mount </dev/sda1> /mnt/boot/efi #name of the EFI partition
enter_to_continue

#pacstrap
echo -e "${GREEN}pacstraping...${RESET}\n"
pacstrap -i /mnt base linux linux-lts linux-firmware
enter_to_continue

#fstab
echo -e "${GREEN}Generating fstab...${RESET}\n"
mkdir /mnt/etc
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo -e "\n${GREEN}moving the second script into /mnt so you can run it in the chrooted environment${RESET}"
mv -v $(dirname $0)/archLVM2.sh /mnt

#chroot to /mnt
echo -e "${GREEN}Chrooting...\n${RESET}"
arch-chroot /mnt
