# ArchLVM
This is my personal arch installation script(on LVM for **UEFI**). Also check the [archwiki page](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM)

### The steps you should take

1- After you booted the Arch Linux live USB iso, you should connect to the internet to download the scripts.

If you want to connect to WiFi, use _iwctl_

Check your ip with _ip a_, and if you didn't have one, enter _dhcpcd_

2-After you successfully connected to the internet, Enter these commands:

	pacman -Sy git

	git clone https://github.com/AmirKh20/ArchLVM.git

	cd ArchLVM

3- EDIT those lines that have <> in the Scripts, with your favourite editor.

   There shouldn't be **any <>** in the scripts when you want to run them, **MAKE SURE OF THAT!**

Note that the default editor in the scripts is vim, if you wanna change it feel free to change it to nano or something else.

If you want to make sure there is no <> left in the scripts run the following

    grep -E "<.+>" archLVM*

4- Run the first script in the ArchLVM directory with this command:

	./archLVM1.sh

This will also run the second script. So you don't need to run the second one yourself.

5-in the first script, you gonna go into fdisk. Just type m for help and read the arch wiki.

Also make sure you chose _Linux LVM_ for the type of the root partition, and _EFI_ for EFI partition.

**Don't create** swap partition because _swapfile_ is going to be created.

## Troubleshooting

If you don't see GRUB in your Boot menu

1-first make sure that the lvm module is preloaded
in /etc/default/grub

	GRUB_PRELOAD_MODULES="... lvm"

2-make a directory into efi directory

    mkdir /boot/efi/EFI/boot

copy grubx64.efi into /boot/efi/EFI/boot and name it bootx64.efi

```
cp /boot/efi/EFI/grub/grubx64.efi /boot/efi/EFI/boot/bootx64.efi
```
