#!/bin/bash
echo "This will remove the /mnt/decrypted and the /mnt/tmp files."
read -rp "Do you want to remove the files? (Answer with y or n) " answer
if [ $answer != "y" ]; then
echo "Bye bye!"
exit
fi
if [ -e /mnt/decrypted ]; then
:
else
if [ -e /mnt/tmp ]; then
:
else
echo "Both files do not exist. Exiting!"
exit 1
fi
fi
umount /mnt/decrypted&>/dev/null
umount /mnt/tmp&>/dev/null #order is important!!
rm -rf /mnt/decrypted
rm -rf /mnt/tmp
echo "The files were successfully unmounted and removed."
