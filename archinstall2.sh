# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si --noconfirm PKGBUILD
# cd ..
# rm -rf yay

yay -S --noconfirm nvidia nvidia-utils xdg-utils xf86-video-intel \
	all-repository-fonts xorg bspwm sxhkd picom alacritty sx \
	librewolf-bin discord libnotify dunst mpv neofetch \
	yt-dlp neovim polybar transmission-cli zathura zsh jq bc \
	tree fzf imagemagick ntfs-3g pulseaudio pulseaudio-bluetooth \
	sxiv xclip xwallpaper zathura-pdf-mupdf \
	zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
	python-pip unzip zoxide texlive-most texlive-latexindent-meta
