# After base system install
dd if=/dev/zero of=/swapfile bs=1G count=2
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "# swapfile" >> /etc/fstab
echo -e "/swapfile\tnone\tswap\tdefaults\t0 0" >> /etc/fstab

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "artix" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 artix.localdomain artix" >> /etc/hosts
echo root:pass | chpasswd # change!!

# Arch repos
pacman -S --noconfirm artix-archlinux-support wget
pacman-key --populate archlinux
wget "https://gist.github.com/ichigo-gyuunyuu/27005cf446896f99d990a0817489c013/raw/02d97883715d76ed0b946377487dd4a5f927fcf2/pacman.conf"
mv ./pacman.conf /etc
pacman -Syy --noconfirm reflector
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist-arch

pacman -S --noconfirm grub efibootmgr networkmanager networkmanager-openrc wpa_supplicant dialog \
  linux-headers bluez bluez-utils bluez-openrc tlp tlp-openrc openssh openssh-openrc
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

rc-update add NetworkManager default
rc-update add bluetoothd default
rc-update add tlp default
rc-update add sshd default

useradd -mG wheel ichigo
echo ichigo:pass | chpasswd # change!!
echo '%wheel ALL=(ALL) ALL' | EDITOR='tee -a' visudo

wget https://github.com/ichigo-gyuunyuu/dotfiles/raw/master/scripts/installer/artixsetup.sh
chmod +x ./artixsetup.sh
mv ./artixsetup.sh /home/ichigo

echo "Done! Exit, unmount, reboot and run setup"

