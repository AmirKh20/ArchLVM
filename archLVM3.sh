#!/bin/sh
#part 3 of my arch installation script
#please make sure you edited the <> parts
#run this after got chroot to /mnt

#installing Kernel
pacman -S linux-lts linux-lts-headers linux linux-headers

#install some packages
pacman --needed -S vim base-devel networkmanager wpa_supplicant wireless_tools netctl dialog terminator lvm2

#enable network manager
systemctl enable NetworkManager

#enable lvm support
echo "change this file by adding lvm2 betweem block and filesystems in line HOOKS"
echo "press any key to continue ..."
read key

vim /etc/mkinitcpio.conf
mkinitcpio -p linux
mkinitcpio -p linux-lts

#gen locale
vim /etc/locale.gen
locale-gen
clear

#EDIT THIS <>
#password and creating normal user
passwd
useradd -m -g users -G wheel <amir>
passwd <amir>

#configure sudo
echo "uncomment wheel ALL=(ALL) ALL"
echo "press any key to continue ..."
read key

visudo

#setup grub
pacman -S grub efibootmgr dosfstools os-prober mtools
clear
mkdir /boot/EFI
#EDIT THIS
mount </dev/sda1> /boot/EFI
#EDIT THE LAST LINE
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
mkdir /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
clear

#creat swap file
#EDIT THIS
fallocate -l <2G> /swapfile
chmod 600 /swapfile
mkswap /swapfile
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
clear

#EDIT THIS
#install intel-ucode xorg nvidia
#pacman -S intel-ucode xorg-server nvidia nvidia-lts nvidia-utils
#for virtual box
#pacman -S virtualbox-guest-utils xf86-video-vmware

echo "exit and type umount -a"
echo "and shutdow"
echo "GOOD LUCK!"
echo

