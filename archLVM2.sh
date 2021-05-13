#!/bin/bash
#this is the part two of arch installation
#the first part is archLVM1.sh
#NOTE: EDIT THE <> PARTS!!! there should not be any < and > in the script whene you run it!

GREEN='\033[0;32m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

enter_to_continue()
{
    echo -e "${MAGENTA}Press Enter to continue${RESET}"
    read && clear
}

clear
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
mkdir /mnt/boot
mount </dev/sda1> /mnt/boot #name of the EFI partition
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
echo -e "\n${GREEN}clone the repository again, edit and run the third script${RESET}"
enter_to_continue

#chroot to /mnt
echo -e "${GREEN}Chrooting...\n${RESET}"
arch-chroot /mnt
