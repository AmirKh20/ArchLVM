#!/bin/sh
#part 3 of my arch installation script
#please make sure you edited the <> parts
#run this after you got into / (after chrooted into /mnt) 

#installing Kernel
pacman -S linux-lts linux-lts-headers linux linux-headers

#install some packages
pacman --needed -S vim base-devel networkmanager wpa_supplicant wireless_tools netctl dialog terminator lvm2

#enable network manager
systemctl enable NetworkManager
clear

#enable lvm support
echo "Edit this file by adding lvm2 betweem block and filesystems in line HOOKS"
echo "press Enter to Edit the file ..."
read key
vim /etc/mkinitcpio.conf
mkinitcpio -p linux
mkinitcpio -p linux-lts
clear

#gen locale
echo "Uncomment your locale by pressing Enter"
read key
vim /etc/locale.gen
locale-gen
clear

#EDIT THIS <>
#password and creating normal user
passwd
useradd -m -g users -G wheel <amir> #user name
passwd <amir> #user name

#configure sudo
echo "uncomment wheel ALL=(ALL) ALL"
echo "press Enter to Edit the file ..."
read key
visudo

#setup grub
pacman -S grub efibootmgr dosfstools os-prober mtools
clear
mkdir /boot/EFI
#EDIT THIS
mount </dev/sda1> /boot/EFI #name of the EFI partition
#EDIT THAT LINE!
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
mkdir /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
clear

#creat swap file
#EDIT THIS
fallocate -l <2G> /swapfile #size of the swap file
chmod 600 /swapfile
mkswap /swapfile
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
clear

#EDIT THIS (based on your pc drivers)
#for intel and  nvidia
#pacman -S intel-ucode xorg-server nvidia nvidia-lts nvidia-utils
#for virtual box
#pacman -S virtualbox-guest-utils xf86-video-vmware

echo "exit and type umount -a"
echo "and type shutdow now"
echo "GOOD LUCK!"
echo
