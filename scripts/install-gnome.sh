#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)
plaintext_dir=$builddir/age-plaintext
uxdg_data_home=/home/$username/.local/share

# Install GNOME
apt-get install -y gnome gsettings
systemctl set-default graphical.target

# Copy wallpapers
cp $builddir/dotlocal/share/backgrounds/* $uxdg_data_home/backgrounds/
$desktop_background=$uxdg_data_home/backgrounds/pexels-philippe-donn-1169754.jpg

# Configure gsettings
sudo -u $username gsettings set org.gnome.calculator button-mode "advanced"
sudo -u $username gsettings set org.gnome.calculator refresh-interval 0
sudo -u $username gsettings set org.gnome.desktop.app-folders folder-children "[]"
sudo -u $username gsettings set org.gnome.desktop.background picture-uri $desktop_background
sudo -u $username gsettings set org.gnome.desktop.background picture-uri-dark $desktop_background
sudo -u $username gsettings set org.gnome.desktop.datetime automatic-timezone true
sudo -u $username gsettings set org.gnome.desktop.input-sources xkb-options "['caps:none']"
sudo -u $username gsettings set org.gnome.desktop.interface clock-format "24h"
sudo -u $username gsettings set org.gnome.desktop.interface clock-show-weekday true
sudo -u $username gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
sudo -u $username gsettings set org.gnome.desktop.interface enable-animations false
sudo -u $username gsettings set org.gnome.desktop.interface font-antialiasing "rgba"
sudo -u $username gsettings set org.gnome.desktop.interface font-name "NotoSans Nerd Font 11"
sudo -u $username gsettings set org.gnome.desktop.interface document-font-name "NotoSans Nerd Font 11"
sudo -u $username gsettings set org.gnome.desktop.interface monospace-font-name "Hack Nerd Font Mono Regular 11"
sudo -u $username gsettings set org.gnome.desktop.interface show-battery-percentage true
sudo -u $username gsettings set org.gnome.desktop.notifications show-in-lock-screen false
sudo -u $username gsettings set org.gnome.desktop.peripherals.touchpad click-method "areas"
sudo -u $username gsettings set org.gnome.desktop.wm.preferences button-layout ":close"
sudo -u $username gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
sudo -u $username gsettings set org.gnome.mutter dynamic-workspaces false
sudo -u $username gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"
sudo -u $username gsettings set org.gtk.Settings.FileChooser sort-directories-first true
sudo -u $username gsettings set org.gnome.nautilus.icon-view default-zoom-level "small"
sudo -u $username gsettings set org.gnome.nautilus.preferences default-folder-viewer "list-view"
sudo -u $username gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Set GNOME favorite apps
gnome_favs_file=$plaintext_dir/gnome-favorite-apps.txt
gnome_favs=[$(cat $gnome_favs_file | sed "s/^\|$/'/g"|paste -sd, -)]
sudo -u $username gsettings set org.gnome.shell favorite-apps $gnome_favs
