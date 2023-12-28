#!/bin/bash

hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

echo "archiso" > /etc/hostname
echo "127.0.0.1    localhost" > /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    felixhost" >> /etc/hosts

passwd
useradd -m -G wheel felix
passwd felix

echo "root ALL=(ALL:ALL) ALL" > /etc/sudoers
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "@includedir /etc/sudoers.d" >> /etc/sudoers

mkdir /boot/efi
mount /dev/nvme0n1p1 /boot/efi

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable iwd
