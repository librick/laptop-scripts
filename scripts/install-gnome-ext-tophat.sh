#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install tophat@fflewddur.github.io
DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y gir1.2-gtop-2.0
builddir=$(pwd)
tophat_tag=$(python3 $builddir/scripts/github-tag.py fflewddur/tophat)
tophat_url_base=https://github.com/fflewddur/tophat/releases/download/
tophat_zip_name=tophat@fflewddur.github.io.$tophat_tag.shell-extension.zip
tophat_url=$tophat_url_base/$tophat_tag/$tophat_zip_name
rm -rf $HOME/foss/tophat
mkdir -p $HOME/foss/tophat
wget $tophat_url -O $HOME/foss/tophat/$tophat_zip_name
rm -rf $XDG_DATA_HOME/gnome-shell/extensions/tophat@fflewddur.github.io
gnome-extensions install $HOME/foss/tophat/$tophat_zip_name --force

# todo:
# gsettings set org.gnome.shell.extensions.tophat meter-fg-color 'rgb(53,132,228)'
# dconf write /org/gnome/shell/extensions/tophat/meter-fg-colorvim in
