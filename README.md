# Usage
I expect you to be running these scripts as ROOT.  
Run commands `chmod +x decrypt_windows.sh remove_decrypted_files.sh && sudo apt install dislocker` to make the files executable and to install dislocker, an essential component of this repository.  
To decrypt Bitlocker encrypted Windows files, run command `./decrypt_windows.sh` Input Bitlocker recovery key (found here: [https://account.microsoft.com/devices/recoverykey](https://account.microsoft.com/devices/recoverykey)) and device file which has the Windows encrypted files.  
To remove the decrypted files (/mnt/decrypted and /mnt/tmp), run command `./remove_decrypted_files.sh`. Input `y` to accept.
