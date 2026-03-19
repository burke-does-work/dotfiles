# Script to Mount Network File System (NFS) on the RPi

#!/bin/bash

sudo mount 192.168.8.154:/mnt/drive_data /mnt/nfs/drive_data && 
sudo mount 192.168.8.154:/mnt/hdd_data /mnt/nfs/hdd_data &&
echo "
Dashu: I ran the pickle-pi NFS mount script. These are all the file systems on matt-9000:
" &&
df -h &&
echo "
"
