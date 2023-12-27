### partition disk
```
wipefs -a /dev/nvme0n1
parted --script /dev/nvme0n1 mklabel gpt
parted --script /dev/nvme0n1 mkpart ESP fat32 1MiB 51MiB
parted --script /dev/nvme0n1 name 1 "EFI_System_Partition"
parted --script /dev/nvme0n1 set 1 boot on

parted --script /dev/nvme0n1 mkpart primary linux-swap 51MiB 10101MiB
parted --script /dev/nvme0n1 name 2 "Linux_Swap_Partition"

parted --script /dev/nvme0n1 mkpart primary ext4 10101MiB 100%
parted --script /dev/nvme0n1 name 3 "Linux_FileSystem_Partition"

ls -l /dev/disk/by-partlabel
ls -l /dev/disk/by-uuid
ls -l /dev/disk/by-path
```
---

### filesystem types
```
mkfs.fat -F 32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

lsblk -o PATH,FSTYPE /dev/nvme0n1
```
---

### mount partition
```
mkdir -p /mnt/gentoo
mount /dev/nvme0n1p3 /mnt/gentoo
swapon /dev/nvme0n1p2

lsblk -o PATH,MOUNTPOINT /dev/nvme0n1
```
---

### stage3
```
timedatectl

curl https://distfiles.gentoo.org/releases/amd64/autobuilds/20231224T164659Z/stage3-amd64-nomultilib-openrc-20231224T164659Z.tar.xz -o stage3.tar.xz
tar xpvf stage3.tar.xz --xattrs-include='*.*' --numeric-owner
rm -rf stage3.tar.xz

```
---

### install base
```
curl https://raw.githubusercontent.com/msynthnova/gentoo-dotfiles/main/make.conf -o /mnt/gentoo/etc/portage/make.conf

mkdir --parents /mnt/gentoo/etc/portage/repos.conf
curl https://raw.githubusercontent.com/msynthnova/gentoo-dotfiles/main/gentoo.conf -o /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

mount -l

chroot /mnt/gentoo bin/bash
source /etc/profile

mkdir /efi
mount /dev/nvme0n1p1 /efi

emerge-webrsync
emerge --sync
eselect news list
eselect profile list
eselect profile set 15

emerge --ask --verbose --update --deep --newuse @world
```
---
