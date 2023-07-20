#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install caffeine@patapon.info
rm -rf $HOME/foss/caffeine
rm -rf $XDG_DATA_HOME/gnome-shell/extensions/caffeine@patapon.info
git clone --depth 1  https://github.com/eonpatapon/gnome-shell-extension-caffeine.git $HOME/foss/caffeine
cd $HOME/foss/caffeine
make build
make install
