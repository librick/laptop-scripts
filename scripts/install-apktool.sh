#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

builddir=$(pwd)
apktool_release=$(python3 $builddir/scripts/github-tag.py iBotPeaches/Apktool)
echo found release tag: $apktool_release
apktool_url_base=https://github.com/iBotPeaches/Apktool/releases/download/$apktool_release
apktool_release_no_v=$(echo -n $apktool_release | sed -e 's/v//g')
apktool_filename=apktool_$apktool_release_no_v.jar

apktool_install_dir=$HOME/foss/apktool
rm -rf $apktool_install_dir && mkdir -p $apktool_install_dir
wget $apktool_url_base/$apktool_filename -O $apktool_install_dir/apktool.jar
script_url=https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
wget $script_url -O $apktool_install_dir/apktool
chmod +x $apktool_install_dir/apktool
ln -s -f $apktool_install_dir/apktool $HOME/.local/bin

chown -R $USER:$USER $apktool_install_dir
chown -R $USER:$USER $HOME/.local/bin/apktool
