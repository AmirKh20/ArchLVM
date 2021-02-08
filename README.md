# ArchLVM
This is my personal arch installation script(on LVM), and it's based on a Video form a YouTube channel called LearnLinuxTV.
Note: This script uses LVM

****** The steps you should take **********

1-After you get into arch live boot, Enter these commands:
	
	pacman -Sy
	
	pacman -S git
	
	git clone https://github.com/AmirKh-prog/ArchLVM.git
	
	cd ArchLVM
	
	chmod a+rx archLVM1.sh archLVM2.sh archLVM3.sh


	
2- EDIT those lines that have <> in the Sctipts, with your favourite editor.
   there should'nt be any <> in the scripts when you want to run them, MAKE SURE OF THAT!
Note that the default edtior in the scripts is vim, if you wanna change it feel free to chnage it to nano or something else.



3- Run the first script in the ArchLVM directory with this command:
	
	./archLVM1.sh

4-after you got done with the first script, you gonna go into fdisk. just type m for help or see the arch wiki or simply google it.

5-Run the second script:
	
	./archLVM2.sh

6-after the second script got finished, you have chrooted to /mnt. and now run the last script:
	
	./archLVM3.sh

7-when the script is done, enter this commands:
	
	exit
	
	umount -a
	
	shutdown now
8-plug out your bootable USB. and turn on your pc.

if the installation finished without any error, you should boot into your pc very well.

this script is new. and has so many things that can be get better.
and sorry about my English :)
