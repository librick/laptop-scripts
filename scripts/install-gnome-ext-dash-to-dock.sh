#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install dash-to-dock@micxgx.gmail.com
DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y sassc
rm -rf $HOME/foss/dash-to-dock
rm -rf $XDG_DATA_HOME/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
git clone --depth 1 https://github.com/micheleg/dash-to-dock.git $HOME/foss/dash-to-dock
cd $HOME/foss/dash-to-dock
make install
