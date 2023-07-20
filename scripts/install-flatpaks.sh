#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)
plaintext_dir=$builddir/age-plaintext
DEBIAN_FRONTEND=noninteractive

# Install flatpaks for system
apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
flatpak install -y gnome-nightly org.gnome.Builder.Devel
readarray -t fps_system < $plaintext_dir/flatpaks-system.txt
for fp in "${fps_system[@]}"; do
    flatpak install -y flathub $fp
done

# # Install flatpaks for user
# sudo -u $username flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# readarray -t fps_user < $plaintext_dir/flatpaks-user.txt
# for fp in "${fps_user[@]}"; do
#     sudo -u $username flatpak --user install flathub $fp
# done
