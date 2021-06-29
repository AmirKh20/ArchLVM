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
echo -e "${RED}NOTE: this is with LVM${RESET}"
echo -e "${RED}NOTE: MAKE SURE YOU'VE EDITED LAST LINE OF THIS SCRIPT!!!\n${RESET}"
enter_to_continue

#UEFI Check
echo -e "${GREEN}Check if we are in UEFI\n${RESET}"
ls /sys/firmware/efi/efivars
echo -e "${GREEN}\nif there is no Error in the output, then we're in UEFI.${RESET}"
echo -e "${RED}Otherwise please stop the script. and change some of it, or don't use it${RESET}"
enter_to_continue

#ping test
echo -e "${GREEN}Pinging...\n\n${RESET}"
ping -c 5 archlinux.org
echo -e "${RED}\n\nif you didnt get any ping, stop this script with ctrl-c and read the arch wiki${RESET}"
enter_to_continue

#refresh mirrorlist
pacman -Sy
pacman --needed -S reflector

#edit mirrorlist
echo -e "\n${GREEN} running reflector... if it didnt finish just stop it with ctrl-c\n${RESET}"
reflector -c <your country> -a 6 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy
enter_to_continue

#update the system clock
timedatectl set-ntp true
echo -e "${GREEN}Checking the time status${RESET}\n"
timedatectl status
enter_to_continue

#fdisk
fdisk -l
echo -e "\n${GREEN}after you've partition your disk, ${RESET}${RED}edit the second script${RESET}${GREEN} and then run the archLVM2.sh${RESET}"
enter_to_continue
read

#Edit <>
#you should change </dev/sda> to your disk name. you can look it up with 'fdisk -l' command. MAKE SURE you removed the '<' and '>'.
fdisk </dev/sda>
