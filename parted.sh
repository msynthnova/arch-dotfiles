#!/bin/bash

# partition
wipefs -a /dev/nvme0n1
parted --script /dev/nvme0n1 mklabel gpt
parted --script /dev/nvme0n1 mkpart ESP fat32 1MiB 51MiB
parted --script /dev/nvme0n1 name 1 "EFI_System_Partition"
parted --script /dev/nvme0n1 set 1 boot on
parted --script /dev/nvme0n1 mkpart primary linux-swap 51MiB 10101MiB
parted --script /dev/nvme0n1 name 2 "Linux_Swap_Partition"
parted --script /dev/nvme0n1 mkpart primary ext4 10101MiB 100%
parted --script /dev/nvme0n1 name 3 "Linux_FileSystem_Partition"

# fs type
mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

# mount
swapon /dev/nvme0n1p2
mount /dev/nvme0n1p3 /mnt

# init
pacstrap -K /mnt base linux linux-firmware sudo networkmanager git neovim intel-ucode grub efibootmgr iwd bluez bluez-utils
genfstab -U /mnt >> /mnt/etc/fstab
