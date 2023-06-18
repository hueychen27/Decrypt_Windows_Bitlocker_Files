#!/bin/bash
COLOR_NC='\e[0m'
COLOR_BLUE='\e[0;34m'
COLOR_RED='\e[0;31m'
if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi
mkdir /mnt/tmp&>/dev/null #surpress error messages
read -rp "Input bitlocker recovery key: " key
echo "Choose a bitlocker encrypted device: "
fdisk -l
read -rp "Input encrypted (Windows) device: /dev/" device
if [ -e /dev/$device ] ;then
echo "Device exists..."
else
echo -e "${COLOR_RED}Error: device does not exist.${COLOR_NC}" && exit 1
fi
echo -ne $COLOR_RED
dislocker -v -V /dev/$device -p$key -- /mnt/tmp
if [ $? -ne 0 ]; then
echo -e "An error occured while decrypting the device."
echo -ne "${COLOR_BLUE}Do you want to remove the created file, /mnt/tmp? (Answer y/n) ${COLOR_NC}"
read -rp "" answer
if [ $answer = "y" ]; then
./remove_decrypted_files.sh $answer
fi
exit 1
fi
echo -ne $COLOR_NC
mkdir /mnt/decrypted&>/dev/null #surpress error messages
mount -o loop,ro /mnt/tmp/dislocker-file /mnt/decrypted
echo "Done! Go to /mnt/decrypted to see your decrypted files."
echo -e "To remove the decrypted files, run the command ${COLOR_BLUE}umount /mnt/decrypted${COLOR_NC} and ${COLOR_BLUE}umount /mnt/tmp${COLOR_NC}. Then run ${COLOR_BLUE}rm -rf /mnt/decrypted${COLOR_NC} and ${COLOR_BLUE}rm -rf /mnt/tmp${COLOR_NC}."
echo -e "Alternatively, run command ${COLOR_BLUE}./remove_decrypted_files.sh${COLOR_NC}"
