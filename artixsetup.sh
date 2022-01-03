# ensure network connection
sudo pacman -S --noconfirm nvidia nvidia-utils git xdg-utils xf86-video-intel
# sudo pacman -S --noconfirm xf86-video-qxl git xdg-utils
git clone https://aur.archlinux.org/yay.git
cd ~/yay/
makepkg -si --noconfirm PKGBUILD
cd ~

yay -S --noconfirm ttf-ms-fonts noto-fonts
sudo pacman -S --noconfirm xorg xorg-xinit bspwm sxhkd dmenu picom alacritty
yay -S --noconfirm ungoogled-chromium discord libnotify dunst lf mpv neofetch \
	youtube-dl neovim polybar transmission-cli ytfzf zathura zsh jq bc tree fzf \
	arc-icon-theme imagemagick materia-gtk-theme ntfs-3g pulseaudio pulseaudio-bluetooth \
	python-ueberzug-git rsync sox sxiv xclip xwallpaper zathura-pdf-mupdf \
	zsh-autosuggestions zsh-completions zsh-syntax-highlighting python-pip pulsemixer \
	gst-plugins-good chatterino2-7tv-git libid3tag twolame streamlink unzip \
	alacritty-ligatures zoxide texlive-most texlive-latexindent-meta

# backup files (check drive!)
mkdir ~/mnt
mkdir -p ~/.local/share/chatterino
sudo mount /dev/sdc1 ~/mnt
cd ~/mnt/os-reinstall
cp -r assets ~/.local/share
cp -r .ssh Pictures stuff ~
chmod 400 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
# cp -r chromium ~/.config
cp -r Settings ~/.local/share/chatterino
sudo cp -r NerdFonts /usr/share/fonts
sudo fc-cache -f
cd ~
sudo umount /dev/sdc1

# dotfiles
mkdir ~/repos
echo "dotfiles" >>.gitignore
git clone --bare git@github.com:ichigo-gyuunyuu/dotfiles.git $HOME/repos/dotfiles
/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

# picom
wget https://gist.github.com/ichigo-gyuunyuu/70e2fae6974b7f49dd88ece545c3479b/raw/eb13f57bb7fa7ef34eeed2e265fdc4af347f5081/picom.conf
sudo mv ./picom.conf /etc/xdg

# dmenu
git clone git@github.com:ichigo-gyuunyuu/dmenu-fork.git ~/repos/dmenu-fork
cd ~/repos/dmenu-fork
sudo make clean install
cd ~

# tapping for touchpad
sudo ln -s /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
sudo sed -i 's/^\s*MatchIsTouchpad "on"/&\n        Option "Tapping" "on"/' /etc/X11/xorg.conf.d/40-libinput.conf

# cleanup
sudo pacman -Rns --noconfirm $(pacman -Qdtq)
sudo pacman -Sc --noconfirm
yay -Sc --noconfirm
rm -rf ~/.cache/* ~/go ~/yay
rm ~/.bash*
rm ~/.wget*

chsh -s /usr/bin/zsh

echo "All done. Rebooting..."
sudo reboot
