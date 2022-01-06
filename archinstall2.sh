#!/bin/bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm PKGBUILD
cd ..
rm -rf yay

yay -S --noconfirm nvidia nvidia-utils xdg-utils xf86-video-intel \
	all-repository-fonts xorg bspwm sxhkd picom alacritty sx \
	librewolf-bin discord libnotify dunst mpv neofetch \
	yt-dlp neovim polybar transmission-cli zathura zsh jq bc \
	tree fzf imagemagick ntfs-3g pulseaudio pulseaudio-bluetooth \
	sxiv xclip xwallpaper zathura-pdf-mupdf \
	zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
	python-pip unzip zoxide ttf-ms-win10-auto wget \
	nerd-fonts-fantasque-sans-mono alsa-utils xbindkeys puslemixer \
    ripgrep acpid

mkdir ~/repos
sudo fc-cache -f
sudo mv ./picom.conf /etc/xdg

# dotfiles
echo "dotfiles" >>.gitignore
git clone --bare git@github.com:ichigo-gyuunyuu/dotfiles.git $HOME/repos/dotfiles
/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

# dmenu
git clone https://github.com/ichigo-gyuunyuu/dmenu-fork.git ~/repos/dmenu-fork
cd ~/repos/dmenu-fork
sudo make clean install
cd ~/psychic-waddle

# tapping for touchpad
sudo ln -s /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
sudo sed -i 's/^\s*MatchIsTouchpad "on"/&\n        Option "Tapping" "on"/' /etc/X11/xorg.conf.d/40-libinput.conf

# zsh
chsh -l /bin/zsh

pip install pynviim
