#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

builddir=$(pwd)
plaintext_dir=$builddir/age-plaintext
DEBIAN_FRONTEND=noninteractive

install_keyring () {
    keyring_url=$1
    keyring_filename=$2
    rm -f /usr/share/keyrings/$keyring_filename
    wget -O- $keyring_url | gpg --dearmor > $keyring_filename
    cat $keyring_filename | tee /usr/share/keyrings/$keyring_filename > /dev/null
    chmod 644 /usr/share/keyrings/$keyring_filename
    chown root:root /usr/share/keyrings/$keyring_filename
    rm -f $keyring_filename
}

install_keyring https://updates.signal.org/desktop/apt/keys.asc signal-desktop-keyring.gpg
install_keyring https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg vscodium-keyring.gpg
install_keyring https://syncthing.net/release-key.txt syncthing-keyring.gpg
install_keyring https://repo.jellyfin.org/jellyfin_team.gpg.key jellyfin-keyring.gpg

# Install non-default apt sources and preferences
apt_sources_dir=/etc/apt/sources.list.d/
apt_prefs_dir=/etc/apt/preferences.d/
cp $builddir/etc/apt/sources.list.d/*.list $apt_sources_dir/
cp $builddir/etc/apt/preferences.d/* $apt_prefs_dir/
chmod 644 $apt_sources_dir/*
chmod 644 $apt_prefs_dir/*
/bin/bash install-keyrings.sh
apt-get update

# Install unattended-upgrades
apt-get install -y unattended-upgrades
apt_conf_dir=/etc/apt/apt.conf.d/
cp $builddir/etc/apt/apt.conf.d/* $apt_conf_dir
systemctl restart unattended-upgrades.service
systemctl enable --now unattended-upgrades.service

# Install apt packages
apt_packages_file=$plaintext_dir/apt-packages.txt
xargs sudo apt-get install < $apt_packages_file
