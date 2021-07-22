# ArchLVM
This is my personal arch installation script(on LVM). also check the [archwiki page](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM)

Note: This script uses LVM and it's for UEFI systems

### The steps you should take

1- After you get into arch live boot, you should connect to internet to download the scripts.

if you want to connect to a wifi, use 'iwctl'.

check your ip and connection with 'ip a', and if you didnt have one, enter 'dhcpcd'


2-After you successfully connected to internet, Enter these commands:

	pacman -Sy git

	git clone https://github.com/AmirKh20/ArchLVM.git

	cd ArchLVM


3- EDIT those lines that have <> in the Scripts, with your favourite editor.

   there shouldn't be any <> in the scripts when you want to run them, MAKE SURE OF THAT!

Note that the default editor in the scripts is vim, if you wanna change it feel free to change it to nano or something else.


4- Run the first script in the ArchLVM directory with this command:

	./archLVM1.sh

5-after you got done with the first script, you gonna go into fdisk. just type m for help and read the arch wiki.

also make sure you chose Linux LVM for the type of the root partition, and EFI for EFI partition.

and don't create swap partition because swapfile is gonna be created in the third script!

6-after the first script got finished, you have chrooted into /mnt. make sure you've edited the second script and run it with

	./archLVM2.sh

8-when the script is done, enter these commands:

	exit

	umount -R /mnt

	shutdown now
9-plug out your live USB. and turn on your pc.

if the installation finished without any error, you should boot into your arch very well. and you can type your user name and password to login.

## Troubleshooting

if your pc doesn't run grub and doesn't boot,

1-first make sure that the lvm module is preloaded
in /etc/default/grub

	GRUB_PRELOAD_MODULES="... lvm"

2-make a directory into efi directory
`
   mkdir /boot/efi/EFI/boot

`
copy grubx64.efi into /boot/efi/EFI/boot and name it bootx64.efi
`

   	cp /boot/efi/EFI/grub/grubx64.efi /boot/efi/EFI/boot/bootx64.efi

`
