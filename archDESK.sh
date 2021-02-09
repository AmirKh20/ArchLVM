#!/bin/sh
# This is Desktop Environment installaion script on Arch Linux
# you should run this script with root

clear
echo "Welcome to DE installation script"
echo "Make sure you are in root and have ping and ip address."
echo "and NetworkManager is installed, eneabled and active"
echo
echo "just look at the output that is showing below"
systemctl status NetworkManager
echo
echo

echo "is it inactive and disabled?[y/n]"
read key

if [ $key == y ]
then
   systemctl start NetworkManager
   systemctl enable NetworkManager
else
   echo "Great!"
fi

echo "press Enter to continue..."
read key
clear

pacman -Syyy

echo "NOTE: Also make sure you installed xorg-server and you pc drivers packages from ArchLVM3 script!!"
echo "Press Enter to continue..."
read key
clear

echo "Now between these three Desktop Environments, Please choose one by entering the number:"
echo "1- KDE/Plasma"
echo "2- Gnome"
echo "3- XFCE"
echo
read DE

if [ $DE == 1 ]
then
    pacman -S sddm
    systemctl enable sddm
    pacman -S plasma konsole dolphin
elif [ $DE == 2 ]
then
    pacman -S gdm 
    systemctl enable gdm
    pacman --needed -S gnome gnome-terminal nautilus gnome-tweaks gnome-control-center gnome-backgrounds adwaita-icon-theme arc-gtk-theme

elif [ $DE == 3 ]
then
    pacman -S lxdm
    systemctl enable lxdm
    pacman -S xfce4 xfce4-goodies xfce4-terminal

else
   echo "ERROR: you hit the wrong number"
   read key
fi

clear
echo "now reboot the system by hitting Enter..."
echo "Note: if you don't want to reboot just press ctrl+c"
read key

reboot
