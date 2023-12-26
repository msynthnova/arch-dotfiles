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
-- sync time
date 1226172223
```
---
