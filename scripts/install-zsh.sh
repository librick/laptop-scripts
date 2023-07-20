#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

builddir=$(pwd)
username=$(id -u -n 1000)
DEBIAN_FRONTEND=noninteractive
apt-get install -y zsh
mkdir -p /etc/zsh; chmod 755 /etc/zsh
cp $builddir/etc/zsh/zshenv /etc/zsh/zshenv
chmod 644 /etc/zsh/zshenv
chsh -s /usr/bin/zsh $username
