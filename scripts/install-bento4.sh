#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

bento4_install_path=$HOME/foss/Bento4
rm -rf $bento4_install_path
git clone --depth 1 https://github.com/axiomatic-systems/Bento4.git $bento4_install_path
cd $bento4_install_path
mkdir cmakebuild
cd cmakebuild
cmake -DCMAKE_BUILD_TYPE=Release ..
make

# Create symlinks to most useful binaries
bento4_bin_dir=$bento4_install_path/cmakebuild
binaries=(mp4dump mp4edit mp4fragment)
for x in ${binaries[@]}; do
    ln -s -f $bento4_bin_dir/$x $HOME/.local/bin
done
