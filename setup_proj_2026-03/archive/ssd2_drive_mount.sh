# Script to Mount SSD2

#!/bin/bash

sudo umount /media/matt/ssd2_world/ &&
sudo cryptsetup close luks-3efbea31-d5bb-493b-ac77-b747808217b3 &&
sudo cryptsetup luksOpen /dev/disk/by-uuid/3efbea31-d5bb-493b-ac77-b747808217b3 ssd2_world --key-file=/home/matt/helper_scripts/ssd2_world_key &&
sudo mount /dev/mapper/ssd2_world /mnt/ssd2_data/ &&
echo "
Dashu - I ran the ssd2_world drive mount script. These are all the file systems on matt-9000:
" &&
df -h &&
echo "
"