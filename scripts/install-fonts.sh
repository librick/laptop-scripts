#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install nerd-fonts
builddir=$(pwd)
fonts_dir=$XDG_DATA_HOME/fonts
nerdfont_tag=$(python3 $builddir/scripts/github-tag.py ryanoasis/nerd-fonts)
nerdfont_url=https://github.com/ryanoasis/nerd-fonts/releases/download/$nerdfont_tag
mkdir -p $fonts_dir && chmod 700 $fonts_dir
rm -rf $fonts_dir/nerd-fonts*
wget $nerdfont_url/FiraCode.zip && unzip FiraCode.zip -d $fonts_dir/nerd-fonts-firacode
wget $nerdfont_url/Hack.zip && unzip Hack.zip -d $fonts_dir/nerd-fonts-hack
wget $nerdfont_url/Noto.zip && unzip Noto.zip -d $fonts_dir/nerd-fonts-noto
chown -R $USER:$USER $fonts_dir
rm ./FiraCode.zip ./Hack.zip ./Noto.zip

# Configure fontconfig
fontconfig_dir=$XDG_CONFIG_HOME/fontconfig/conf.d
cp ../dotconfig/fontconfig/conf.d/01-emoji.conf $fontconfig_dir/01-emoji.conf
cp ../dotconfig/fontconfig/conf.d/02-aliases.conf $fontconfig_dir/02-aliases.conf
chown -R $USER:$USER $fontconfig_dir
fc-cache -vf
