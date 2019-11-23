#!/bin/bash

echo -----------------------------------------------------
echo Creating of a backup copy of the main directory
echo -----------------------------------------------------

current_date=`date +"%y%m%d"`
directory="bu"$current_date"c"
volume_name="DS-2"
dev_name="sdc1"
pendrive_path="/media/piotr"
intermediate_directory="."

ls -l /dev/disk/by-label/

if [ -b /dev/$dev_name ];
then

	sudo umount /dev/$dev_name
	echo USB drive unmounted.

	sudo mkfs.vfat -n $volume_name /dev/$dev_name
	echo USB drive formatted.

	sudo mkdir $pendrive_path/$volume_name

	sudo mount -o iocharset=utf8 /dev/$dev_name $pendrive_path/$volume_name
	echo USB drive mounted.

	sudo mkdir $pendrive_path/$volume_name/$directory

	sudo cp -r ~/$intermediate_directory/main/* $pendrive_path/$volume_name/$directory

	sudo umount /dev/$dev_name
	echo USB drive unmounted.

	sudo rmdir $pendrive_path/$volume_name

	echo Backup copy creation finished. 
	echo -----------------------------------------------------

	pcmanfm-qt

else

	echo Backup unsuccessful.

fi
