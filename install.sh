#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)
uxdg_config_home=/home/$username/.config
uxdg_data_home=/home/$username/.local/share
DEBIAN_FRONTEND=noninteractive
ZDOTDIR=$uxdg_config_home/zsh

# Install prerequisites
apt-get install -y build-essential curl git wget ufw zsh fontconfig
# Add user to sudo group
usermod -aG sudo $username
# Configure ufw
sudo ufw logging high
sudo systemctl enable --now ufw

# Configure zsh
mkdir -p /etc/zsh; chmod 755 /etc/zsh
cp ./etc/zsh/zshenv /etc/zsh/zshenv
chmod 644 /etc/zsh/zshenv
sudo chsh -s /usr/bin/zsh $username

# Run scripts
/bin/bash ./install-apt-packages.sh
sudo -u $username /bin/bash ./install-fonts.sh
sudo -u $username  /bin/bash ./install-rust.sh
/bin/bash ./install-go.sh
/bin/bash ./install-wireshark.sh
/bin/bash ./install-gnome.sh
sudo -u $username ./install-gnome-ext-blur-my-shell.sh
sudo -u $username ./install-gnome-ext-dash-to-dock.sh
sudo -u $username ./install-gnome-ext-caffeine.sh
sudo -u $username ./install-gnome-ext-privacy-quick-settings.sh
/bin/bash ./install-flatpaks.sh
sudo -u $username /bin/bash ./install-bento4.sh
sudo -u $username /bin/bash ./install-apktool.sh
/bin/bash ./install-gradle.sh
sudo -u $username /bin/bash ./install-ghidra.sh

# Clone ohmyzsh repo
omz_repo=https://github.com/ohmyzsh/ohmyzsh.git
git clone -c core.autocrlf=input --depth=1 $omz_repo $uxdg_config_home/ohmyzsh
chmod -R go-w $uxdg_config_home/ohmyzsh

# Clone packer.nvim repo
packer_nvim_repo=https://github.com/wbthomason/packer.nvim
packer_nvim_dest=$uxdg_data_home/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 $packer_nvim_repo $packer_nvim_dest
