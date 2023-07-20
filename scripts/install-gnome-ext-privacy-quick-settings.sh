#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

rm -rf $HOME/foss/privacy-menu-extension
rm -rf $XDG_DATA_HOME/gnome-shell/extensions/PrivacyMenu@stuarthayhurst
git clone --depth 1 https://github.com/stuarthayhurst/privacy-menu-extension.git $HOME/foss/privacy-menu-extension
cd $HOME/foss/privacy-menu-extension
make install
