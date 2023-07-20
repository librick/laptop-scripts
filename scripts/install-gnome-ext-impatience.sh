#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install impatience@gfxmonk.net
rm -rf $HOME/foss/impatience
rm -rf $XDG_DATA_HOME/gnome-shell/extensions/impatience@gfxmonk.net
git clone --depth 1 https://github.com/timbertson/gnome-shell-impatience.git $HOME/foss/impatience
cd $HOME/foss/impatience
make all
gnome-extensions install "impatience@gfxmonk.net.zip" --force
