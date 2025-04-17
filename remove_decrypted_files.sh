#!/bin/bash

COLOR_NC='\e[0m'
COLOR_BLUE='\e[0;34m'
COLOR_RED='\e[0;31m'
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root."
	exit 1
fi
if [ ! "$1" = "y" ]; then
	echo -e "${COLOR_RED}This will remove the /mnt/decrypted and the /mnt/tmp files.${COLOR_NC}"
	read -rp "Do you want to remove the files? (Answer with y or n) " answer
	if [ "$answer" != "y" ]; then
		echo "Bye bye!"
		exit
	fi
fi
if [ ! -e /mnt/decrypted ] && [ ! -e /mnt/tmp ]; then
	echo -e "${COLOR_RED}Both files do not exist. Exiting!${COLOR_NC}"
	exit 1
fi
umount /mnt/decrypted&>/dev/null
umount /mnt/tmp&>/dev/null #order is important!!
rm -rf /mnt/decrypted
rm -rf /mnt/tmp
if [ "$?" -ne 0 ]; then
	echo -e "${COLOR_BLUE}In case you receive this error:${COLOR_NC}"
	echo "	rm: cannot remove '/mnt/tmp/dislocker-file': Function not implemented"
	echo -e "${COLOR_BLUE}Do not panic and rerun this file with `./remove_decrypted_files.sh`. (The file was somehow mounted multiple times)${COLOR_NC}"
	exit 1
fi
echo -e "${COLOR_BLUE}The files were successfully unmounted and removed.${COLOR_NC}"
