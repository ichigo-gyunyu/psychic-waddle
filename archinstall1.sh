#!/usr/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "notartix" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 notartix.localdomain notartix" >> /etc/hosts
echo root:pass | chpasswd # change!!

git clone https://github.com/ichigo-gyuunyuu/psychic-waddle.git
cp ./psychic-waddle/pacman.conf /etc

pacman -Syy --noconfirm reflector rsync
reflector --country Singapore,India --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
pacman -S --noconfirm grub efibootmgr networkmanager base-devel \
	linux-headers bluez bluez-utils tlp openssh
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable tlp
systemctl enable sshd
sed -i 's/GRUB_TIMEOUT=./GRUB_TIMEOUT=0/' /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

useradd -mG wheel ichigo
echo ichigo:pass | chpasswd # change!!
echo '%wheel ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo
