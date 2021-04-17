#!/bin/sh
#part 3 of my arch installation script
#please make sure you edited the <> parts
#run this after you got into / (after chrooted into /mnt) 

#installing Kernel headers
pacman -S linux-lts-headers linux-headers

#install some packages
pacman --needed -S vim base-devel networkmanager wpa_supplicant wireless_tools netctl dialog terminator lvm2 git reflector cups

#enable network manager & cups
systemctl enable NetworkManager
systemctl enable org.cups.cupsd
echo "press Enter"
read key
clear

#enable lvm support
echo "Edit this file by adding lvm2 betweem block and filesystems in line HOOKS"
echo "press Enter to Edit the file ..."
read key
vim /etc/mkinitcpio.conf
mkinitcpio -p linux
mkinitcpio -p linux-lts
clear

#Edit this <>
#Time Zone
ln -sf /usr/share/zoneinfo/<Region/City> /etc/localtime #if you dont know about your region and city just type 'ls /usr/share/zoneinfo/' and find it
hwclock --systohc

#gen locale
echo "Uncomment your locale by pressing Enter"
read key
vim /etc/locale.gen
locale-gen
clear

#Network configuration
echo "Enter your hostname"
read h

echo $h >> /etc/hostname
clear

echo "127.0.0.1         localhost" >> /etc/hosts
echo "::1               localhost" >> /etc/hosts
echo "127.0.1.1         $h.localdomain   $h" >> /etc/hosts
clear

#password and creating normal user
echo "you're about to enter a passowrd for your root account"
passwd
echo "Enter your username"
read u

useradd -m -g users -G wheel $u
echo "and the password for your user account"
passwd $u

#configure sudo
echo
echo "uncomment wheel ALL=(ALL) ALL"
echo "press Enter to Edit the file ..."
read key
visudo

#setup grub
pacman -S grub efibootmgr dosfstools os-prober mtools
clear
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
mkdir /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
echo 
echo "Press Enter and add \"lvm\" to the GRUB_PRELOAD_MODULES line ((if it's not already added))"
read key
vim /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "press Enter to continue"
read key
clear

#creat swap file
#EDIT THIS
fallocate -l <2G> /swapfile #size of the swap file
chmod 600 /swapfile
mkswap /swapfile
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
echo "press Enter to continue"
read key
clear

#EDIT THIS (based on your pc drivers, you can look it up in 'lspci' command)

#for intel and  nvidia
#pacman --needed -S intel-ucode xf86-video-intel libgl mesa xorg-server nvidia nvidia-lts nvidia-utils nvidia-libgl nvidia-settings

#for virtual box
#pacman -S virtualbox-guest-utils xf86-video-vmware mesa

echo "exit and type umount -a"
echo "and type shutdow now"
echo "GOOD LUCK!"
echo
