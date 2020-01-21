#!/bin/bash

# Not ready for use yet -- initial commit.

cat << EOF
Root On ZFS Install
- Basic Layout is [efi, swap-nix, swap-bsd, zfs] on a single SSD
- Multi OSes on one ZFS volume using legacy mountpoints
EOF

read -p "Enter installation disk. [nvd0]:" DISKTARGET
DISKTARGET=${DISKTARGET:-nvd0}
DISKTARGET="/dev/$DISKTARGET"

select YN in "Yes" "No"; do
    case $YN in
        Yes ) parted --script $DISKTARGET mklabel gpt
        No ) echo "Understood. Exiting."; exit;;
    esac
done

echo "Selected disk available space for partitioning"
lsblk /dev/$DISKTARGET

read -p "Enter desired /boot/efi size in MiB. [512]:" EFISIZE
EFISIZE=${EFISIZE"M":-512}

read -p "Enter desired linux swap size in GiB. [20]:" NIXSWAPSIZE
NIXSWAPSIZE=${NIXSWAPSIZE:-20}

read -p "Enter desired freebsd swap size in GiB. [20]:" BSDSWAPSIZE
BSDSWAPSIZE=${BSDSWAPSIZE:-20}

read -p "Enter desired ZFS root size in GiB. [640]:" ZFSROOTSIZE
ZFSROOTSIZE=${ZFSROOTSIZE:640}

