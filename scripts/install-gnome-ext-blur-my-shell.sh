#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install blur-my-shell@aunetx
DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y gettext
rm -rf $HOME/foss/blur-my-shell
rm -rf $XDG_DATA_HOME/gnome-shell/extensions/blur-my-shell@aunetx
git clone --depth 1 https://github.com/aunetx/blur-my-shell.git $HOME/foss/blur-my-shell
cd $HOME/foss/blur-my-shell
make install
