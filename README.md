# ArchLVM
This is my personal arch installation script(on LVM), and it's based on archwiki + a Video from a YouTube channel called LearnLinuxTV.

Note: This script uses LVM and it's for UEFI systems

### The steps you should take

1- After you get into arch live boot, you should connect to internet to download the scripts. 

if you want to connect to a wifi, use 'iwctl'.

check your ip and connection with 'ip a', and if you didnt have one, enter 'dhcpcd'


2-After you successfully connected to internet, Enter these commands:
	
	pacman -Sy
	
	pacman -S git
	
	git clone https://github.com/AmirKh-prog/ArchLVM.git
	
	cd ArchLVM

	
3- EDIT those lines that have <> in the Sctipts, with your favourite editor.

   there should'nt be any <> in the scripts when you want to run them, MAKE SURE OF THAT!

Note that the default edtior in the scripts is vim, if you wanna change it feel free to chnage it to nano or something else.


4- Run the first script in the ArchLVM directory with this command:
	
	./archLVM1.sh

5-after you got done with the first script, you gonna go into fdisk. just type m for help or see the arch wiki or simply google it.

also make sure you chose Linux LVM for the type of the root partition, and EFI for EFI partition.

and don't create swap partition because swapfile is gonna be created in the third script!

6-Run the second script:
	
	./archLVM2.sh

7-after the second script got finished, you have chrooted to /mnt. you should clone the repository again, so enter the commands from step 2

Note: after you downloaded the scripts again, edit the archLVM3.sh for those <> lines and then run it with this:
	
	./archLVM3.sh

8-when the script is done, enter these commands:
	
	exit
	
	umount -a
	
	shutdown now
9-plug out your bootable USB. and turn on your pc.

if the installation finished without any error, you should boot into your arch very well. and you can type your user name and password to login.

10- for installing a Desktop environment, run the archDESK.sh script. that script only install KDE/plasma , gnome, or xfce.

# Troubleshooting

if your pc doesnt run grub and doesnt boot,
	
1-first make sure that the lvm module is preloaded
in /etc/default/grub
	
	GRUB_PRELOAD_MODULES="... lvm"

2-make a directory into efi direcotry
   
   	mkdir /boot/EFI/EFI/boot
copy grubx64.efi into /boot/EFI/EFI/boot and name it bootx64.efi
   
   	cp /boot/EFI/EFI/grub_uefi/grubx64.efi /boot/EFI/EFI/boot/bootx64.efi

